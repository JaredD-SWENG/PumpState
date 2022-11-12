import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/new-exercise-form.dart';

class NewExerciseScreen extends StatelessWidget {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New Exercise'),
        ),
        body: NewExerciseForm());
  }
}
