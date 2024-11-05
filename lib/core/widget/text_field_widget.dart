import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_end/core/library/theme_helper.dart';

class TextFieldWidget extends StatefulWidget {
  final String? label;
  final String? hint;
  final int? maxLines;
  final String? initialValue;
  final Color? colorBorder;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final EdgeInsets? padding;
  final int? maxLength;
  final Color? backgroundColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? center;
  final bool? autoFocus;
  final bool enabled;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String value)? onChanged;
  final FocusNode? focusNode;
  final bool showClose;
  final void Function()? onTap;
  final Widget? topLabel;
  final EdgeInsets? contentPaddingInput;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function()? onEditingComplete;

  const TextFieldWidget({
    super.key,
    this.label,
    this.maxLines = 1,
    this.hint,
    this.initialValue,
    this.colorBorder,
    this.keyboardType,
    this.inputFormatter,
    this.padding,
    this.backgroundColor,
    this.maxLength,
    this.floatingLabelBehavior,
    this.center = false,
    this.enabled = true,
    this.prefix,
    this.autoFocus,
    this.onChanged,
    this.prefixIcon,
    this.focusNode,
    this.suffixIcon,
    this.showClose = false,
    this.onTap,
    this.topLabel,
    this.contentPaddingInput,
    this.onTapOutside,
    this.onEditingComplete,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_handlerController);
    _initialController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(bottom: 20),
      child: TextField(
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus ?? false,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        controller: _textEditingController,
        inputFormatters: widget.inputFormatter,
        decoration: _createInputDecoration(),
        keyboardType: _createBoardType(),
        textAlign: (widget.center ?? false) ? TextAlign.center : TextAlign.left,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        onEditingComplete: widget.onEditingComplete,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  TextInputType? _createBoardType() {
    if (Platform.isAndroid) return widget.keyboardType;

    if ([TextInputType.number, TextInputType.datetime, TextInputType.phone].contains(widget.keyboardType)) {
      return const TextInputType.numberWithOptions(signed: true, decimal: true);
    }

    return widget.keyboardType;
  }

  InputDecoration _createInputDecoration() {
    return InputDecoration(
      labelText: widget.label,
      counterText: '',
      hintText: widget.hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: ThemeHelper.captionColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ),
      prefix: widget.prefix,
      filled: true,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _FactorySuffixIconWidget(
        suffixIcon: widget.suffixIcon,
        showIconClose: widget.showClose,
        controller: _textEditingController,
      ),
      isDense: true,
      contentPadding: widget.contentPaddingInput ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      alignLabelWithHint: false,
      fillColor: widget.enabled ? (widget.backgroundColor ?? ThemeHelper.transparentColor) : ThemeHelper.disabledColor.withOpacity(0.2),
      floatingLabelBehavior: widget.floatingLabelBehavior,
      labelStyle: TextStyle(color: _borderColor, fontSize: 18),
      errorStyle: const TextStyle(color: ThemeHelper.redColor, fontSize: 0),
      prefixStyle: TextStyle(color: _borderColor, fontSize: 16),
      enabledBorder: TextFieldHelper.outlineInputBorder(color: _borderColor),
      disabledBorder: TextFieldHelper.outlineInputBorder(color: _borderColor),
      focusedBorder: TextFieldHelper.outlineInputBorder(color: _borderColor),
    );
  }

  void _handlerController() {
    if (widget.onChanged != null) widget.onChanged!(_textEditingController.text);
  }

  @override
  void didUpdateWidget(covariant TextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initialController();
  }

  void _initialController() {
    final bool initialValueIsNotNull = widget.initialValue != null;
    final bool initialValueIsChanged = widget.initialValue != _textEditingController.text;
    if (initialValueIsNotNull && initialValueIsChanged) {
      _textEditingController.text = widget.initialValue ?? '';
      _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Color get _borderColor => widget.colorBorder ?? ThemeHelper.blackColor;
}

class _FactorySuffixIconWidget extends StatelessWidget {
  final Widget? suffixIcon;
  final bool showIconClose;
  final TextEditingController controller;

  const _FactorySuffixIconWidget({
    required this.suffixIcon,
    required this.showIconClose,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIconClose) _ClearWidget(controller),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}

class _ClearWidget extends StatefulWidget {
  final TextEditingController controller;
  const _ClearWidget(this.controller);

  @override
  State<_ClearWidget> createState() => _ClearWidgetState();
}

class _ClearWidgetState extends State<_ClearWidget> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _updateVisible();
    WidgetsBinding.instance.addPostFrameCallback(_addPostFrameCallback);
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const Offstage();
    return InkWell(
      onTap: widget.controller.clear,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeHelper.mainColor,
        ),
        child: const Icon(
          Icons.close,
          size: 18,
          color: ThemeHelper.whiteColor,
        ),
      ),
    );
  }

  void _addPostFrameCallback(Duration _) {
    widget.controller.addListener(_onSetState);
  }

  void _onSetState() {
    _updateVisible();
    if (!mounted) return;
    setState(() {});
  }

  void _updateVisible() {
    isVisible = widget.controller.text.isNotEmpty;
  }
}
