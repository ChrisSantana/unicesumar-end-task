import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/library/theme_helper.dart';

void main() {
  test('should valid the Theme Helper', () {
    /// Act
    final Color shadowColor = ThemeHelper.shadowColor;

    /// Assert
    expect(shadowColor, isNotNull);
  });

  test('should valid the OutlineInputBorder', () {
    /// Act
    final OutlineInputBorder outlineInputBorder = TextFieldHelper.outlineInputBorder();
    final OutlineInputBorder outlineInputBorderColor = TextFieldHelper.outlineInputBorder(color: ThemeHelper.blackColor);

    /// Assert
    expect(outlineInputBorder, isNotNull);
    expect(outlineInputBorderColor, isNotNull);
  });
}
