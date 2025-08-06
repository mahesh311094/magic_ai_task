import 'package:flutter_test/flutter_test.dart';
import 'package:magic_ai_task/models/workout_set.dart';
import 'package:magic_ai_task/viewmodels/workout_view_model.dart';

void main() {
  group('WorkoutListViewModel', () {
    late WorkoutViewModel viewModel;

    setUp(() {
      viewModel = WorkoutViewModel();
    });

    test('should add a workout', () {
      final sets = [
        WorkoutSet(id: '1', exercise: 'Squat', weight: 50, repetitions: 10),
      ];

      viewModel.addWorkout(sets);

      expect(viewModel.state.length, 1);
      expect(viewModel.state.first.sets.first.exercise, 'Squat');
    });

    test('should update a workout', () {
      final sets = [
        WorkoutSet(id: '1', exercise: 'Squat', weight: 50, repetitions: 10),
      ];

      viewModel.addWorkout(sets);
      final id = viewModel.state.first.id;

      final updatedSets = [
        WorkoutSet(id: '2', exercise: 'Deadlift', weight: 70, repetitions: 5),
      ];

      viewModel.updateWorkout(id, updatedSets);

      expect(viewModel.state.first.sets.first.exercise, 'Deadlift');
    });

    test('should delete a workout', () {
      final sets = [
        WorkoutSet(id: '1', exercise: 'Squat', weight: 50, repetitions: 10),
      ];

      viewModel.addWorkout(sets);
      final id = viewModel.state.first.id;

      viewModel.deleteWorkout(id);

      expect(viewModel.state, isEmpty);
    });
  });
}
