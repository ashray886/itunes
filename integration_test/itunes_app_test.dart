import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:itunes/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('complete screen workflow', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      var textfield = find.byKey(const ValueKey('search'));
      await tester.pump();
      await tester.tap(textfield, warnIfMissed: false);
      await tester.enterText(textfield, "ten");
      await tester.pumpAndSettle();

      // Finds the submit button to tap on.
      final submit = find.byKey(const ValueKey('submit'));

      // Emulate a tap on the submit button.
      await tester.tap(submit);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Finds the listview button to tap on.
      final listView = find.byKey(const ValueKey('listView'));
      // Emulate a tap on the listview button.
      await tester.tap(listView);
      await tester.pump(const Duration(seconds: 2));

      final gridView = find.byKey(const ValueKey('gridView'));
      await tester.tap(gridView);
      await tester.pump(const Duration(seconds: 2));

      // Locate the first item in the GridView
      final firstGridItem = find.byKey(const ValueKey('grid_item_0'));

      // Tap on the first item
      await tester.tap(firstGridItem);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
