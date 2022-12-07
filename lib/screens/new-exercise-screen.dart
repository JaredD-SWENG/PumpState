import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/exercise-provider.dart';
import '../classes/exercise.dart';
import '../providers/workout-provider.dart';
import '../widgets/new-exercise-form.dart';

///NewExerciseScreen is a View Widget, used o host the NewExerciseForm view model Widget.
class NewExerciseScreen extends ConsumerWidget {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Exercise'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              ref.read(exerciseProvider.notifier).state = Exercise();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: NewExerciseForm());
  }
}
