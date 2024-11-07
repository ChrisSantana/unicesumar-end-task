import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_end/core/library/injection_container.dart' as injector;
import 'package:task_end/main.dart';

void main() {
  setUpAll(() {
    injector.init();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MypApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));

    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
