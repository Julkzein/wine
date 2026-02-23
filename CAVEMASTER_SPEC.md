# CaveMaster — Wine Cellar Management App

> **Version:** 1.0 (Complete Specification)
> **Target Platforms:** iOS (primary) + Android (simultaneous via Flutter)
> **Framework:** Flutter 3.24+ with Dart
> **Status:** Pre-development — ready for implementation

---

## 1. Product Vision & Design Philosophy

CaveMaster is a premium wine cellar organizer for wine enthusiasts who want to manage, visualize, and optimize their wine collection. It combines a clean, modern UI with powerful features: a **3D cellar visualizer**, intelligent **drink-now recommendations**, **wine label scanning** (not barcode — label image recognition), and rich **collection statistics**.

### Design Principles

- **Clean & modern**: Minimal chrome, generous whitespace, subtle animations. Dark-mode first.
- **Not too much**: Every screen serves a purpose. Progressive disclosure of complexity.
- **Wine-appropriate palette**: Deep burgundy accents, warm neutrals, matte blacks.
- **Tactile**: Haptic feedback on scan, smooth transitions, gesture-driven navigation.
- **Offline-first**: The app works fully without internet. Cloud sync is optional.

---

## 2. Technology Stack (Decided)

| Layer | Technology | Package / Version |
|-------|-----------|-------------------|
| **Framework** | Flutter | 3.24+ (Dart 3.5+) |
| **State Management** | Riverpod | `flutter_riverpod` ^2.x |
| **Local Database** | Drift (SQLite) | `drift` ^2.31 + `sqlite3_flutter_libs` |
| **Cloud Backend** | Supabase | `supabase_flutter` ^2.x |
| **Offline Sync** | Brick | `brick_offline_first_with_supabase` |
| **3D Cellar** | Platform Views | iOS: RealityKit/SceneKit · Android: Filament/SceneView |
| **Label Scanning** | Hybrid approach | On-device OCR (Google ML Kit) + cloud API (API4AI) fallback |
| **OCR Engine** | Google ML Kit | `google_mlkit_text_recognition` ^0.14.x |
| **Camera** | Camera controller | `camera` ^0.11.x |
| **Charts** | fl_chart | `fl_chart` ^0.70.x |
| **Navigation** | GoRouter | `go_router` ^14.x |
| **Notifications** | flutter_local_notifications | + `firebase_messaging` for push |
| **Image Handling** | cached_network_image | + `image_picker` for label photos |
| **Animations** | Rive + Lottie | `rive` + `lottie` |
| **CI/CD** | Codemagic | + Fastlane for store submission |
| **Fonts** | Google Fonts | `google_fonts` (Playfair Display for headings) |

### Why Flutter (not React Native or Native)

- **3D**: Platform views embed native RealityKit (iOS) / SceneView (Android) at full GPU performance while sharing ~90% of app code in Dart.
- **Performance**: Impeller renderer achieves ~1.72ms frame times vs ~16.65ms in RN benchmarks. Critical for smooth 3D cellar rotation.
- **Barcode/Label scanning**: `google_mlkit_text_recognition` runs on-device OCR via Apple Vision (iOS) and ML Kit (Android) natively through platform channels.
- **Offline-first**: Drift + Brick/Supabase is a proven, production-tested stack for offline-first Flutter apps (officially featured in Supabase docs).
- **Speed**: Single codebase deploys to both iOS and Android simultaneously. Hot reload is sub-second.
- **Ecosystem maturity**: Flutter is the most-used cross-platform framework for the 4th consecutive year (~30% of new free iOS apps).

---

## 3. Wine Data Strategy

### The Problem

No single wine database is comprehensive. Wine data is fragmented across dozens of sources. Every successful wine app (Vivino, CellarTracker, Oeni, InVintory) combines multiple data sources with community contributions. Our strategy must do the same.

### Label Scanning Pipeline (Primary Wine Input Method)

Label scanning is **more valuable than barcode scanning** for wine — every bottle has a label, but only ~50% have barcodes. This is the primary way users will add wines.

#### Step 1: On-Device OCR (Free, Instant, Offline)

```
User takes photo of wine label
→ Google ML Kit Text Recognition (on-device, no network needed)
→ Extracts text blocks: producer name, wine name, vintage year, appellation, alcohol %, country
→ Structured parsing via regex + NLP heuristics:
    - 4-digit number (1900-2099) → vintage
    - "AOC", "DOC", "DOCG", "AVA", "Grand Cru" patterns → appellation
    - "% vol" or "% alc" → alcohol content
    - Known region/country patterns → origin
→ Fuzzy-match extracted text against local wine database
→ If confident match (>80%): pre-fill wine entry form
→ If low confidence: show extracted text + ask user to confirm/correct
```

#### Step 2: Cloud Label Recognition API (Paid, Higher Accuracy)

If on-device OCR doesn't produce a confident match, optionally call a cloud API:

**Primary: API4AI Wine Recognition**
- ~400,000 known wine labels
- Returns: brand name, wine type (Cabernet Sauvignon, Merlot, etc.), confidence score
- Available on RapidAPI with free tier
- Cloud-based, requires internet
- REST API: POST image → JSON response

**Alternative: API4AI Alcohol Label Recognition**
- Broader coverage (wine + beer + spirits)
- Returns: winery, country, variety, vintage, region
- Works without pre-populating a database (out-of-the-box)

**Expensive/Enterprise: TinEye WineEngine**
- Best accuracy in the industry, handles blurry/rotated photos
- Requires you to build your own reference image database (BYO-DB model)
- Starts at $200-500/month — too expensive for MVP
- Consider for scale if app succeeds

#### Step 3: Manual Entry with Smart Autocomplete

If both OCR and cloud API fail to identify the wine:
- Pre-fill whatever was extracted (vintage, text fragments)
- Autocomplete powered by local wine reference database
- User fills in remaining fields
- **This user-contributed data enriches our database for future scans**

#### Step 4: Community Contribution Layer

Every wine added (by any method) enriches the database:
- Store the label photo alongside wine metadata
- Build a local image fingerprint index over time
- Future: on-device image similarity matching against user-contributed label photos

### Wine Reference Database (Seed Data)

To power autocomplete, search, and fuzzy matching, we need a seed database of wine reference data. **Sources to combine:**

| Source | Data Available | License | How to Use |
|--------|---------------|---------|------------|
| **Open Food Facts** | ~14K wines, barcode→name, basic info | ODbL (open) | Barcode fallback, basic metadata |
| **Systembolaget API** | ~3K wines, grapes, taste descriptors, organic labels | Free/open | Seed European wine data |
| **Vinmonopolet API** | ~3K wines, detailed metadata | Free (API key) | Seed Nordic wine data |
| **Wikidata/DBpedia** | Grape varieties, appellations, region hierarchies | CC0/open | Reference taxonomies, autocomplete |
| **Wine-Searcher API** | 8M+ wines, critic scores, pricing | 100 free calls/day, paid tiers | On-demand pricing/scores lookup |
| **WineVybe API** | Regions, varieties, tasting notes, food pairings | RapidAPI subscription | Supplementary metadata |
| **User contributions** | Grows over time | App-owned | Core long-term strategy |

### Wine Data Model

```dart
// Core wine entity
class Wine {
  // Identity
  final String id;               // UUID
  final String name;              // e.g., "Château Margaux"
  final int? vintage;             // e.g., 2018 (null for NV)
  final String? labelImagePath;   // Local path to label photo
  
  // Classification
  final WineType type;            // Red, White, Rosé, Sparkling, Dessert, Fortified, Orange, Natural
  final String? country;
  final String? region;
  final String? subRegion;
  final String? appellation;      // e.g., "AOC Margaux"
  
  // Producer
  final String? producer;
  final String? winemaker;
  
  // Grape Composition
  final List<GrapeComposition> grapes;  // [{variety: "Cabernet Sauvignon", percentage: 75}]
  
  // Characteristics
  final double? alcoholContent;   // e.g., 13.5
  final int? bodyScore;           // 1-5 (Light to Full)
  final int? tanninLevel;         // 1-5
  final int? acidityLevel;        // 1-5
  final int? sweetnessLevel;      // 1-5
  
  // Drinking Window
  final int? drinkFrom;           // Year
  final int? drinkUntil;          // Year
  final int? peakFrom;            // Year
  final int? peakUntil;           // Year
  final AgingPotential? agingPotential;
  
  // Collection Info
  final int quantity;             // Bottles in cellar
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? purchaseLocation;
  
  // Storage
  final String? cellarId;         // Reference to cellar
  final int? rackRow;
  final int? rackColumn;
  final int? rackDepth;
  
  // Personal
  final double? userRating;       // 0-5 half-star increments
  final String? tastingNotes;
  final String? personalNotes;
  final List<String> tags;        // User-defined: "gift", "special occasion"
  final List<String> foodPairings;
  final bool isFavorite;
  
  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;
  final WineSource source;        // Manual, LabelScan, Import
}

enum WineType { red, white, rose, sparkling, dessert, fortified, orange, natural }
enum AgingPotential { drinkNow, short1to3, medium3to7, long7to15, veryLong15plus }
enum WineSource { manual, labelScan, import_ }
```

---

## 4. Feature Specification

### 4.1 Wine Collection Management (CRUD)

#### Add Wine — Two Paths

**Path A: Label Scan (Primary)**
1. User taps "+" → "Scan Label"
2. Camera activates with overlay guide showing label frame area
3. User takes photo or auto-capture on focus
4. Haptic feedback on capture
5. On-device OCR extracts text → parse structured fields
6. If online and OCR confidence < 80%: call API4AI for cloud recognition
7. Show pre-filled form with confidence indicators per field
8. User confirms/corrects fields, adjusts quantity, assigns cellar position
9. Save wine + store label photo locally

**Path B: Manual Entry**
1. User taps "+" → "Add Manually"
2. Progressive form with smart defaults:
   - Screen 1: Name, Producer, Vintage, Type (required minimum)
   - Screen 2: Region, Appellation, Grapes (autocomplete from DB)
   - Screen 3: Drinking window, Price, Quantity
   - Screen 4: Photo (camera/gallery), Notes, Tags
3. Autocomplete powered by local wine reference database
4. Save

#### Collection List View

- Default: Card grid with label photo, name, vintage, type color badge
- Alternative: Compact list view (toggle)
- Sort: Name, Vintage, Rating, Price, Date Added, Drink-by Date
- Filter: Type, Country, Region, Grape, Rating, Price Range, Tags, Drinking Status
- Search: Full-text across name, producer, region, notes
- Bulk actions: Select multiple → Move, Delete, Export
- Swipe left → Delete | Swipe right → "Drink" (decrement quantity + log)

#### Wine Detail View

- Hero: Label photo (or elegant type-colored placeholder)
- Key info card: Name, vintage, producer, type, region
- **Drinking window timeline**: Visual bar showing where current year sits relative to drink window (green=peak, amber=within window, red=past)
- **Characteristics radar chart**: Body, Tannin, Acidity, Sweetness (via fl_chart)
- Tasting notes section (expandable)
- Food pairings as chips/tags
- Price & purchase info
- Cellar position with mini 3D preview link
- Action buttons: **Drink** (decrements + optional tasting log), **Edit**, **Share**

### 4.2 3D Wine Cellar Visualizer

The flagship differentiating feature. Users visualize their cellar in interactive 3D.

#### Implementation Strategy: Flutter Platform Views + Native 3D

The 3D cellar is rendered using **native platform views** embedded in Flutter:
- **iOS**: `UiKitView` wrapping a `SCNView` (SceneKit) or `RealityView` (RealityKit)
- **Android**: `AndroidView` wrapping a `SceneView` (Filament-based)

This gives native GPU performance while the rest of the app is pure Dart/Flutter.

#### Cellar Data Model

```dart
class Cellar {
  final String id;
  final String name;              // "Main Cellar", "Kitchen Rack"
  final CellarType type;          // WineRack, WineFridge, CustomShelving
  final int rows;
  final int columns;
  final int depth;                // Bottles deep per slot (1-3)
  final List<CellarZone>? zones;  // Optional temperature zones
}

class CellarSlot {
  final int row;
  final int column;
  final int depth;
  final String? wineId;           // null = empty
  final bool isBlocked;           // Structural gap
}

enum CellarType { wineRack, wineFridge, customShelving, stackedCases }
```

#### 3D Visualization Features

- **Color-coded bottles**: By type (red=red, white=gold, rosé=pink, sparkling=silver) or by drinking status (green=ready, amber=soon, red=past peak, blue=aging)
- **Tap a bottle** → Quick popup: name, vintage, drinking status
- **Long press** → Navigate to full wine detail
- **Drag to rotate/zoom** cellar view (smooth spring physics)
- **Empty slots** clearly visible (dimmed/outlined)
- **Search highlight**: Search a wine → its position glows/pulses in 3D
- **Filter overlay**: Dim non-matching bottles when filters active

#### Cellar Setup Flow

1. Wizard: "What type of storage?" → select from templates
2. Set dimensions: rows × columns × depth
3. Pre-built templates for common racks (5×10, 8×12, etc.)
4. Support multiple cellars/racks
5. Assign wines: tap slot → search wine → place

#### 3D Implementation Details for Flutter Platform Views

**iOS Native Side (Swift):**
```
CellarSceneView: UIView {
  - SCNScene with bottle meshes (low-poly cylinders with color materials)
  - SCNNode hierarchy: Rack frame → Slot nodes → Bottle nodes
  - Gesture recognizers: Pan (rotate), Pinch (zoom), Tap (select)
  - FlutterMethodChannel for Dart↔Swift communication:
    - Dart→Swift: updateCellarData(json), highlightBottle(slotId), setColorMode(mode)
    - Swift→Dart: onBottleTapped(slotId), onBottleLongPressed(slotId)
}
```

**Android Native Side (Kotlin):**
```
CellarSceneView: FrameLayout {
  - SceneView (Filament-based) with programmatic 3D scene
  - Same communication pattern via MethodChannel
}
```

**Flutter Side:**
```dart
// Platform view widget
class CellarView3D extends StatelessWidget {
  Widget build(context) {
    if (Platform.isIOS) {
      return UiKitView(viewType: 'cellar_3d_view', creationParams: cellarData);
    } else {
      return AndroidView(viewType: 'cellar_3d_view', creationParams: cellarData);
    }
  }
}
```

### 4.3 Smart Recommendations Engine

#### Recommendation Categories

**"Drink Now" 🟢** — Wines currently in peak drinking window, sorted by urgency (closest to end of peak first).

**"Drink Soon" 🟡** — Wines approaching end of overall drinking window. Alert threshold: 6 months.

**"Keep Aging" 🔵** — Wines not yet in window. Show progress: "3 of 7 years aged."

**"Past Peak" 🔴** — Wines past their drinking window. Gentle suggestion to drink soon.

**"Tonight's Pick"** — Daily suggestion algorithm:

```
Priority Score = 
  (urgency_weight × days_until_window_closes) +
  (peak_bonus × is_in_peak_window) +
  (diversity_bonus × days_since_type_last_drunk) +
  (food_pairing_score × if_meal_specified) +
  (user_rating × personal_preference_weight)
```

Optional: "What are you eating tonight?" → food pairing match from collection.

#### Notifications

- Weekly digest: "This week's picks from your cellar"
- Urgency alerts: "3 bottles approaching end of drinking window"
- Milestone: "Your 2018 Barolo has reached its peak window!"
- Implementation: `flutter_local_notifications` + optional `firebase_messaging` for push

### 4.4 Collection Statistics & Analytics

Dashboard with these widget sections (all built with `fl_chart`):

**Collection Overview** — Total bottles (trend arrow), estimated value, bottles added/consumed this month.

**Distribution Charts** — By type (donut), by country (horizontal bar), by vintage (histogram), by grape (treemap or bar).

**Drinking Window Status** — Stacked bar: Ready Now / Drink Soon / Keep Aging / Past Peak with counts.

**Consumption Analytics** — Monthly consumption (trailing 12mo bar chart), average rate, most-consumed type, "At current rate, cellar lasts X months."

**Value Analytics** — Total value over time (line chart), most valuable bottles top-5, cost vs estimated value.

**Taste Profile** — Radar chart of average characteristics by preferences, "You tend to rate [Burgundy] highest."

### 4.5 Label Scanning (Detailed Flow)

```
┌─────────────────────────────────────────────────┐
│                  CAMERA VIEW                      │
│                                                   │
│    ┌───────────────────────────────────┐          │
│    │                                   │          │
│    │        LABEL FRAME GUIDE          │          │
│    │     (semi-transparent overlay)    │          │
│    │                                   │          │
│    └───────────────────────────────────┘          │
│                                                   │
│              [Auto-capture on focus]              │
│              [Manual capture button]              │
└─────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────┐
│            ON-DEVICE OCR (Step 1)                │
│                                                   │
│  google_mlkit_text_recognition processes image    │
│  → Extract all text blocks with bounding boxes    │
│  → Parse with wine-specific heuristics:           │
│    • Vintage: regex /\b(19|20)\d{2}\b/           │
│    • Appellation: pattern matching AOC/DOC/etc    │
│    • Alcohol: regex /\d{1,2}[.,]\d?\s*%/         │
│    • Producer: largest/topmost text block         │
│    • Wine name: second largest text block         │
│  → Fuzzy match against local DB (Levenshtein)     │
│  → Confidence score per field                     │
└─────────────────────────────────────────────────┘
                      │
            ┌─────────┴─────────┐
            │ Confidence ≥ 80%? │
            └─────────┬─────────┘
              Yes │          │ No (+ online)
                  ▼          ▼
┌──────────────────┐  ┌──────────────────────────┐
│ SHOW PRE-FILLED  │  │  CLOUD API CALL (Step 2)  │
│ CONFIRMATION     │  │                            │
│ (user confirms)  │  │  API4AI Wine/Alcohol Rec   │
│                  │  │  POST label image → JSON   │
│                  │  │  Returns: brand, type,     │
│                  │  │  variety, country, vintage  │
│                  │  │  Merge with OCR results     │
└────────┬─────────┘  └─────────────┬──────────────┘
         │                          │
         ▼                          ▼
┌─────────────────────────────────────────────────┐
│           WINE ENTRY FORM                        │
│                                                   │
│  Fields pre-filled with scanned data              │
│  Confidence badges: ✅ high / ⚠️ medium / ❓ low  │
│  User corrects any wrong fields                   │
│  Adds: quantity, cellar position, notes, rating   │
│  [Save to Collection]                             │
└─────────────────────────────────────────────────┘
```

### 4.6 Secondary Features

**Tasting Journal** — Log notes each time a wine is opened ("Drink" action). Structured: Appearance, Nose, Palate, Finish + free-form notes + photo + rating.

**Wishlist** — Save wines to buy. Fields: Name, Producer, Vintage, Est. Price, Priority, Notes. Convert to collection on purchase.

**Import/Export** — Import: CSV, Vivino export, CellarTracker export. Export: CSV, PDF report. Column mapping UI for CSV.

**Multi-Cellar Support** — Multiple storage locations, each with own 3D visualization. Overview aggregates all cellars.

**Offline Support** — Full collection browsable offline. Add/edit wines offline → sync when connected. Label scan OCR works offline (cloud API queued). 3D cellar works offline.

---

## 5. UI/UX Design System

### 5.1 Color Palette

```dart
// Dark Mode (Primary)
static const background = Color(0xFF0D0D0D);       // Near-black
static const surfacePrimary = Color(0xFF1A1A1A);    // Cards, sheets
static const surfaceSecondary = Color(0xFF252525);  // Input fields
static const accent = Color(0xFF8B2252);            // Burgundy primary
static const accentLight = Color(0xFFC75B7A);       // Burgundy highlight
static const textPrimary = Color(0xFFF5F5F5);
static const textSecondary = Color(0xFFA0A0A0);
static const success = Color(0xFF4CAF50);           // Drink now
static const warning = Color(0xFFFF9800);           // Drink soon
static const danger = Color(0xFFF44336);            // Past peak
static const info = Color(0xFF2196F3);              // Keep aging

// Wine type colors (for badges and 3D bottles)
static const wineRed = Color(0xFF722F37);
static const wineWhite = Color(0xFFE8D5A3);
static const wineRose = Color(0xFFE8A0B4);
static const wineSparkling = Color(0xFFC0C0C0);
static const wineDessert = Color(0xFFDAA520);
static const wineFortified = Color(0xFF8B4513);
static const wineOrange = Color(0xFFE8923F);
```

### 5.2 Typography

```dart
// System fonts for performance, serif accent for wine names
static const headingFont = 'Playfair Display';  // Via google_fonts — wine names, titles
static const bodyFont = null;                    // SF Pro (iOS) / Roboto (Android) — system default

// Scale
static const displayLarge = 32.0;   // Screen titles
static const displayMedium = 24.0;  // Section headers
static const titleLarge = 20.0;     // Wine names
static const titleMedium = 16.0;    // Card titles
static const bodyLarge = 16.0;      // Body text
static const bodyMedium = 14.0;     // Secondary text
static const labelSmall = 12.0;     // Badges, captions
```

### 5.3 Navigation Structure

```
Tab Bar (4 tabs):
├── Collection (Home)                 // Index page
│   ├── Grid/List toggle of all wines
│   ├── Search + Filter bar (sticky)
│   └── Wine Detail (push route)
│       ├── Drinking timeline
│       ├── Characteristics radar
│       └── Actions: Drink, Edit, Share
│
├── Cellar (3D)
│   ├── Cellar selector dropdown (if multiple)
│   ├── 3D Visualization (full screen platform view)
│   ├── Color mode toggle (by type / by drinking status)
│   └── Cellar settings/config (gear icon)
│
├── Discover
│   ├── "Tonight's Pick" hero card
│   ├── "Drink Now" carousel
│   ├── "Drink Soon" list
│   ├── "Keep Aging" list
│   └── Wishlist (sub-tab or section)
│
└── Stats
    ├── Collection overview cards
    ├── Distribution charts (swipeable)
    ├── Consumption analytics
    └── Taste profile radar

Floating Action Button: "+" (globally visible)
├── Scan Label (camera icon)
└── Add Manually (pen icon)

Settings (accessible from profile/gear icon):
├── Profile / Account (optional sign-in)
├── Cellar Management (add/edit/delete cellars)
├── Notifications preferences
├── Import / Export
├── Appearance (dark/light/system, units °C/°F)
├── Data & Privacy
└── About / Support
```

### 5.4 Key Interactions

- **Swipe actions** on wine cards: Left → Delete, Right → "Drink" (decrement)
- **Long press** on wine card: Quick actions context menu
- **Pull to refresh** on collection list (sync if online)
- **Shared element transitions**: Wine card → Detail view hero animation
- **Skeleton screens** during loading (not spinners)
- **Haptic feedback**: Scan success, wine added, wine drunk
- **Empty states**: Beautiful illustrations + clear CTAs for empty collection/cellar

---

## 6. Project Structure

```
cavemaster/
├── android/                          # Android native code
│   └── app/src/main/kotlin/
│       └── com/cavemaster/
│           └── CellarSceneViewFactory.kt   # 3D cellar Android
├── ios/                              # iOS native code
│   └── Runner/
│       └── CellarSceneView.swift           # 3D cellar iOS (SceneKit)
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # MaterialApp + theme + router
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart        # ThemeData (dark + light)
│   │   │   ├── colors.dart           # Color constants
│   │   │   └── typography.dart       # Text styles
│   │   ├── router/
│   │   │   └── app_router.dart       # GoRouter configuration
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   └── wine_constants.dart   # Wine types, regions, grapes reference
│   │   └── utils/
│   │       ├── date_utils.dart
│   │       ├── wine_parser.dart      # OCR text → structured wine data
│   │       ├── fuzzy_match.dart      # Levenshtein distance for wine matching
│   │       └── formatters.dart       # Price, volume, etc.
│   │
│   ├── data/
│   │   ├── database/
│   │   │   ├── app_database.dart     # Drift database definition
│   │   │   ├── app_database.g.dart   # Generated
│   │   │   ├── tables/
│   │   │   │   ├── wines_table.dart
│   │   │   │   ├── cellars_table.dart
│   │   │   │   ├── cellar_slots_table.dart
│   │   │   │   ├── tasting_notes_table.dart
│   │   │   │   ├── wishlist_table.dart
│   │   │   │   └── grape_compositions_table.dart
│   │   │   └── daos/
│   │   │       ├── wine_dao.dart
│   │   │       ├── cellar_dao.dart
│   │   │       └── stats_dao.dart
│   │   ├── repositories/
│   │   │   ├── wine_repository.dart
│   │   │   ├── cellar_repository.dart
│   │   │   └── stats_repository.dart
│   │   ├── services/
│   │   │   ├── label_scan_service.dart    # OCR + cloud API orchestration
│   │   │   ├── wine_database_service.dart # External API lookups
│   │   │   ├── recommendation_service.dart
│   │   │   ├── sync_service.dart          # Brick/Supabase sync
│   │   │   └── notification_service.dart
│   │   └── models/
│   │       ├── wine.dart
│   │       ├── cellar.dart
│   │       ├── cellar_slot.dart
│   │       ├── tasting_note.dart
│   │       ├── wishlist_entry.dart
│   │       └── scan_result.dart
│   │
│   ├── presentation/
│   │   ├── providers/                # Riverpod providers
│   │   │   ├── wine_providers.dart
│   │   │   ├── cellar_providers.dart
│   │   │   ├── stats_providers.dart
│   │   │   ├── recommendation_providers.dart
│   │   │   └── scan_providers.dart
│   │   ├── screens/
│   │   │   ├── collection/
│   │   │   │   ├── collection_screen.dart
│   │   │   │   ├── wine_detail_screen.dart
│   │   │   │   └── wine_form_screen.dart
│   │   │   ├── cellar/
│   │   │   │   ├── cellar_screen.dart
│   │   │   │   ├── cellar_config_screen.dart
│   │   │   │   └── cellar_3d_view.dart   # Platform view wrapper
│   │   │   ├── discover/
│   │   │   │   ├── discover_screen.dart
│   │   │   │   └── wishlist_screen.dart
│   │   │   ├── stats/
│   │   │   │   └── stats_screen.dart
│   │   │   ├── scan/
│   │   │   │   ├── label_scan_screen.dart
│   │   │   │   └── scan_result_screen.dart
│   │   │   └── settings/
│   │   │       ├── settings_screen.dart
│   │   │       └── import_export_screen.dart
│   │   └── widgets/
│   │       ├── common/
│   │       │   ├── app_scaffold.dart
│   │       │   ├── search_bar.dart
│   │       │   ├── empty_state.dart
│   │       │   ├── skeleton_loader.dart
│   │       │   └── confirmation_dialog.dart
│   │       ├── wine/
│   │       │   ├── wine_card.dart
│   │       │   ├── wine_grid.dart
│   │       │   ├── wine_type_badge.dart
│   │       │   ├── drinking_timeline.dart
│   │       │   ├── characteristics_radar.dart
│   │       │   └── food_pairing_chips.dart
│   │       ├── charts/
│   │       │   ├── type_distribution_chart.dart
│   │       │   ├── vintage_histogram.dart
│   │       │   ├── consumption_chart.dart
│   │       │   ├── value_chart.dart
│   │       │   └── taste_profile_radar.dart
│   │       └── cellar/
│   │           ├── cellar_selector.dart
│   │           └── slot_popup.dart
│   │
│   └── l10n/                         # Localization (English first)
│       └── app_en.arb
│
├── assets/
│   ├── images/                       # Empty states, placeholders
│   ├── animations/                   # Rive/Lottie files
│   └── data/
│       ├── grape_varieties.json      # Seeded from Wikidata
│       ├── appellations.json         # AOC/DOC/AVA reference
│       ├── regions.json              # Country → Region → Sub-region hierarchy
│       └── wine_seed_db.json         # Initial wine reference data
│
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── pubspec.yaml
├── analysis_options.yaml
└── codemagic.yaml                    # CI/CD configuration
```

---

## 7. Database Schema (Drift)

```dart
// wines_table.dart
class Wines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get type => textEnum<WineType>()();
  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get subRegion => text().nullable()();
  TextColumn get appellation => text().nullable()();
  TextColumn get producer => text().nullable()();
  TextColumn get winemaker => text().nullable()();
  RealColumn get alcoholContent => real().nullable()();
  IntColumn get bodyScore => integer().nullable()();
  IntColumn get tanninLevel => integer().nullable()();
  IntColumn get acidityLevel => integer().nullable()();
  IntColumn get sweetnessLevel => integer().nullable()();
  IntColumn get drinkFrom => integer().nullable()();
  IntColumn get drinkUntil => integer().nullable()();
  IntColumn get peakFrom => integer().nullable()();
  IntColumn get peakUntil => integer().nullable()();
  TextColumn get agingPotential => textEnum<AgingPotential>().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  TextColumn get purchaseLocation => text().nullable()();
  TextColumn get cellarId => text().nullable().references(Cellars, #id)();
  IntColumn get rackRow => integer().nullable()();
  IntColumn get rackColumn => integer().nullable()();
  IntColumn get rackDepth => integer().nullable()();
  TextColumn get labelImagePath => text().nullable()();
  RealColumn get userRating => real().nullable()();
  TextColumn get tastingNotes => text().nullable()();
  TextColumn get personalNotes => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))(); // JSON array
  TextColumn get foodPairings => text().withDefault(const Constant('[]'))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get source => textEnum<WineSource>()();

  @override
  Set<Column> get primaryKey => {id};
}

// cellars_table.dart
class Cellars extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => textEnum<CellarType>()();
  IntColumn get rows => integer()();
  IntColumn get columns => integer()();
  IntColumn get depth => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// cellar_slots_table.dart
class CellarSlots extends Table {
  TextColumn get cellarId => text().references(Cellars, #id)();
  IntColumn get row => integer()();
  IntColumn get column => integer()();
  IntColumn get depth => integer()();
  TextColumn get wineId => text().nullable().references(Wines, #id)();
  BoolColumn get isBlocked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {cellarId, row, column, depth};
}

// tasting_notes_table.dart
class TastingNotes extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text().references(Wines, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get appearance => text().nullable()();
  TextColumn get nose => text().nullable()();
  TextColumn get palate => text().nullable()();
  TextColumn get finish => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get rating => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get occasion => text().nullable()();
  TextColumn get foodPaired => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// grape_compositions_table.dart
class GrapeCompositions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wineId => text().references(Wines, #id)();
  TextColumn get variety => text()();
  RealColumn get percentage => real().nullable()();
}

// wishlist_table.dart
class WishlistEntries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get producer => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  RealColumn get estimatedPrice => real().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
```

---

## 8. Key Implementation Algorithms

### 8.1 Wine Text Parser (OCR Output → Structured Data)

```dart
class WineParser {
  static ScanResult parseOcrText(List<TextBlock> blocks) {
    final allText = blocks.map((b) => b.text).join('\n');
    
    // Extract vintage (4-digit year 1900-2099)
    final vintageMatch = RegExp(r'\b(19|20)\d{2}\b').firstMatch(allText);
    final vintage = vintageMatch != null ? int.parse(vintageMatch.group(0)!) : null;
    
    // Extract alcohol content
    final alcoholMatch = RegExp(r'(\d{1,2}[.,]\d?)\s*%\s*(vol|alc)?', caseSensitive: false)
        .firstMatch(allText);
    final alcohol = alcoholMatch != null 
        ? double.parse(alcoholMatch.group(1)!.replaceAll(',', '.')) : null;
    
    // Extract appellation patterns
    final appellationPatterns = [
      RegExp(r'(A\.?O\.?C\.?\s+\w[\w\s-]+)', caseSensitive: false),    // AOC
      RegExp(r'(D\.?O\.?C\.?G?\.?\s+\w[\w\s-]+)', caseSensitive: false), // DOC/DOCG
      RegExp(r'(Grand\s+Cru|Premier\s+Cru)', caseSensitive: false),
      RegExp(r'(Appellation\s+[\w\s-]+\s+Contrôlée)', caseSensitive: false),
    ];
    String? appellation;
    for (final pattern in appellationPatterns) {
      final match = pattern.firstMatch(allText);
      if (match != null) { appellation = match.group(0)!.trim(); break; }
    }
    
    // Sort text blocks by size (area) — largest likely = producer/wine name
    final sortedBlocks = List<TextBlock>.from(blocks)
      ..sort((a, b) {
        final areaA = a.boundingBox!.width * a.boundingBox!.height;
        final areaB = b.boundingBox!.width * b.boundingBox!.height;
        return areaB.compareTo(areaA);
      });
    
    final producer = sortedBlocks.isNotEmpty ? sortedBlocks[0].text : null;
    final wineName = sortedBlocks.length > 1 ? sortedBlocks[1].text : null;
    
    return ScanResult(
      rawText: allText,
      producer: producer,
      wineName: wineName,
      vintage: vintage,
      alcoholContent: alcohol,
      appellation: appellation,
      confidence: _calculateConfidence(vintage, producer, wineName),
    );
  }
  
  static double _calculateConfidence(int? vintage, String? producer, String? name) {
    double score = 0;
    if (vintage != null) score += 0.3;
    if (producer != null && producer.length > 2) score += 0.35;
    if (name != null && name.length > 2) score += 0.35;
    return score;
  }
}
```

### 8.2 Recommendation Algorithm

```dart
class RecommendationService {
  List<Wine> getRecommendations(List<Wine> collection, {String? mealType}) {
    final currentYear = DateTime.now().year;
    
    return collection
      .where((w) => w.quantity > 0)
      .map((wine) {
        double score = 0;
        
        // Urgency: wines near end of window score highest
        if (wine.drinkUntil != null) {
          final yearsLeft = wine.drinkUntil! - currentYear;
          if (yearsLeft <= 0) score += 100;      // Past peak — urgent
          else if (yearsLeft <= 1) score += 80;  // Within 1 year
          else if (yearsLeft <= 3) score += 50;  // Within 3 years
        }
        
        // Peak bonus
        if (wine.peakFrom != null && wine.peakUntil != null) {
          if (currentYear >= wine.peakFrom! && currentYear <= wine.peakUntil!) {
            score += 40; // In peak window
          }
        }
        
        // User rating boost
        if (wine.userRating != null) score += wine.userRating! * 5;
        
        // Food pairing match
        if (mealType != null && wine.foodPairings.contains(mealType)) {
          score += 30;
        }
        
        return MapEntry(wine, score);
      })
      .toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  }
  
  DrinkingStatus getDrinkingStatus(Wine wine) {
    final year = DateTime.now().year;
    if (wine.drinkFrom == null && wine.drinkUntil == null) return DrinkingStatus.unknown;
    if (wine.drinkUntil != null && year > wine.drinkUntil!) return DrinkingStatus.pastPeak;
    if (wine.peakFrom != null && wine.peakUntil != null &&
        year >= wine.peakFrom! && year <= wine.peakUntil!) return DrinkingStatus.peak;
    if (wine.drinkFrom != null && year >= wine.drinkFrom!) return DrinkingStatus.drinkNow;
    if (wine.drinkUntil != null && wine.drinkUntil! - year <= 2) return DrinkingStatus.drinkSoon;
    return DrinkingStatus.keepAging;
  }
}
```

---

## 9. Development Phases

### Phase 1 — Foundation (Weeks 1-4)
- [ ] Project setup: Flutter, Drift, Riverpod, GoRouter, theming
- [ ] Database schema implementation + code generation
- [ ] Wine CRUD: Add manually, edit, delete
- [ ] Wine detail view with drinking timeline + characteristics radar
- [ ] Collection list with search, sort, filter
- [ ] Basic dark mode theme + design system components
- [ ] Seed data: grape varieties, regions, appellations JSON files

### Phase 2 — Label Scanning + Intelligence (Weeks 5-8)
- [ ] Camera integration with label frame overlay
- [ ] On-device OCR via Google ML Kit
- [ ] Wine text parser (OCR → structured data)
- [ ] API4AI cloud recognition integration (fallback)
- [ ] Fuzzy matching against local DB
- [ ] Scan result → pre-filled wine form flow
- [ ] Smart recommendations engine
- [ ] Discover screen: Tonight's Pick, Drink Now/Soon/Aging lists
- [ ] Tasting journal (Drink action → log tasting notes)

### Phase 3 — 3D Cellar (Weeks 9-13)
- [ ] Cellar configuration wizard (type, dimensions, templates)
- [ ] iOS native: SceneKit cellar view + Flutter platform view bridge
- [ ] Android native: SceneView/Filament cellar view + bridge
- [ ] 3D rendering: rack frame, bottle meshes, color coding
- [ ] Interactivity: rotate, zoom, tap bottle, long press
- [ ] Color mode toggle (by type / by drinking status)
- [ ] Search highlight (bottle pulses in 3D)
- [ ] Wine assignment: tap slot → assign wine

### Phase 4 — Statistics + Polish (Weeks 14-17)
- [ ] Full statistics dashboard with fl_chart
- [ ] Distribution charts, consumption analytics, taste profile
- [ ] Wishlist feature
- [ ] Import/Export (CSV at minimum)
- [ ] Notifications (local: drinking window alerts, weekly digest)
- [ ] Onboarding flow (3-4 screens explaining features)
- [ ] Empty states with illustrations
- [ ] Animations: shared element transitions, chart entrances
- [ ] Haptic feedback throughout

### Phase 5 — Cloud + Launch (Weeks 18-20)
- [ ] Supabase setup: schema, auth, storage
- [ ] Brick offline-first sync integration
- [ ] Optional sign-in (Apple, Google, Email)
- [ ] Cloud backup/restore
- [ ] Label image upload to Supabase Storage
- [ ] Codemagic CI/CD pipeline
- [ ] Beta testing (TestFlight + Firebase App Distribution)
- [ ] App Store + Play Store submission
- [ ] App Store Optimization (screenshots, description, keywords)

---

## 10. Deployment & CI/CD

### Codemagic Configuration

```yaml
# codemagic.yaml
workflows:
  ios-release:
    name: iOS Release
    max_build_duration: 60
    instance_type: mac_mini_m2
    environment:
      flutter: stable
      xcode: latest
      cocoapods: default
      groups:
        - app_store_credentials
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Build iOS
        script: flutter build ipa --release
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      app_store_connect:
        auth: integration
        submit_to_testflight: true

  android-release:
    name: Android Release
    max_build_duration: 60
    instance_type: mac_mini_m2
    environment:
      flutter: stable
      java: 17
      groups:
        - google_play_credentials
    scripts:
      - name: Install dependencies
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Build Android
        script: flutter build appbundle --release
    artifacts:
      - build/app/outputs/bundle/release/*.aab
    publishing:
      google_play:
        credentials: $GCLOUD_SERVICE_ACCOUNT_CREDENTIALS
        track: internal
```

### Expected App Size

- Base Flutter: ~5-7 MB
- ML Kit text recognition model: ~3-5 MB
- 3D assets (low-poly): ~2-3 MB
- Other dependencies: ~3-5 MB
- **Total estimated download: 15-25 MB** (split APK for Android)

---

## 11. Monetization (Optional — Decide Later)

**Free Tier**: Up to 50 wines, 1 cellar, basic stats, label scanning, manual entry.

**Premium ($3.99/mo or $29.99/yr)**: Unlimited wines/cellars, 3D visualization, full analytics, smart recommendations with notifications, cloud sync, import/export.

---

## 12. Open Questions

- [ ] API4AI pricing for production scale (contact for quote beyond free tier)
- [ ] 3D cellar level of detail: photorealistic bottles vs stylized low-poly (recommend starting low-poly for performance)
- [ ] Community features (v2): share tasting notes, compare cellars, "what should I bring" for dinner
- [ ] AI sommelier chatbot (v2): Claude API integration for wine pairing questions
- [ ] Wine price tracking via Wine-Searcher API (requires paid tier for volume)
- [ ] Localization: French first (given Swiss user base), then expand

---

*This document is the single source of truth for the CaveMaster project. Claude Code and all LLM assistants should reference this spec for feature scope, architecture, data models, and implementation decisions.*
