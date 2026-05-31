import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppButton smoke test — renders and fires tap', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AppButton(
              title: 'Smoke',
              onPressed: () => taps++,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Smoke'), findsOneWidget);

    await tester.tap(find.text('Smoke'));
    await tester.pump();

    expect(taps, 1);
  });
}
