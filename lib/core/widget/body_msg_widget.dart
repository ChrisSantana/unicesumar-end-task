import 'package:flutter/material.dart';
import 'package:task_end/core/library/theme_helper.dart';
import 'package:task_end/core/widget/text_extension_widget.dart' show TextExtension;

class BodyMsgWidget extends StatelessWidget {
  final String msg;
  final Color? textColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  final IconData? icon;
  final double? height;
  final MainAxisAlignment? mainAxisAlignment;

  const BodyMsgWidget({
    super.key,
    required this.msg,
    this.icon,
    this.textColor,
    this.iconColor,
    this.padding,
    this.height,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.sizeOf(context).height * 0.45,
      margin: padding ?? const EdgeInsets.all(26),
      color: ThemeHelper.backgroundColor,
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: <Widget>[
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: Icon(
                    icon,
                    size: 50,
                    color: iconColor,
                  ),
                )
              : const Offstage(),
          Text(
            msg,
          ).font16W500(color: textColor, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
