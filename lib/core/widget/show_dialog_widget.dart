import 'package:flutter/material.dart';
import 'package:task_end/core/library/injection_container.dart';
import 'package:task_end/core/library/theme_helper.dart';
import 'package:task_end/core/library/util_text.dart';
import 'package:task_end/core/service/app_service.dart';
import 'package:task_end/core/widget/button_extensions_widget.dart';
import 'package:task_end/core/widget/progress_indicator_widget.dart';
import 'package:task_end/core/widget/text_extension_widget.dart';

bool _isAlertOpened = false;
bool _isSnackBarOpened = false;

bool get isSnackBarOpened => _isSnackBarOpened;

void showDialogBasic({
  bool? canPop,
  bool barrierDismissible = false,
  String? msg,
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
}) async {
  _isAlertOpened = true;
  final bool canPopParam = canPop ?? _onWillPopScope();
  await showDialog(
    context: getIt<IAppService>().context!,
    builder: (context) {
      return PopScope(
        canPop: canPopParam,
        child: AlertDialog(
          contentPadding: padding,
          content: Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10, right: 4, top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  height: 34,
                  width: 34,
                  child: const ProgressIndicatorWidget(strokeWidth: 2, color: ThemeHelper.blackColor),
                ),
                Expanded(
                  child: Text(
                    msg ?? UtilText.labelProgress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).font14W500(),
                ),
              ],
            ),
          ),
        ),
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

Future<bool?> showDialogConfirm({
  required String title,
  required String msg,
  String? assetsImage,
  String? textButtonMain,
  String? textButtonSecondary,
  double? maxHeight,
  double? maxAssetsHeight,
  Color? backgroundColor,
  Color? colorButtonMain,
  Color? colorButtonSecondary,
  Color? colorTextButtonMain,
  Color? colorTextButtonSecondary,
  VoidCallback? onPressedButtonMain,
  VoidCallback? onPressedButtonSecondary,
  bool showButtonSecondary = false,
  bool barrierDismissible = false,
  bool showCloseOption = false,
  bool buttonSecondaryHasSameAppearanceAsButtonMain = false,
  EdgeInsets? paddingContent,
}) async {
  return await showDialog<bool?>(
    context: getIt<IAppService>().context!,
    useSafeArea: true,
    builder: (context) {
      return _AlertDialogWidget(
        title: title,
        msg: msg,
        canPop: false,
        assetsImage: assetsImage,
        backgroundColor: backgroundColor,
        elevation: ThemeHelper.theme.cardTheme.elevation,
        maxHeight: maxHeight,
        maxAssetsHeight: maxAssetsHeight,
        paddingContent: paddingContent,
        showCloseOption: showCloseOption,
        actions: [
          _ActionsButtonWidget(
            textButtonMain: textButtonMain,
            textButtonSecondary: textButtonSecondary,
            maxHeight: maxHeight,
            maxAssetsHeight: maxAssetsHeight,
            colorButtonMain: colorButtonMain,
            colorButtonSecondary: colorButtonSecondary,
            colorTextButtonMain: colorTextButtonMain,
            colorTextButtonSecondary: colorTextButtonSecondary,
            onPressedButtonMain: onPressedButtonMain,
            onPressedButtonSecondary: onPressedButtonSecondary,
            showButtonSecondary: showButtonSecondary,
            buttonSecondaryHasSameAppearanceAsButtonMain: buttonSecondaryHasSameAppearanceAsButtonMain,
          ),
        ],
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

Future<bool?> showDialogCustom({
  required Widget child,
  String? textButtonMain,
  String? textButtonSecondary,
  double? maxHeight,
  double? maxAssetsHeight,
  Color? backgroundColor,
  Color? colorButtonMain,
  Color? colorButtonSecondary,
  Color? colorTextButtonMain,
  Color? colorTextButtonSecondary,
  VoidCallback? onPressedButtonMain,
  VoidCallback? onPressedButtonSecondary,
  bool showButtonSecondary = false,
  bool barrierDismissible = false,
  bool buttonSecondaryHasSameAppearanceAsButtonMain = false,
  bool showButtons = true,
  bool showCloseButton = false,
}) async {
  return await showDialog<bool?>(
    context: getIt<IAppService>().context!,
    useSafeArea: true,
    builder: (context) {
      return _AlertDialogCustomWidget(
        canPop: true,
        backgroundColor: backgroundColor,
        elevation: ThemeHelper.theme.cardTheme.elevation,
        maxHeight: maxHeight,
        showCloseOption: showCloseButton,
        actions: showButtons
            ? [
                _ActionsButtonWidget(
                  textButtonMain: textButtonMain,
                  textButtonSecondary: textButtonSecondary,
                  maxHeight: maxHeight,
                  maxAssetsHeight: maxAssetsHeight,
                  colorButtonMain: colorButtonMain,
                  colorButtonSecondary: colorButtonSecondary,
                  colorTextButtonMain: colorTextButtonMain,
                  colorTextButtonSecondary: colorTextButtonSecondary,
                  onPressedButtonMain: onPressedButtonMain,
                  onPressedButtonSecondary: onPressedButtonSecondary,
                  showButtonSecondary: showButtonSecondary,
                  buttonSecondaryHasSameAppearanceAsButtonMain: buttonSecondaryHasSameAppearanceAsButtonMain,
                ),
              ]
            : [],
        child: child,
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

Future<bool?> showDialogCustomActions({
  required List<Widget> actions,
  required String title,
  required String msg,
  String? assetsImage,
  double? maxHeight,
  double? maxAssetsHeight,
  Color? backgroundColor,
  bool showCloseOption = true,
  bool barrierDismissible = false,
}) async {
  return await showDialog<bool?>(
    context: getIt<IAppService>().context!,
    useSafeArea: true,
    builder: (context) {
      return _AlertDialogWidget(
        canPop: true,
        showCloseOption: showCloseOption,
        assetsImage: assetsImage,
        backgroundColor: backgroundColor,
        elevation: ThemeHelper.theme.cardTheme.elevation,
        maxHeight: maxHeight,
        actions: actions,
        title: title,
        msg: msg,
      );
    },
    barrierDismissible: barrierDismissible,
  );
}

void showSnackBar(
  String msg, {
  String? nameAction,
  void Function()? onPressedAction,
  Color? colorBackground,
  Color? colorMsg,
  Color? colorAction,
  EdgeInsets? padding,
  Duration duration = const Duration(seconds: 5),
  void Function()? onListen,
}) {
  final BuildContext context = getIt<IAppService>().context!;
  _isSnackBarOpened = true;

  final snackBar = SnackBar(
    duration: duration,
    backgroundColor: colorBackground ?? ThemeHelper.blackColor,
    margin: const EdgeInsets.all(34),
    behavior: SnackBarBehavior.floating,
    content: Text(
      msg,
    ).font14W400(color: colorMsg ?? ThemeHelper.whiteColor),
    action: SnackBarAction(
      label: (nameAction ?? UtilText.labelClose).toUpperCase(),
      textColor: colorAction ?? ThemeHelper.mainColor,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _isSnackBarOpened = false;
        if (onPressedAction != null) onPressedAction();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
    _isSnackBarOpened = false;
    onListen?.call();
  });
}

class _AlertDialogWidget extends StatelessWidget {
  final String title;
  final String msg;
  final bool canPop;
  final List<Widget> actions;
  final String? assetsImage;
  final double? maxHeight;
  final double? maxAssetsHeight;
  final Color? backgroundColor;
  final double? elevation;
  final EdgeInsets? paddingContent;
  final bool showCloseOption;

  const _AlertDialogWidget({
    required this.title,
    required this.msg,
    required this.canPop,
    required this.actions,
    this.paddingContent,
    this.assetsImage,
    this.maxHeight,
    this.maxAssetsHeight,
    this.backgroundColor,
    this.elevation,
    this.showCloseOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: AlertDialog(
        backgroundColor: backgroundColor,
        elevation: elevation,
        title: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  _AssetsImage(
                    assetsImage: assetsImage,
                    maxHeight: maxAssetsHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                    ).font24W700(color: ThemeHelper.mainStrongerColor),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 20,
                child: _ButtonCloseWidget(
                  showWidget: showCloseOption,
                ),
              ),
            ],
          ),
        ),
        content: Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height,
          ),
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              padding: paddingContent ?? EdgeInsets.zero,
              child: Text(
                msg,
              ).font14W400(textAlign: TextAlign.center),
            ),
          ),
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.center,
        titlePadding: const EdgeInsets.only(top: 30),
        actionsPadding: const EdgeInsets.only(bottom: 30, top: 16),
      ),
    );
  }
}

class _AlertDialogCustomWidget extends StatelessWidget {
  final Widget child;
  final bool canPop;
  final List<Widget> actions;
  final double? maxHeight;
  final Color? backgroundColor;
  final double? elevation;
  final bool showCloseOption;

  const _AlertDialogCustomWidget({
    required this.child,
    required this.canPop,
    required this.actions,
    this.maxHeight,
    this.backgroundColor,
    this.elevation,
    this.showCloseOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: AlertDialog(
        backgroundColor: backgroundColor,
        elevation: elevation,
        contentPadding: EdgeInsets.zero,
        content: Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height,
            minWidth: MediaQuery.sizeOf(context).width,
          ),
          child: Stack(
            children: [
              Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 12),
                  child: child,
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: _ButtonCloseWidget(
                  showWidget: showCloseOption,
                ),
              ),
            ],
          ),
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.center,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        actionsPadding: const EdgeInsets.only(bottom: 30, top: 16),
      ),
    );
  }
}

class _AssetsImage extends StatelessWidget {
  final String? assetsImage;
  final double? maxHeight;

  const _AssetsImage({
    required this.assetsImage,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    if ((assetsImage ?? '').trim().isEmpty) return const Offstage();
    return Image.asset(
      assetsImage!,
      height: maxHeight ?? 120,
      fit: BoxFit.fitHeight,
    );
  }
}

class _ActionsButtonWidget extends StatelessWidget {
  final String? textButtonMain;
  final String? textButtonSecondary;
  final double? maxHeight;
  final double? maxAssetsHeight;
  final Color? colorButtonMain;
  final Color? colorButtonSecondary;
  final Color? colorTextButtonMain;
  final Color? colorTextButtonSecondary;
  final VoidCallback? onPressedButtonMain;
  final VoidCallback? onPressedButtonSecondary;
  final bool showButtonSecondary;
  final bool buttonSecondaryHasSameAppearanceAsButtonMain;

  const _ActionsButtonWidget({
    required this.textButtonMain,
    required this.textButtonSecondary,
    required this.maxHeight,
    required this.maxAssetsHeight,
    required this.colorButtonMain,
    required this.colorButtonSecondary,
    required this.colorTextButtonMain,
    required this.colorTextButtonSecondary,
    required this.onPressedButtonMain,
    required this.onPressedButtonSecondary,
    required this.showButtonSecondary,
    required this.buttonSecondaryHasSameAppearanceAsButtonMain,
  });

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16);
    if (showButtonSecondary) {
      return _DoubleButtonWidget(
        textButtonMain: textButtonMain,
        textButtonSecondary: textButtonSecondary,
        maxHeight: maxHeight,
        maxAssetsHeight: maxAssetsHeight,
        padding: padding,
        colorButtonMain: colorButtonMain,
        colorButtonSecondary: colorButtonSecondary,
        colorTextButtonMain: colorTextButtonMain,
        colorTextButtonSecondary: colorTextButtonSecondary,
        onPressedButtonMain: onPressedButtonMain ?? _onPressedButtonMainClose,
        onPressedButtonSecondary: onPressedButtonSecondary ?? _onPressedButtonSecondaryClose,
        buttonSecondaryHasSameAppearanceAsButtonMain: buttonSecondaryHasSameAppearanceAsButtonMain,
      );
    } else {
      return Padding(
        padding: padding,
        child: ElevatedButton(
          onPressed: onPressedButtonMain ?? _onPressedButtonMainClose,
          child: Text((textButtonMain ?? UtilText.labelOK).toUpperCase()),
        ).buttonMain(),
      );
    }
  }

  void _onPressedButtonMainClose() {
    getIt<IAppService>().navigatePop(true);
  }

  void _onPressedButtonSecondaryClose() {
    getIt<IAppService>().navigatePop(false);
  }
}

class _DoubleButtonWidget extends StatelessWidget {
  final String? textButtonMain;
  final String? textButtonSecondary;
  final double? maxHeight;
  final double? maxAssetsHeight;
  final EdgeInsets padding;
  final Color? colorButtonMain;
  final Color? colorButtonSecondary;
  final Color? colorTextButtonMain;
  final Color? colorTextButtonSecondary;
  final VoidCallback onPressedButtonMain;
  final VoidCallback? onPressedButtonSecondary;
  final bool buttonSecondaryHasSameAppearanceAsButtonMain;

  const _DoubleButtonWidget({
    required this.textButtonMain,
    required this.textButtonSecondary,
    required this.maxHeight,
    required this.maxAssetsHeight,
    required this.padding,
    required this.colorButtonMain,
    required this.colorButtonSecondary,
    required this.colorTextButtonMain,
    required this.colorTextButtonSecondary,
    required this.onPressedButtonMain,
    required this.onPressedButtonSecondary,
    required this.buttonSecondaryHasSameAppearanceAsButtonMain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _ButtonSecodaryWidget(
              onPressed: onPressedButtonSecondary ?? _onPressedButtonSecondaryClose,
              textButton: textButtonSecondary ?? UtilText.labelCancel,
              sameAppearanceAsButtonMain: buttonSecondaryHasSameAppearanceAsButtonMain,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
          Expanded(
            child: _ButtonMainWidget(
              onPressed: onPressedButtonMain,
              textButton: textButtonMain ?? UtilText.labelOK,
            ),
          ),
        ],
      ),
    );
  }

  void _onPressedButtonSecondaryClose() {
    getIt<IAppService>().navigatePop(false);
  }
}

class _ButtonCloseWidget extends StatelessWidget {
  final bool showWidget;

  const _ButtonCloseWidget({required this.showWidget});

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const Offstage();
    return InkWell(
      onTap: getIt<IAppService>().navigatePop,
      child: const Icon(
        Icons.close,
        color: ThemeHelper.grayDarkColor,
        size: 26,
      ),
    );
  }
}

class _ButtonMainWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String textButton;

  const _ButtonMainWidget({required this.onPressed, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: FittedBox(
        child: Text(textButton.toUpperCase()),
      ),
    );
  }
}

class _ButtonSecodaryWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String textButton;
  final bool sameAppearanceAsButtonMain;

  const _ButtonSecodaryWidget({
    required this.onPressed,
    required this.textButton,
    required this.sameAppearanceAsButtonMain,
  });

  @override
  Widget build(BuildContext context) {
    if (sameAppearanceAsButtonMain) {
      return _ButtonMainWidget(onPressed: onPressed, textButton: textButton);
    }
    return OutlinedButton(
      onPressed: onPressed,
      child: FittedBox(
        child: Text(textButton.toUpperCase()).font16W500(color: ThemeHelper.mainColor),
      ),
    );
  }
}

void closeAlert([bool? result]) {
  if (_isAlertOpened) {
    _isAlertOpened = false;
    getIt<IAppService>().navigatePop(result);
  }
}

bool _onWillPopScope() {
  return false;
}
