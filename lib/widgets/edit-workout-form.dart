import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/workout-provider.dart';
import 'package:pump_state/widgets/exercise-dropdown.dart';
import 'package:pump_state/widgets/workout-activity-list.dart';
import 'package:pump_state/widgets/save-workout-button.dart';
import 'package:pump_state/widgets/update-workout-button.dart';

import '../classes/activity.dart';
import '../classes/workout.dart';
import '../styles/styles.dart';
import 'break-buttons.dart';

///EditWorkoutForm is the view model Widget used to implement the logic behind editing a workout by the user.
class EditWorkoutForm extends ConsumerWidget {
  const EditWorkoutForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///parameters are set to all information stored in the workoutProvider.
    String _id = ref.watch(workoutProvider).getID();
    String _name = ref.watch(workoutProvider).getName();
    bool _favorite = ref.watch(workoutProvider).getFavorite();
    List<Activity> _activities = ref.watch(workoutProvider).getActivityList();

    ///toggleFavorite is a function that swaps the favorite bool from true to false, or from false to true.
    ///then updates the workoutProvider.
    void toggleFavorite(bool b) {
      Workout w = Workout.createNew(_id, _name, _activities, _favorite);
      w.toggleFavorite();
      ref.read(workoutProvider.notifier).state = w;
    }

    ///favoriteToggle is a Switch Widget that, when pressed, calls the toggleFavorite function.
    Widget favoriteToggle = Switch(value: _favorite, onChanged: toggleFavorite);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: slate(),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Card(
                  color: beaverBlue(),
                  child: Column(
                    children: [
                      Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      TextFormField(
                        ///TextFormField Widget is used to allow user to alter the name of the workout.
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        cursorColor: creek(),
                        cursorWidth: 2,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Workout Name",
                        ),
                        textAlign: TextAlign.center,
                        initialValue: _name,
                        style: TextStyle(color: whiteOut()),
                        onChanged: (s) {
                          ///When the user alters the textformfield, it changes the workout name, and updates the provider.
                          Workout w = Workout.createNew(
                              _id, _name, _activities, _favorite);
                          w.setName(s);
                          ref.read(workoutProvider.notifier).state = w;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Card(
                    color: beaverBlue(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Favorite',
                            style: Theme.of(context).textTheme.headline5),
                        favoriteToggle
                      ],
                    )),
              ),
            ],
          ),
          Expanded(
            child: ExerciseDropdown(),

            ///Calls for the ExerciseDropDown Widget.
          ),
          Expanded(
            child: BreakButtons(),

            ///Calls for the BreakButtons Widget.
          ),
          Expanded(
            flex: 2,
            child: NewWorkoutActivityList(),

            ///Calls for the NewWorkoutActivityList Widget.
          ),
          Expanded(
            child: UpdateWorkoutButton(),

            ///Calls for the UpdateWorkoutButton Widget.
          )
        ],
      ),
    );
  }
}
