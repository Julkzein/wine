import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'wine_enums.dart';

abstract final class WineConstants {
  static const int minVintage = 1900;
  static const int maxVintage = 2099;
  static const double maxRating = 5.0;
  static const double ratingStep = 0.5;

  // Common food pairing tags
  static const List<String> foodPairingOptions = [
    'Red meat', 'White meat', 'Lamb', 'Pork', 'Beef', 'Veal',
    'Fish', 'Seafood', 'Shellfish', 'Oysters', 'Salmon', 'Tuna',
    'Pasta', 'Pizza', 'Risotto',
    'Cheese', 'Hard cheese', 'Soft cheese', 'Blue cheese',
    'Charcuterie', 'Foie gras',
    'Vegetables', 'Salad', 'Mushrooms', 'Truffle',
    'Dessert', 'Chocolate', 'Fruit tart',
    'Aperitif', 'Tapas',
  ];

  // Countries in display order (most common wine countries first)
  static const List<String> countries = [
    'France', 'Italy', 'Spain', 'Germany', 'Portugal',
    'United States', 'Australia', 'Argentina', 'Chile',
    'South Africa', 'New Zealand', 'Austria', 'Greece',
    'Switzerland', 'Hungary', 'Romania', 'Bulgaria',
    'Georgia', 'Lebanon', 'Israel', 'Uruguay', 'Brazil',
    'Japan', 'Canada', 'United Kingdom',
  ];
}

abstract final class WineTypeColors {
  static Color forType(WineType type) => switch (type) {
        WineType.red => AppColors.wineRed,
        WineType.white => AppColors.wineWhite,
        WineType.rose => AppColors.wineRose,
        WineType.sparkling => AppColors.wineSparkling,
        WineType.dessert => AppColors.wineDessert,
        WineType.fortified => AppColors.wineFortified,
        WineType.orange => AppColors.wineOrange,
        WineType.natural => AppColors.wineNatural,
      };

  static Color textColorForType(WineType type) => switch (type) {
        WineType.white ||
        WineType.sparkling ||
        WineType.rose ||
        WineType.dessert =>
          Colors.black87,
        _ => Colors.white,
      };
}

abstract final class DrinkingStatusColors {
  static Color forStatus(DrinkingStatus status) => switch (status) {
        DrinkingStatus.peak => AppColors.success,
        DrinkingStatus.drinkNow => AppColors.success,
        DrinkingStatus.drinkSoon => AppColors.warning,
        DrinkingStatus.keepAging => AppColors.info,
        DrinkingStatus.pastPeak => AppColors.danger,
        DrinkingStatus.unknown => AppColors.textDisabled,
      };
}
