import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/library/clock_helper.dart';

void main() {
  test('should return a datetime', () {
    /// Act
    final IClockHelper clockHelper = ClockHelper();

    /// Assert
    expect(clockHelper.currentDateTime, isA<DateTime>());
  });
}
