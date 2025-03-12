import 'package:flutter/cupertino.dart';

import '../function/base_data.dart';
import '../function/config.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.maxLines,
    required this.fontType,
    this.colorText,
    this.opacityText,
    this.weight,
    this.textAlign,
    this.decoration,
  });

  final String text;
  final int? maxLines;
  final FontType fontType;
  final Color? colorText;
  final FontWeight? weight;
  final double? opacityText;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    double? fontSizes;
    switch (fontType) {
      case FontType.displayLarge:
        fontSizes = ZFFontSizeCustom.displayLarge;
        break;
      case FontType.displayMedium:
        fontSizes = ZFFontSizeCustom.displayMedium;
        break;
      case FontType.displaySmall:
        fontSizes = ZFFontSizeCustom.displaySmall;
        break;
      case FontType.headlineLarge:
        fontSizes = ZFFontSizeCustom.headlineLarge;
        break;
      case FontType.headlineMedium:
        fontSizes = ZFFontSizeCustom.headlineMedium;
        break;
      case FontType.headlineSmall:
        fontSizes = ZFFontSizeCustom.headlineSmall;
        break;
      case FontType.titleLarge:
        fontSizes = ZFFontSizeCustom.titleLarge;
        break;
      case FontType.titleMedium:
        fontSizes = ZFFontSizeCustom.titleMedium;
        break;
      case FontType.titleSmall:
        fontSizes = ZFFontSizeCustom.titleSmall;
        break;
      case FontType.bodyLarge:
        fontSizes = ZFFontSizeCustom.bodyLarge;
        break;
      case FontType.bodyMedium:
        fontSizes = ZFFontSizeCustom.bodyMedium;
        break;
      case FontType.bodySmall:
        fontSizes = ZFFontSizeCustom.bodySmall;
        break;
      case FontType.labelLarge:
        fontSizes = ZFFontSizeCustom.labelLarge;
        break;
      case FontType.labelMedium:
        fontSizes = ZFFontSizeCustom.labelMedium;
        break;
      case FontType.labelSmall:
        fontSizes = ZFFontSizeCustom.labelSmall;
        break;
    }
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontSizes,
        fontWeight: weight == FontWeight.bold ? FontWeight.w500 : weight,
        overflow: TextOverflow.ellipsis,
        decoration: decoration,
        color: colorText,
      ),
      maxLines: maxLines,
    );
  }
}
