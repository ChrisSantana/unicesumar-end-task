import 'package:flutter/material.dart';
import 'package:task_end/core/library/theme_helper.dart';

enum CheckboxAlignEnum {
  left,
  right,
}

class CheckBoxWidget extends StatefulWidget {
  final bool value;
  final Widget? title;
  final Color? borderColor;
  final Color? checkColor;
  final Color? activeColor;
  final void Function(bool? value)? onChanged;
  final CheckboxAlignEnum align;
  final EdgeInsets? padding;
  final bool expanded;
  final bool showAsCard;

  const CheckBoxWidget({
    super.key,
    this.value = false,
    this.title,
    this.borderColor,
    this.checkColor,
    this.activeColor,
    this.onChanged,
    this.align = CheckboxAlignEnum.right,
    this.padding,
    this.expanded = true,
    this.showAsCard = false,
  });
  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool _initialValue = false;

  @override
  void initState() {
    super.initState();
    _updateInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = widget.borderColor ?? ThemeHelper.whiteColor;
    final Color checkColor = widget.checkColor ?? ThemeHelper.whiteColor;
    switch (widget.align) {
      case CheckboxAlignEnum.left:
        return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: InkWell(
            child: _CheckboxAlignLeft(
              title: widget.title,
              value: _initialValue,
              borderColor: borderColor,
              checkColor: checkColor,
              activeColor: widget.activeColor,
              expanded: widget.expanded,
              showAsCard: widget.showAsCard,
              onChanged: _onChanged,
            ),
            onTap: () {
              _onChanged(!_initialValue);
            },
          ),
        );
      case CheckboxAlignEnum.right:
        return Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: InkWell(
            child: _CheckboxAlignRight(
              title: widget.title,
              value: _initialValue,
              borderColor: borderColor,
              checkColor: checkColor,
              activeColor: widget.activeColor,
              expanded: widget.expanded,
              showAsCard: widget.showAsCard,
              onChanged: widget.onChanged != null ? _onChanged : (_) {},
            ),
            onTap: () {
              _onChanged(!_initialValue);
            },
          ),
        );
    }
  }

  void _onChanged(bool? value) {
    if (widget.onChanged == null) return;
    _initialValue = value ?? false;
    widget.onChanged!(_initialValue);
    setState(() {});
  }

  void _updateInitialValue() {
    _initialValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CheckBoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateInitialValue();
  }
}

class _CheckboxAlignLeft extends StatelessWidget {
  final bool value;
  final Widget? title;
  final Color borderColor;
  final Color checkColor;
  final Color? activeColor;
  final bool expanded;
  final bool showAsCard;
  final void Function(bool?)? onChanged;

  const _CheckboxAlignLeft({
    required this.value,
    required this.title,
    required this.borderColor,
    required this.checkColor,
    required this.activeColor,
    required this.expanded,
    required this.showAsCard,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = title ?? const Offstage();
    return Card(
      elevation: showAsCard ? 1.1 : 0,
      color: showAsCard ? ThemeHelper.whiteColor : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(showAsCard ? 8 : 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CheckboxWidget(
              value: value,
              borderColor: borderColor,
              checkColor: checkColor,
              activeColor: activeColor,
              onChanged: onChanged,
            ),
            expanded ? Expanded(child: titleWidget) : titleWidget,
          ],
        ),
      ),
    );
  }
}

class _CheckboxAlignRight extends StatelessWidget {
  final bool value;
  final Widget? title;
  final Color borderColor;
  final Color checkColor;
  final Color? activeColor;
  final bool expanded;
  final bool showAsCard;
  final void Function(bool?)? onChanged;

  const _CheckboxAlignRight({
    required this.value,
    required this.title,
    required this.borderColor,
    required this.checkColor,
    required this.activeColor,
    required this.expanded,
    required this.showAsCard,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Widget titleWidget = title ?? const Offstage();
    return Card(
      elevation: showAsCard ? 1.1 : 0,
      color: showAsCard ? ThemeHelper.whiteColor : ThemeHelper.transparentColor,
      child: Padding(
        padding: EdgeInsets.all(showAsCard ? 8 : 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            expanded ? Expanded(child: titleWidget) : titleWidget,
            _CheckboxWidget(
              value: value,
              borderColor: borderColor,
              checkColor: checkColor,
              activeColor: activeColor,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckboxWidget extends StatelessWidget {
  final bool value;
  final Color borderColor;
  final Color checkColor;
  final Color? activeColor;
  final void Function(bool?)? onChanged;

  const _CheckboxWidget({
    required this.value,
    required this.borderColor,
    required this.checkColor,
    required this.activeColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      checkColor: checkColor,
      activeColor: activeColor,
      onChanged: onChanged,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(
        color: borderColor,
      ),
    );
  }
}
