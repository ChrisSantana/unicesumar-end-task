import 'package:flutter/material.dart';
import 'package:task_end/core/library/theme_helper.dart';

class IconButtonCircleWidget extends StatelessWidget {
  final IconData icon;
  final EdgeInsets? padding;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool showWidget;
  final double iconSize;

  const IconButtonCircleWidget({
    super.key,
    required this.icon,
    this.padding,
    this.iconColor,
    this.onPressed,
    this.showWidget = true,
    this.backgroundColor,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const Offstage();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButtonTheme(
        data: _createIconButtonThemeData(),
        child: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  IconButtonThemeData _createIconButtonThemeData() {
    if (backgroundColor == null) return ThemeHelper.theme.iconButtonTheme;
    return IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
      ),
    );
  }
}
