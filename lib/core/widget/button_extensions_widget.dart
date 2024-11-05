import 'package:flutter/material.dart';
import 'package:task_end/core/library/theme_helper.dart';

extension ElevatedButtonExtension on ElevatedButton {
  Widget buttonMain({Color? backgroundColor, double width = double.infinity, double height = 47, double marginVertical = 0, double marginHorizontal = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          shadowColor: ThemeHelper.blackColor,
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  Widget buttonSecondary({double width = double.infinity, double height = 47, double marginVertical = 0, double marginHorizontal = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          shadowColor: ThemeHelper.whiteColor,
          backgroundColor: ThemeHelper.whiteColor,
          side: const BorderSide(
            color: ThemeHelper.blackColor,
            width: 2,
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

extension OutlinedButtonExtension on OutlinedButton {
  Widget buttonBorder({
    double width = double.infinity,
    double height = 48,
    double marginVertical = 0,
    double marginHorizontal = 16,
    Color? borderColor,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertical, horizontal: marginHorizontal),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width - 0.1, height - 0.1),
          maximumSize: Size(width, height),
          backgroundColor: color,
          side: BorderSide(color: borderColor ?? ThemeHelper.mainColor, width: 1.6),
          textStyle: const TextStyle(
            color: ThemeHelper.captionColor,
          ),
        ),
        onPressed: onPressed,
        child: child ?? const Offstage(),
      ),
    );
  }
}
