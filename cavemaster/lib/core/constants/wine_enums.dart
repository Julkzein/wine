enum WineType {
  red,
  white,
  rose,
  sparkling,
  dessert,
  fortified,
  orange,
  natural;

  String get label => switch (this) {
        red => 'Red',
        white => 'White',
        rose => 'Rosé',
        sparkling => 'Sparkling',
        dessert => 'Dessert',
        fortified => 'Fortified',
        orange => 'Orange',
        natural => 'Natural',
      };

  String get emoji => switch (this) {
        red => '🍷',
        white => '🥂',
        rose => '🌸',
        sparkling => '🍾',
        dessert => '🍯',
        fortified => '🥃',
        orange => '🟠',
        natural => '🌿',
      };
}

enum CellarType {
  wineRack,
  wineFridge,
  customShelving,
  stackedCases;

  String get label => switch (this) {
        wineRack => 'Wine Rack',
        wineFridge => 'Wine Fridge',
        customShelving => 'Custom Shelving',
        stackedCases => 'Stacked Cases',
      };
}

enum AgingPotential {
  drinkNow,
  short1to3,
  medium3to7,
  long7to15,
  veryLong15plus;

  String get label => switch (this) {
        drinkNow => 'Drink Now',
        short1to3 => '1–3 years',
        medium3to7 => '3–7 years',
        long7to15 => '7–15 years',
        veryLong15plus => '15+ years',
      };
}

enum WineSource {
  manual,
  labelScan,
  import_;

  String get label => switch (this) {
        manual => 'Manual Entry',
        labelScan => 'Label Scan',
        import_ => 'Import',
      };
}

enum DrinkingStatus {
  peak,
  drinkNow,
  drinkSoon,
  keepAging,
  pastPeak,
  unknown;

  String get label => switch (this) {
        peak => 'Peak',
        drinkNow => 'Drink Now',
        drinkSoon => 'Drink Soon',
        keepAging => 'Keep Aging',
        pastPeak => 'Past Peak',
        unknown => 'Unknown',
      };
}

enum WineSortField {
  name,
  vintage,
  rating,
  price,
  dateAdded,
  drinkBy;

  String get label => switch (this) {
        name => 'Name',
        vintage => 'Vintage',
        rating => 'My Rating',
        price => 'Price',
        dateAdded => 'Date Added',
        drinkBy => 'Drink By',
      };
}
