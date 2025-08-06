// Model representing one set in a workout
class WorkoutSet {
  final String id;
  final String exercise;
  final double weight;
  final int repetitions;

  WorkoutSet({
    required this.id,
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

   WorkoutSet copyWith({
    String? id,
    String? exercise,
    double? weight,
    int? repetitions,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      repetitions: repetitions ?? this.repetitions,
    );
  }
}
