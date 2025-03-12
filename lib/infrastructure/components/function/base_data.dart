import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FontFamilyType {
  FontFamilyType._();
  static String? primary = GoogleFonts.plusJakartaSans().fontFamily;
}

class PlaceHolderImage {
  PlaceHolderImage._();
  static String image =
      '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';
}

class ZFFontSizeCustom {
  ZFFontSizeCustom._();
  static double labelSmall = 11.0;
  static double labelMedium = 12.0;
  static double labelLarge = 14.0;
  static double bodySmall = 12.0;
  static double bodyMedium = 14.0;
  static double bodyLarge = 16.0;
  static double titleSmall = 14.0;
  static double titleMedium = 18.0;
  static double titleLarge = 22.0;
  static double headlineSmall = 24.0;
  static double headlineMedium = 28.0;
  static double headlineLarge = 32.0;
  static double displaySmall = 36.0;
  static double displayMedium = 45.0;
  static double displayLarge = 57.0;
}

class ResponsiveGetX {
  ResponsiveGetX._();
  static double maxWidth = 600;
  static bool mobile = Get.width <= 600;
  static bool tablet = Get.width <= 800;
  static bool desktop = Get.width <= 1000;

  late int responsiveNumber;
}

class ColorPalettes {
  ColorPalettes._();
  static Color primary = const Color(0xFF00CD70);
  static Color primaryContainer = const Color(0xFF00AE50);
  static Color secondary = const Color(0xFFFFFFFF);
  static Color secondaryContainer = const Color(0xFFF3FFF9);
  static Color tertiary = const Color(0xFF263238);
  static Color tertiaryContainer = const Color(0xFF263238);
  static Color fourth = const Color(0xFFBFBFBF);
}

class ColorData {
  ColorData._();
  static Color primary = const Color(0xFF00CD70);
  static Color primaryAccent = const Color(0xFF00AE50);
  static Color secondary = const Color(0xFFFFFFFF);
  static Color secondaryAccent = const Color(0xFFF3FFF9);
  static Color tertiary = const Color(0xFF263238);
  static Color tertiaryAccent = const Color(0xFF263238);
  static Color fourth = const Color(0xFFBFBFBF);

  static Color background = const Color(0xFFF5F5F5);
  static Color backgroundAccent = const Color(0xFFE0E0E0);
  static Color foreground = const Color(0xFF000000);
  static Color foregroundAccent = const Color(0xFF757575);
  static Color error = const Color(0xFFD32F2F);
  static Color errorAccent = const Color(0xFFFFCDD2);
  static Color success = const Color(0xFF388E3C);
  static Color successAccent = const Color(0xFFC8E6C9);
  static Color warning = const Color(0xFFFFA000);
  static Color warningAccent = const Color(0xFFFFF8E1);
  static Color info = const Color(0xFF1976D2);
  static Color infoAccent = const Color(0xFFBBDEFB);
  static Color transparent = const Color(0x00000000);
  static Color appBarColor = const Color(0xFF609966);
  static Color blackBackground = const Color(0xFF000000);
  static Color whiteBackground = const Color(0xFFFFFFFF);
  static Color footerBackground = const Color(0xFF0B0B0B);
  static Color card = const Color(0xFFFFFFFF);
  static Color cardAccent = const Color(0xFFE0E0E0);
  static Color cardShadow = const Color(0xFF000000);
  static Color cardShadowAccent = const Color(0x33000000);
  static Color cardBorder = const Color(0xFF000000);
  static Color cardBorderAccent = const Color(0xFFE0E0E0);
  static Color cardTitle = const Color(0xFF000000);
  static Color cardTitleAccent = const Color(0xFF757575);
  static Color cardSubtitle = const Color(0xFF000000);
  static Color cardSubtitleAccent = const Color(0xFF757575);
  static Color cardContent = const Color(0xFF000000);
  static Color cardContentAccent = const Color(0xFF757575);
}

class ZFBaseColors {
  ZFBaseColors._();
  static Color gradient1 = const Color(0xFF00CD70);
  static Color gradient2 = const Color.fromARGB(255, 0, 149, 70);
  static Color primary = const Color.fromARGB(255, 199, 0, 0);
  static Color primaryContainer = const Color.fromARGB(255, 255, 205, 205);
  static Color secondary = const Color(0xFFFEB716);
  static Color secondaryContainer = const Color(0xFFFFDEA5);
  static Color tertiary = const Color(0xFF0093C7);
  static Color tertiaryContainer = const Color(0xFFC3E7FF);
  static Color error = const Color(0xFFBA1B1B);
  static Color errorContainer = const Color.fromARGB(255, 255, 246, 212);
  static Color success = const Color(0xff4caf50);
  static Color info = const Color(0xff2196f3);
  static Color warning = const Color(0xffff9800);
  static Color transparent = Colors.transparent;
  static Color background = const Color.fromARGB(255, 240, 240, 240);
  static Color appBarColor = const Color(0xff609966);
  static Color blackBackground = const Color(0xff000000);
  static Color whiteBackground = const Color.fromARGB(255, 1, 12, 19);
  static Color footerBackground = const Color.fromARGB(255, 11, 11, 11);
  static Color card = const Color.fromARGB(255, 255, 255, 255);
}

class ZFTextColors {
  ZFTextColors._();
  static Color textBlack = const Color(0xff000000);
  static Color textBlackOp = const Color(0xff000000).withOpacity(0.5);
  static Color textWhite = const Color(0xffffffff);
  static Color textWhiteOp = const Color(0xffffffff).withOpacity(0.5);
}

class ZFButtonColors {
  ZFButtonColors._();
  static Color buttonPrimaryColor = const Color(0xffE3562A);
  static Color buttonColorBlue = const Color(0xff4681F4);
  static Color buttonColorGreen = const Color(0xff33B249);
  static Color buttonColorYellow = const Color(0xffF5B500);
  static Color buttonColorRed = const Color(0xffED0800);
}

class ZFOtherColors {
  ZFOtherColors._();
  static const Color silver = Color(0xFFC0C0C0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color beige = Color(0xFFA8A878);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color blue = Color(0xFF429BED);
  static const Color brown = Color(0xFFB1736C);
  static const Color darkBrown = Color(0xD0795548);
  static const Color darkGrey = Color(0xFF303943);
  static const Color darkRed = Color.fromARGB(255, 166, 39, 39);
  static const Color darkGreen = Color(0xFF4E8234);
  static const Color grey = Color(0x64303943);
  static const Color indigo = Color(0xFF6C79DB);
  static const Color lightBlue = Color(0xFF7AC7FF);
  static const Color lightBrown = Color(0xFFCA8179);
  static const Color whiteGrey = Color(0xFFFDFDFD);
  static const Color lightCyan = Color(0xFF98D8D8);
  static const Color lightGreen = Color(0xFF78C850);
  static const Color lighterGrey = Color(0xFFF4F5F4);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color lightPink = Color(0xFFEE99AC);
  static const Color lightPurple = Color(0xFF9F5BBA);
  static const Color lightRed = Color(0xFFFB6C6C);
  static const Color lightTeal = Color(0xFF48D0B0);
  static const Color lightYellow = Color(0xFFFFCE4B);
  static const Color lime = Color(0xFFA8B820);
  static const Color green = Color.fromARGB(255, 76, 175, 80);
  static const Color lilac = Color(0xFFA890F0);
  static const Color pink = Color(0xFFF85888);
  static const Color purple = Color(0xFF7C538C);
  static const Color red = Color.fromARGB(255, 232, 42, 21);
  static const Color teal = Color(0xFF4FC1A6);
  static const Color yellow = Color(0xFFF6C747);
  static const Color semiGrey = Color(0xFFbababa);
  static const Color violet = Color(0xD07038F8);
}
