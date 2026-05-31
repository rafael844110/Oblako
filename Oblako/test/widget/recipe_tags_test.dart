import 'package:cullinarium/features/recipe/presentation/widgets/utils/recipe_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) =>
    MaterialApp(home: Scaffold(body: child));

void main() {
  group('RecipeTags', () {
    testWidgets('renders one chip per visible tag (max 2 shown)',
        (tester) async {
      await tester.pumpWidget(_host(
        const RecipeTags(tags: ['vegan', 'quick']),
      ));

      expect(find.text('vegan'), findsOneWidget);
      expect(find.text('quick'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(2));
    });

    testWidgets('extra tags collapse into "+N" chip', (tester) async {
      await tester.pumpWidget(_host(
        const RecipeTags(tags: ['a', 'b', 'c', 'd', 'e']),
      ));

      expect(find.text('+3'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(3));
    });

    testWidgets('empty tag list renders no chips', (tester) async {
      await tester.pumpWidget(_host(const RecipeTags(tags: [])));
      expect(find.byType(Chip), findsNothing);
    });
  });
}
