import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_ai_task/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full workout flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Tap FAB to add a workout
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Tap add set button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter weight
    await tester.enterText(find.byType(TextFormField).first, '60');
    // Enter repetitions
    await tester.enterText(find.byType(TextFormField).last, '10');

    // Save workout
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // Verify workout is listed
    expect(find.textContaining('Workouts'), findsOneWidget);

    // Tap to open workout
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    // Add another set
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Save updated workout
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // Delete workout
    await tester.drag(find.byType(ListTile), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNothing);
  });
}
