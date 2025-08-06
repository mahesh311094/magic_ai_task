import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_ai_task/views/workout_list_screen.dart';

void main() {
  testWidgets('WorkoutListScreen displays empty state', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: WorkoutListScreen())),
    );

    expect(find.text('No workouts recorded yet.'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
