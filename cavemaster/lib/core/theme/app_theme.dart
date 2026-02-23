import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.dark,
          surface: AppColors.surfacePrimary,
          onSurface: AppColors.textPrimary,
          primary: AppColors.accent,
          onPrimary: AppColors.textPrimary,
          secondary: AppColors.accentLight,
          onSecondary: AppColors.textPrimary,
          error: AppColors.danger,
        ).copyWith(
          surface: AppColors.background,
          surfaceContainerLowest: AppColors.background,
          surfaceContainerLow: AppColors.surfacePrimary,
          surfaceContainer: AppColors.surfacePrimary,
          surfaceContainerHigh: AppColors.surfaceSecondary,
          surfaceContainerHighest: AppColors.surfaceTertiary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfacePrimary,
          selectedItemColor: AppColors.accentLight,
          unselectedItemColor: AppColors.textDisabled,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfacePrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceSecondary,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
          ),
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          hintStyle: const TextStyle(color: AppColors.textDisabled),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.accentLight,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceSecondary,
          labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: AppColors.surfacePrimary,
          textColor: AppColors.textPrimary,
          iconColor: AppColors.textSecondary,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surfaceTertiary,
          contentTextStyle: const TextStyle(color: AppColors.textPrimary),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.accent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.textPrimary,
          elevation: 4,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surfacePrimary,
          modalBackgroundColor: AppColors.surfacePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surfacePrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.surfaceSecondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 22),
        extensions: const [],
      );

  static ThemeData get light => dark.copyWith(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F4F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F4F0),
          foregroundColor: Color(0xFF1A1A1A),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      );
}
