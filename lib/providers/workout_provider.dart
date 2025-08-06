import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/workout_view_model.dart';
import '../models/workout.dart';

final workoutProvider = StateNotifierProvider<WorkoutViewModel, List<Workout>>(
  (ref) => WorkoutViewModel(),
);
