import 'workout_set.dart';
// Model representing a single workout
class Workout {
  final String id;
  final DateTime date;
  final List<WorkoutSet> sets;

  Workout({required this.id, required this.date, required this.sets});

  Workout copyWith({String? id, DateTime? date, List<WorkoutSet>? sets}) {
    return Workout(
      id: id ?? this.id,
      date: date ?? this.date,
      sets: sets ?? this.sets,
    );
  }
}
