import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_ai_task/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full workout flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify empty state first
    expect(find.textContaining('No workouts recorded'), findsOneWidget);

    // Tap FAB to add a workout
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter weight
    final weightField = find.byKey(Key('weightField')).first;
    await tester.enterText(weightField, '60');

    // Enter repetitions
    final repsField = find.byKey(Key('repsField')).first;
    await tester.enterText(repsField, '10');

    // Save workout
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // Verify workout appears in list
    expect(find.textContaining('Workout on'), findsOneWidget);

    // Tap to open workout
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Add another set
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter weight for second set
    final secondWeight = find.byKey(Key('weightField')).last;
    await tester.enterText(secondWeight, '65');

    // Enter repetitions for second set
    final secondReps = find.byKey(Key('repsField')).last;
    await tester.enterText(secondReps, '8');

    // Save updated workout
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // Delete workout
    await tester.drag(find.byType(ListTile).first, const Offset(-500, 0));
    await tester.pumpAndSettle();

    // Verify it's deleted
    expect(find.byType(ListTile), findsNothing);
    expect(find.textContaining('No workouts recorded'), findsOneWidget);
  });
}
