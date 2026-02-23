# CaveMaster — Implementation Plan & Architecture

> Companion document to `CAVEMASTER_SPEC.md`
> This document provides the **how** — concrete steps, architecture decisions, and task breakdowns.

---

## 1. Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                      │
│                                                               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐        │
│  │Collection│ │  Cellar  │ │ Discover │ │  Stats   │        │
│  │  Screen  │ │  Screen  │ │  Screen  │ │  Screen  │        │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘        │
│       │             │             │             │              │
│  ┌────┴─────────────┴─────────────┴─────────────┴──────┐     │
│  │              RIVERPOD PROVIDERS                      │     │
│  │  wine_providers · cellar_providers · stats_providers │     │
│  │  recommendation_providers · scan_providers           │     │
│  └──────────────────────┬──────────────────────────────┘     │
└──────────────────────────┼───────────────────────────────────┘
                           │
┌──────────────────────────┼───────────────────────────────────┐
│                    DATA / SERVICE LAYER                        │
│                           │                                   │
│  ┌────────────────────────┴────────────────────────────┐     │
│  │              REPOSITORIES                            │     │
│  │  wine_repo · cellar_repo · stats_repo               │     │
│  └──────┬─────────────┬──────────────┬─────────────────┘     │
│         │             │              │                         │
│  ┌──────┴──────┐ ┌────┴────┐ ┌──────┴───────────┐           │
│  │  Drift DB   │ │  Brick  │ │    Services       │           │
│  │  (SQLite)   │ │  Sync   │ │  label_scan       │           │
│  │  Local-     │ │  Engine │ │  recommendation    │           │
│  │  first      │ │         │ │  wine_database     │           │
│  └─────────────┘ └────┬────┘ │  notification      │           │
│                        │      └──────┬──────────────┘           │
└────────────────────────┼─────────────┼──────────────────────┘
                         │             │
┌────────────────────────┼─────────────┼──────────────────────┐
│                   EXTERNAL LAYER     │                        │
│                        │             │                        │
│  ┌─────────────────────┴──┐  ┌───────┴──────────────┐       │
│  │     Supabase Cloud     │  │   External APIs      │       │
│  │  · PostgreSQL (data)   │  │  · API4AI (label rec) │       │
│  │  · Auth (accounts)     │  │  · Wine-Searcher     │       │
│  │  · Storage (images)    │  │  · Open Food Facts   │       │
│  └────────────────────────┘  └──────────────────────┘       │
└──────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────┐
│                   NATIVE PLATFORM LAYER                       │
│                                                               │
│  ┌─────────────────────┐    ┌─────────────────────┐          │
│  │    iOS (Swift)       │    │  Android (Kotlin)    │          │
│  │  · SceneKit 3D View │    │  · SceneView 3D View │          │
│  │  · MethodChannel ↔  │    │  · MethodChannel ↔   │          │
│  │    Flutter bridge    │    │    Flutter bridge     │          │
│  └─────────────────────┘    └─────────────────────┘          │
└──────────────────────────────────────────────────────────────┘
```

---

## 2. Data Flow Architecture

### 2.1 Label Scan Flow

```
User taps "Scan Label"
        │
        ▼
┌─────────────────┐
│  Camera Screen   │
│  (camera pkg)    │
│  Label overlay   │
└────────┬────────┘
         │ capture
         ▼
┌─────────────────────────┐
│  LabelScanService       │
│                         │
│  1. MLKit OCR           │──── On-device, offline, free
│     → TextBlock[]       │     Apple Vision (iOS)
│                         │     Google ML Kit (Android)
│  2. WineParser          │
│     → ScanResult        │──── Regex + heuristics
│     {producer, name,    │     See CAVEMASTER_SPEC.md §8.1
│      vintage, alcohol,  │
│      appellation,       │
│      confidence}        │
│                         │
│  3. FuzzyMatch against  │──── Levenshtein distance
│     local Drift DB      │     against wines + reference data
│                         │
│  4. IF confidence < 80% │
│     AND online:         │
│     → API4AI POST image │──── Cloud fallback
│     → merge results     │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  ScanResultScreen        │
│  Pre-filled wine form    │
│  Confidence badges       │
│  User confirms/corrects  │
│  [Save]                  │
└────────┬────────────────┘
         │
         ▼
┌─────────────────────────┐
│  WineRepository.insert() │
│  → Drift (local SQLite)  │
│  → Brick queues sync     │
│  → Supabase (when online)│
└─────────────────────────┘
```

### 2.2 Offline-First Sync Flow

```
┌──────────────────────────────────────────────────────┐
│                    CLIENT (Flutter)                    │
│                                                        │
│  ┌─────────────┐     ┌─────────────┐                 │
│  │  Drift DB   │◄───►│  Brick OFL  │                 │
│  │  (SQLite)   │     │  Adapter    │                 │
│  │  Source of   │     │  Offline    │                 │
│  │  truth for  │     │  Queue +    │                 │
│  │  reads      │     │  Sync logic │                 │
│  └─────────────┘     └──────┬──────┘                 │
│                              │                         │
│                    ┌─────────┴─────────┐              │
│                    │ Online? ──► Sync  │              │
│                    │ Offline? ──► Queue│              │
│                    └─────────┬─────────┘              │
└──────────────────────────────┼────────────────────────┘
                               │ HTTPS
                               ▼
┌──────────────────────────────────────────────────────┐
│                  SUPABASE CLOUD                       │
│                                                        │
│  ┌──────────────┐  ┌───────────┐  ┌────────────┐    │
│  │  PostgreSQL   │  │   Auth    │  │  Storage   │    │
│  │  wines        │  │  Apple    │  │  Label     │    │
│  │  cellars      │  │  Google   │  │  photos    │    │
│  │  slots        │  │  Email    │  │  Bottle    │    │
│  │  tastings     │  │           │  │  photos    │    │
│  │  wishlist     │  │           │  │            │    │
│  └──────────────┘  └───────────┘  └────────────┘    │
│                                                        │
│  Row Level Security: user_id = auth.uid()             │
└──────────────────────────────────────────────────────┘
```

---

## 3. Detailed Task Breakdown

### Phase 1: Foundation (Weeks 1-4)

#### Week 1: Project Setup + Database

| Task | Details | Est. Hours |
|------|---------|-----------|
| Create Flutter project | `flutter create cavemaster`, configure `analysis_options.yaml`, add `.gitignore` | 1h |
| Add core dependencies | Drift, Riverpod, GoRouter, fl_chart, google_fonts, cached_network_image, image_picker, uuid | 1h |
| Design system: colors + typography | Create `colors.dart`, `typography.dart`, `app_theme.dart` with dark + light ThemeData | 3h |
| Design system: base components | `AppScaffold`, `SearchBar`, `EmptyState`, `SkeletonLoader`, `ConfirmationDialog` | 4h |
| Drift database setup | Define all 6 tables (wines, cellars, slots, tastings, grapes, wishlist), run code generation | 4h |
| DAOs | `WineDao` (CRUD + search + filter queries), `CellarDao`, `StatsDao` (aggregation queries) | 4h |
| Seed data files | Create `grape_varieties.json`, `regions.json`, `appellations.json` from Wikidata exports | 3h |

#### Week 2: Wine CRUD + Collection Screen

| Task | Details | Est. Hours |
|------|---------|-----------|
| Wine model | Dart model class with fromDb/toDb converters, JSON serialization | 2h |
| WineRepository | Abstraction over WineDao, handles business logic (quantity updates, etc.) | 3h |
| Riverpod wine providers | `winesProvider`, `wineByIdProvider`, `filteredWinesProvider`, `searchWinesProvider` | 3h |
| Add Wine form (manual) | Multi-step form: basic info → details → characteristics → photo/notes. Autocomplete for regions, grapes | 6h |
| Collection screen | Grid view with `WineCard` widgets, toggle to list view, sticky search bar | 4h |
| Sort + Filter | Sort dropdown (name, vintage, rating, date), filter bottom sheet (type, country, rating range) | 3h |
| Swipe actions | Dismissible: swipe left delete (with confirmation), swipe right "Drink" | 2h |

#### Week 3: Wine Detail + Drinking Timeline

| Task | Details | Est. Hours |
|------|---------|-----------|
| Wine Detail screen | Hero label image, info card, action buttons (Drink, Edit, Share) | 4h |
| Drinking timeline widget | Custom painter: horizontal bar with current year marker, color-coded segments (aging/ready/peak/past) | 4h |
| Characteristics radar chart | fl_chart RadarChart: body, tannin, acidity, sweetness axes | 3h |
| Food pairing chips | Wrap widget with styled Chip elements, tap to filter collection by pairing | 2h |
| Wine type badge | Colored badge component with wine glass icon per type | 1h |
| Edit wine | Pre-filled form from existing wine data, save updates | 2h |
| "Drink" action flow | Decrement quantity, optionally show tasting note form, haptic feedback | 3h |

#### Week 4: Navigation + Polish

| Task | Details | Est. Hours |
|------|---------|-----------|
| GoRouter configuration | Define all routes: tabs, detail, form, scan, settings. Nested navigation for tabs | 3h |
| Tab bar | Bottom navigation with 4 tabs + icons. Custom active/inactive styling | 2h |
| FAB (Floating Action Button) | Global "+" button with expand animation: "Scan Label" + "Add Manually" | 2h |
| Shared element transitions | Hero animations from wine card → detail screen (label image morphing) | 3h |
| Skeleton loaders | Shimmer loading states for collection list, detail view | 2h |
| Empty states | Illustrated empty state for: no wines, no cellar, no recommendations | 3h |
| Unit tests | Wine model, WineParser, RecommendationService, DrinkingStatus logic | 4h |

---

### Phase 2: Label Scanning + Intelligence (Weeks 5-8)

#### Week 5: Camera + On-Device OCR

| Task | Details | Est. Hours |
|------|---------|-----------|
| Camera setup | `camera` package integration, permissions handling (iOS Info.plist + Android manifest) | 3h |
| Label scan screen | Camera preview with semi-transparent overlay frame guide, capture button, flash toggle | 4h |
| Google ML Kit integration | Add `google_mlkit_text_recognition`, configure iOS (exclude armv7) and Android | 2h |
| OCR processing | Capture image → InputImage → TextRecognizer → List<TextBlock> | 3h |
| WineParser implementation | Full parser from spec §8.1: vintage, alcohol, appellation, producer/name extraction | 5h |
| Confidence scoring | Calculate per-field and overall confidence based on extraction quality | 2h |

#### Week 6: Cloud API + Fuzzy Matching

| Task | Details | Est. Hours |
|------|---------|-----------|
| API4AI integration | HTTP client for Wine Recognition API. POST image → parse JSON response (brand, type, confidence) | 3h |
| LabelScanService orchestration | Chain: OCR → parse → fuzzy match → (optional) cloud API → merge results | 4h |
| Fuzzy matching | Levenshtein distance matching against local wine DB (names, producers). Configurable threshold | 4h |
| Scan result screen | Pre-filled form with confidence badges (✅/⚠️/❓) per field, edit-in-place | 4h |
| Scan → save flow | Confirm → save wine with label photo → navigate to detail view | 2h |
| Offline handling | OCR works offline. Cloud API call queued if offline, manual entry fallback | 2h |

#### Week 7: Recommendations Engine

| Task | Details | Est. Hours |
|------|---------|-----------|
| RecommendationService | Full algorithm from spec §8.2: urgency, peak bonus, diversity, food pairing, rating | 4h |
| DrinkingStatus calculator | Determine status per wine: peak/drinkNow/drinkSoon/keepAging/pastPeak/unknown | 2h |
| Recommendation providers | `tonightsPickProvider`, `drinkNowProvider`, `drinkSoonProvider`, `keepAgingProvider` | 3h |
| Discover screen | "Tonight's Pick" hero card, horizontal carousels for each category | 5h |
| Food pairing prompt | Optional "What are you eating?" input → filter recommendations by pairing | 3h |
| Drinking window alerts | Query wines with drinkUntil within 6 months → highlight on Discover | 2h |

#### Week 8: Tasting Journal

| Task | Details | Est. Hours |
|------|---------|-----------|
| Tasting note model + DAO | CRUD for TastingNotes table with wine relationship | 2h |
| Tasting form | Structured: Appearance, Nose, Palate, Finish fields + free notes + rating + photo | 4h |
| "Drink" → tasting flow | When user taps "Drink" on wine: show option to log tasting note first | 2h |
| Tasting history | List of tasting notes per wine on detail screen, sorted by date | 3h |
| Integration tests | Full scan flow, recommendation accuracy, tasting log | 4h |

---

### Phase 3: 3D Cellar (Weeks 9-13)

#### Week 9-10: iOS 3D (SceneKit)

| Task | Details | Est. Hours |
|------|---------|-----------|
| iOS plugin setup | Create `CellarSceneViewFactory` + `CellarSceneView` in Swift, register with Flutter engine | 3h |
| SceneKit scene | Programmatic SCNScene: rack frame geometry (boxes), slot positions, camera + lights | 6h |
| Bottle meshes | Low-poly cylinder/capsule meshes with colored materials per wine type | 4h |
| Gesture recognizers | UIPanGestureRecognizer (rotate), UIPinchGestureRecognizer (zoom), UITapGestureRecognizer (select) | 4h |
| MethodChannel bridge | Dart↔Swift: `updateCellarData(json)`, `highlightBottle(id)`, `setColorMode(mode)` from Dart. `onBottleTapped(id)`, `onBottleLongPressed(id)` to Dart | 4h |
| Flutter PlatformView wrapper | `CellarView3D` widget using `UiKitView`, pass cellar data as creation params | 2h |
| Color coding | Two modes: by wine type (red/white/rosé colors) and by drinking status (green/amber/red/blue) | 3h |

#### Week 11-12: Android 3D (Filament/SceneView)

| Task | Details | Est. Hours |
|------|---------|-----------|
| Android plugin setup | Create `CellarSceneViewFactory` + `CellarSceneView` in Kotlin, register with Flutter engine | 3h |
| SceneView/Filament scene | Equivalent 3D scene in Filament: rack, slots, bottles, camera, lights | 8h |
| Gesture handling | Touch event handling for rotate, zoom, select (Android gesture detectors) | 4h |
| MethodChannel bridge | Same protocol as iOS, Kotlin implementation | 3h |
| Flutter PlatformView | `AndroidView` integration in `CellarView3D` widget | 2h |
| Cross-platform testing | Verify both iOS and Android 3D views render correctly with same data | 3h |

#### Week 13: Cellar Configuration + Integration

| Task | Details | Est. Hours |
|------|---------|-----------|
| Cellar setup wizard | Step 1: type selection (rack/fridge/shelving), Step 2: dimensions, Step 3: name | 4h |
| Pre-built templates | Common rack sizes (5×10, 8×12, 4×6) as quick-select options | 2h |
| Multi-cellar support | Cellar selector dropdown on cellar screen, CRUD for cellars | 3h |
| Wine assignment UI | Tap empty slot in 3D → search modal → select wine → assign to slot | 4h |
| Search highlight | Search wine → 3D view zooms and pulses the bottle's slot | 3h |
| Filter overlay | Apply filter → dim non-matching bottles in 3D (reduce opacity) | 2h |
| Cellar screen layout | Full-screen 3D view with floating controls: color mode toggle, search, settings gear | 2h |

---

### Phase 4: Statistics + Polish (Weeks 14-17)

#### Week 14-15: Statistics Dashboard

| Task | Details | Est. Hours |
|------|---------|-----------|
| StatsDao queries | Aggregate queries: count by type, by country, by vintage, by grape, consumption per month | 4h |
| Stats providers | Riverpod providers computing dashboard data from repository | 3h |
| Collection overview cards | Total bottles, estimated value, monthly added/consumed, trend arrows | 3h |
| Type distribution (donut) | fl_chart PieChart with wine type colors | 2h |
| Country distribution (bar) | fl_chart BarChart, horizontal, sorted by count | 2h |
| Vintage histogram | fl_chart BarChart, vertical, year on x-axis | 2h |
| Drinking status stacked bar | Green/amber/red/blue stacked segments with counts | 2h |
| Consumption timeline | Trailing 12-month bar chart from tasting notes + "drink" actions | 3h |
| Taste profile radar | fl_chart RadarChart: aggregate user ratings by type/region/grape | 3h |
| "Cellar lasts X months" | Calculate from consumption rate + current inventory | 1h |

#### Week 16: Wishlist + Import/Export

| Task | Details | Est. Hours |
|------|---------|-----------|
| Wishlist CRUD | Add/edit/delete wishlist entries, priority sorting | 3h |
| Wishlist screen | List with priority badges, "Convert to wine" action (pre-fills add form) | 3h |
| CSV export | Generate CSV from wine collection with all fields | 3h |
| CSV import | File picker → parse CSV → column mapping UI → bulk insert | 5h |
| PDF export (optional) | Simple collection report PDF using `pdf` package | 3h |

#### Week 17: Polish + Notifications

| Task | Details | Est. Hours |
|------|---------|-----------|
| Local notifications setup | `flutter_local_notifications` configuration for iOS + Android | 2h |
| Drinking window alerts | Weekly check: wines approaching end of window → local notification | 3h |
| Weekly digest | Summary notification: "3 wines are ready to drink this week" | 2h |
| Onboarding flow | 3-4 PageView screens explaining key features with illustrations | 4h |
| Haptic feedback | `HapticFeedback.mediumImpact()` on: scan success, wine added, wine drunk | 1h |
| Animations | Chart staggered entrances, card transitions, FAB expand/collapse | 4h |
| Settings screen | Profile, cellar management, notification prefs, appearance toggle, about | 3h |
| Bug fixes + QA | Comprehensive testing pass across features | 6h |

---

### Phase 5: Cloud + Launch (Weeks 18-20)

#### Week 18: Supabase Backend

| Task | Details | Est. Hours |
|------|---------|-----------|
| Supabase project setup | Create project, configure auth providers (Apple, Google, Email) | 2h |
| Database schema | Create PostgreSQL tables mirroring Drift schema, add `user_id` column, RLS policies | 3h |
| Storage buckets | Create `label-images` and `tasting-photos` buckets with user-scoped policies | 1h |
| Auth integration | `supabase_flutter` setup, sign-in screens (Apple, Google, Email), token management | 4h |

#### Week 19: Offline Sync + Image Upload

| Task | Details | Est. Hours |
|------|---------|-----------|
| Brick adapter setup | Configure `brick_offline_first_with_supabase` for each model | 5h |
| Sync testing | Verify: create offline → sync online, conflict resolution, multi-device | 5h |
| Image upload | On sync: upload label photos to Supabase Storage, store URL in wine record | 3h |
| Sync status UI | Subtle indicator showing sync status (synced/pending/error) | 2h |

#### Week 20: Launch Preparation

| Task | Details | Est. Hours |
|------|---------|-----------|
| Codemagic CI/CD | Configure `codemagic.yaml` for iOS + Android builds, code signing | 3h |
| App icons + splash | Design and configure app icon (all sizes) + splash screen | 2h |
| App Store listing | Screenshots (6.7" + 6.5"), description, keywords, categories | 3h |
| Play Store listing | Feature graphic, screenshots, description, content rating | 2h |
| TestFlight beta | Internal + external beta testing, gather feedback | 4h |
| Final bug fixes | Address beta feedback, edge cases, performance optimization | 6h |
| Submit to stores | App Store Connect + Google Play Console submission | 2h |

---

## 4. Key Technical Decisions & Rationale

### Why Drift over Isar/Hive/Realm?

**Drift** is chosen because wine data is inherently relational (bottles → cellars → slots, wines → grape compositions, wines → tasting notes). Drift provides type-safe SQL with compile-time checking, reactive streams (`watch()` queries that auto-update UI), and excellent support for complex queries (aggregations for stats, full-text search for collection). Isar's original author abandoned the project; Hive was deprecated in favor of Isar; MongoDB deprecated Realm Atlas Device Sync. Drift is the most actively maintained and production-proven option for relational data in Flutter.

### Why Riverpod over BLoC/Provider/GetX?

**Riverpod** is chosen for its compile-time safety (no runtime `ProviderNotFoundException`), natural fit with Drift's reactive queries (stream-based providers), excellent code generation support, and cleaner dependency injection than Provider. BLoC is more boilerplate for no additional benefit at this scale. GetX has questionable maintainability practices.

### Why Brick over PowerSync?

Both are excellent. **Brick** is recommended because it's free (no per-operation costs), officially featured in Supabase documentation for Flutter offline-first apps, and handles the offline queue + SQLite caching transparently. PowerSync is superior for complex multi-user sync scenarios but costs money at scale (free tier: 1M sync ops/month) and is more complex to set up. For a personal wine cellar app where sync is primarily single-user backup/restore, Brick is simpler and sufficient. If multi-device real-time sync becomes critical, PowerSync can be swapped in later since both use SQLite locally.

### Why Platform Views for 3D (not pure Dart)?

Flutter's pure-Dart 3D options (ditredi, flutter_scene) are either too limited for an interactive cellar or require Flutter's master channel. Platform views embedding native SceneKit (iOS) and Filament/SceneView (Android) provide: full GPU-native rendering, established APIs with extensive documentation, ability to leverage ARKit/ARCore in the future (v2), and zero bridge overhead for rendering (only data commands cross the bridge, not frames). The tradeoff is writing ~500-800 lines of native code per platform, which is manageable.

### Why API4AI over TinEye WineEngine?

**API4AI** is chosen for MVP because: it works out-of-the-box with a 400K+ wine database (no need to build your own reference image collection), it's available on RapidAPI with a free tier, and it costs ~$0.01-0.03/request at scale. TinEye WineEngine is technically superior (better accuracy, handles blurry photos) but requires you to build and maintain your own label image database AND starts at $200-500/month — too expensive before product-market fit. If the app scales, WineEngine is the upgrade path.

---

## 5. Environment Setup Checklist

```bash
# 1. Install Flutter
flutter --version  # Verify 3.24+

# 2. Create project
flutter create --org com.cavemaster --platforms ios,android cavemaster
cd cavemaster

# 3. Add dependencies (pubspec.yaml)
flutter pub add drift sqlite3_flutter_libs path_provider
flutter pub add flutter_riverpod go_router
flutter pub add fl_chart google_fonts cached_network_image
flutter pub add image_picker camera
flutter pub add google_mlkit_text_recognition
flutter pub add supabase_flutter
flutter pub add uuid intl
flutter pub add flutter_local_notifications
flutter pub add share_plus url_launcher

# Dev dependencies
flutter pub add --dev drift_dev build_runner flutter_lints

# 4. Run Drift code generation
dart run build_runner build

# 5. iOS setup
cd ios && pod install && cd ..
# Edit Info.plist: add camera permission strings
# Edit Podfile: set platform :ios, '15.5', exclude armv7

# 6. Android setup
# Edit android/app/build.gradle: minSdkVersion 24
# Add camera permissions to AndroidManifest.xml

# 7. Run
flutter run
```

---

## 6. API Configuration

### API4AI Wine Recognition

```dart
// lib/data/services/api4ai_service.dart
class Api4aiService {
  static const _baseUrl = 'https://wine-recognition2.p.rapidapi.com/v1/results';
  // OR direct: 'https://api4ai.cloud/wine-rec/v1/results'
  
  final String _apiKey; // From RapidAPI or API4AI portal
  
  Future<Api4aiResult?> recognizeLabel(File imageFile) async {
    final request = http.MultipartRequest('POST', Uri.parse(_baseUrl))
      ..headers['X-RapidAPI-Key'] = _apiKey
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    
    final response = await request.send();
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      return Api4aiResult.fromJson(jsonDecode(body));
    }
    return null;
  }
}
```

### Supabase Setup

```sql
-- Supabase SQL editor: create tables with RLS

CREATE TABLE wines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  name TEXT NOT NULL,
  vintage INT,
  type TEXT NOT NULL,
  country TEXT,
  region TEXT,
  -- ... (all fields from Drift schema)
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE wines ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can CRUD own wines" ON wines
  FOR ALL USING (auth.uid() = user_id);

-- Repeat for cellars, cellar_slots, tasting_notes, wishlist_entries
```

---

## 7. Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| 3D performance on low-end devices | High | Start with low-poly bottles (<200 triangles). Profile on oldest supported devices. Add LOD (level of detail) reduction for >100 bottles. |
| API4AI accuracy too low | Medium | On-device OCR is the primary path (free, fast). API4AI is fallback. If accuracy insufficient, evaluate WineEngine or custom ML model. |
| Label OCR fails on stylized fonts | Medium | Accept that OCR won't be 100%. Always show manual correction UI. Track scan success rate → improve parser over time. |
| Drift + Brick sync conflicts | Medium | Wine cellar data is single-user in most cases. Last-write-wins is acceptable. Add conflict resolution UI if multi-device issues arise. |
| App Store rejection (3D performance) | Low | Test on oldest supported devices. Ensure 60fps during 3D interaction. Add graceful fallback to 2D grid if 3D crashes. |
| Wine database coverage gaps | High | Accept gaps. Focus on community contribution UX. Every user-added wine enriches the DB. Track "no match" rate → prioritize regions to add. |

---

*Implementation plan is actionable and ready. Start with Phase 1, Week 1. Reference CAVEMASTER_SPEC.md for all feature details, data models, and design specifications.*
