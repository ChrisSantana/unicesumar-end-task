import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/library/debouncer_helper.dart';

const int tValueOne = 1;
const int tValueZero = 1;
int? _test;

void main() {
  late final IDebouncerHelper tDebouncerHelper;
  late final int tMilliseconds;

  setUpAll(() {
    tDebouncerHelper = DebouncerHelper();
    tMilliseconds = 500;
  });

  test('should valid first call of run method', () async {
    /// Arrange
    _test = tValueZero;
    final int milliseconds = 500;

    /// Act
    tDebouncerHelper.run(_onExecuteAction, milliseconds: milliseconds);
    await Future.delayed(Duration(milliseconds: milliseconds + 100));

    /// Assert
    expect(_test, tValueOne);
  });

  test('should valid second call of run method', () {
    /// Arrange
    tDebouncerHelper.run(_onExecuteAction, milliseconds: tMilliseconds);
  });
}

void _onExecuteAction() {
  _test = tValueOne;
}
