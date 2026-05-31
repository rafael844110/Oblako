import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('AppButton', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        _host(AppButton(title: 'Tap me', onPressed: () {})),
      );

      expect(find.text('Tap me'), findsOneWidget);
    });

    testWidgets('invokes onPressed when tapped', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _host(AppButton(title: 'Go', onPressed: () => tapped++)),
      );

      await tester.tap(find.text('Go'));
      await tester.pump();

      expect(tapped, 1);
    });

    testWidgets('disabled button swallows taps', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _host(AppButton(
          title: 'No',
          isDisabled: true,
          onPressed: () => tapped++,
        )),
      );

      await tester.tap(find.text('No'));
      await tester.pump();

      expect(tapped, 0);
    });

    testWidgets('respects custom width', (tester) async {
      await tester.pumpWidget(
        _host(AppButton(title: 'W', width: 321, onPressed: () {})),
      );

      final container = tester.widget<Container>(
        find.ancestor(of: find.text('W'), matching: find.byType(Container)).first,
      );
      expect(container.constraints?.maxWidth ?? 321, 321);
    });
  });
}
