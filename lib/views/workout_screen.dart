import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'widgets/workout_set_card.dart';
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';

// Screen to add or edit a workout
class WorkoutScreen extends ConsumerStatefulWidget {
  final Workout? existingWorkout;

  const WorkoutScreen({super.key, this.existingWorkout});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
   // List of sets in this workout
  late List<WorkoutSet> sets;
  final uuid = Uuid();

  @override
  void initState() {
    super.initState();
    sets =
        widget.existingWorkout?.sets.map((set) => set.copyWith()).toList() ??
        [];

    // this will add one default set for new workout
    if (sets.isEmpty) {
      addSet();
    }
  }

  // Add a new set to the list
  void addSet() {
    sets.add(
      WorkoutSet(
        id: uuid.v4(),
        exercise: exercises[0],
        weight: 0.0,
        repetitions: 0,
      ),
    );
  }

  // Remove set from the list
  void removeSet(int index) {
    setState(() {
      sets.removeAt(index);
    });
  }

  // Save or update the workout
  void saveWorkout() {
    // Validation: must have at least one set
    if (sets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one set.')),
      );
      return;
    }

    // Validation: all sets must have weight > 0 and reps > 0
    for (final set in sets) {
      if (set.weight <= 0 || set.repetitions <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Each set must have weight and reps greater than 0.'),
          ),
        );
        return;
      }
    }

    final notifier = ref.read(workoutProvider.notifier);
    if (widget.existingWorkout != null) {
      notifier.updateWorkout(widget.existingWorkout!.id, sets);
    } else {
      notifier.addWorkout(sets);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingWorkout != null ? 'Edit Workout' : 'New Workout',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: saveWorkout),
        ],
      ),
      body: ListView.builder(
        itemCount: sets.length,
        itemBuilder: (context, index) {
          final set = sets[index];
          return WorkoutSetCard(
            set: set,
            onChanged: (updatedSet) {
              setState(() {
                sets[index] = updatedSet;
              });
            },
            onRemove: () {
              setState(() {
                sets.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addSet();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
