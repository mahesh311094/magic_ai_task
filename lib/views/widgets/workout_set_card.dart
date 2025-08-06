import 'package:flutter/material.dart';
import '../../models/workout_set.dart';

const List<String> exercises = [
  'Barbell row',
  'Bench press',
  'Shoulder press',
  'Deadlift',
  'Squat',
];

// A reusable card to display a single workout set
class WorkoutSetCard extends StatelessWidget {
  final WorkoutSet set;
  final ValueChanged<WorkoutSet> onChanged;
  final VoidCallback onRemove;

  const WorkoutSetCard({
    super.key,
    required this.set,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Exercise:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: set.exercise,
                  items:
                      exercises.map((exercise) {
                        return DropdownMenuItem(
                          value: exercise,
                          child: Text(exercise),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(set.copyWith(exercise: value));
                    }
                  },
                ),
                const Spacer(),
                IconButton(icon: const Icon(Icons.delete), onPressed: onRemove),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final weight = double.tryParse(value ?? '');
                      if (weight == null || weight <= 0) {
                        return 'Enter valid weight';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      onChanged(
                        set.copyWith(weight: double.tryParse(value) ?? 0.0),
                      );
                    },
                    initialValue: set.weight.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Repetitions'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final reps = int.tryParse(value ?? '');
                      if (reps == null || reps <= 0) {
                        return 'Enter valid reps';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      onChanged(
                        set.copyWith(repetitions: int.tryParse(value) ?? 0),
                      );
                    },
                    initialValue: set.repetitions.toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
