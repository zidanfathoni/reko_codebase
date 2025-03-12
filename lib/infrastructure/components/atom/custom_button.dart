import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reko_codebase/infrastructure/components/atom/custom_text.dart';

import '../function/config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onPressed, this.color, this.textColor});

  final String title;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final FontType fontType = FontType.bodyLarge;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color,
      borderRadius: BorderRadius.circular(16),
      pressedOpacity: 0.5,
      alignment: Alignment.center,

      onPressed: onPressed,
      disabledColor: Colors.grey.shade400,
      key: key,
      child: CustomText(text: title, fontType: fontType, colorText: textColor),
    );
    // : ElevatedButton(
    //   style: ButtonStyle(
    //     backgroundColor: WidgetStateProperty.all<Color>(color!),
    //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //     ),
    //   ),
    //   onPressed: () {},
    //   child: CustomText(text: title, fontType: fontType, colorText: textColor),
    // );
  }
}
