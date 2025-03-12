import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/function/base_data.dart';
import '../config/shared_pref_helper/shared_pref_helper.dart';

class RkTheme {
  RkTheme();

  static ThemeMode themeLight = ThemeMode.light;
  static ThemeMode themeDark = ThemeMode.dark;

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)
  static changeTheme() {
    // *) check if the current theme is light (default is light)
    bool isLightTheme = MySharedPref.getThemeIsLight();

    // *) store the new theme mode on get storage
    MySharedPref.setThemeIsLight(!isLightTheme);

    // *) let GetX change theme
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.amber,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 20.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      snackBarRadius: 20,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: FontFamilyType.primary,
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: FlexColor.schemes[FlexScheme.amber]!.light.defaultError.toDark(0, false),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 20.0,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      snackBarRadius: 20,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: FontFamilyType.primary,
  );
}
