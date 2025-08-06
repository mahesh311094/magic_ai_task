import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';

final uuid = Uuid();

// StateNotifier used to manage a list of workouts
class WorkoutViewModel extends StateNotifier<List<Workout>> {
  WorkoutViewModel() : super([]);

  // Adds a new workout to the list
  void addWorkout(List<WorkoutSet> sets) {
    final newWorkout = Workout(id: uuid.v4(), date: DateTime.now(), sets: sets);
    state = [...state, newWorkout];
  }

  // Updates an existing workout by ID
  void updateWorkout(String id, List<WorkoutSet> newSets) {
    state = [
      for (final workout in state)
        if (workout.id == id) workout.copyWith(sets: newSets) else workout,
    ];
  }

  // Deletes a workout by ID
  void deleteWorkout(String id) {
    state = state.where((w) => w.id != id).toList();
  }

  // Fetches a workout by its ID
  Workout? getWorkoutById(String id) {
    final match = state.where((w) => w.id == id);
    return match.isNotEmpty ? match.first : null;
  }
}
