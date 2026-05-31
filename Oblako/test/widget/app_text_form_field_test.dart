import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) =>
    MaterialApp(home: Scaffold(body: child));

void main() {
  group('AppTextFormField', () {
    testWidgets('writes user input into controller', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(_host(
        AppTextFormField(title: 'Email', controller: controller),
      ));

      await tester.enterText(find.byType(TextFormField), 'jane@test.com');
      expect(controller.text, 'jane@test.com');
    });

    testWidgets('obscureText shows visibility toggle and flips obscure flag',
        (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(_host(
        AppTextFormField(
          title: 'Password',
          controller: controller,
          obscureText: true,
        ),
      ));

      expect(find.byIcon(Icons.visibility_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_rounded));
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);
    });

    testWidgets('renders prefixIcon when supplied', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(_host(
        AppTextFormField(
          title: 'Email',
          controller: controller,
          prefixIcon: const Icon(Icons.email),
        ),
      ));

      expect(find.byIcon(Icons.email), findsOneWidget);
    });
  });
}
