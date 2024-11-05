import 'package:flutter/material.dart';
import 'package:task_end/core/widget/show_dialog_widget.dart' as dialog;

abstract interface class IFactoryDialog {
  void showDialogBasic({
    bool? canPop,
    bool barrierDismissible = false,
    String? msg,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
  });

  Future<bool?>? showDialogConfirm({
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
  });

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
  });

  void closeAlert([bool? result]);
}

final class FactoryDialog implements IFactoryDialog {
  @override
  void showDialogBasic({
    bool? canPop,
    bool barrierDismissible = false,
    String? msg,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
  }) async {
    dialog.showDialogBasic(
      canPop: canPop,
      barrierDismissible: barrierDismissible,
      msg: msg,
      padding: padding,
    );
  }

  @override
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
    return await dialog.showDialogConfirm(
      title: title,
      msg: msg,
      assetsImage: assetsImage,
      textButtonMain: textButtonMain,
      textButtonSecondary: textButtonSecondary,
      maxHeight: maxHeight,
      maxAssetsHeight: maxAssetsHeight,
      backgroundColor: backgroundColor,
      colorButtonMain: colorButtonMain,
      colorButtonSecondary: colorButtonSecondary,
      colorTextButtonMain: colorTextButtonMain,
      colorTextButtonSecondary: colorTextButtonSecondary,
      onPressedButtonMain: onPressedButtonMain,
      onPressedButtonSecondary: onPressedButtonSecondary,
      showButtonSecondary: showButtonSecondary,
      barrierDismissible: barrierDismissible,
      paddingContent: paddingContent,
      showCloseOption: showCloseOption,
      buttonSecondaryHasSameAppearanceAsButtonMain: buttonSecondaryHasSameAppearanceAsButtonMain,
    );
  }

  @override
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
    dialog.showSnackBar(
      msg,
      nameAction: nameAction,
      onPressedAction: onPressedAction,
      colorBackground: colorBackground,
      colorMsg: colorMsg,
      colorAction: colorAction,
      padding: padding,
      duration: duration,
      onListen: onListen,
    );
  }

  @override
  void closeAlert([bool? result]) {
    dialog.closeAlert(result);
  }
}
