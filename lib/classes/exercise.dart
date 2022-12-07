import 'package:pump_state/classes/activity.dart';
import 'package:uuid/uuid.dart';

/// Exercise is a type of Activity that defines attributes such as sets and reps
class Exercise extends Activity {
  String _id = "";
  String _name = "";
  int _sets = 0;
  int _reps = 0;
  bool _favorite = false;

  /// createNew() Constructor is for when you are creating a brand new Exercise.
  /// This Constructor provides a new ID for the exercise object.
  Exercise.createNew(String name, int sets, int reps, bool favorite) {
    _id = const Uuid().v4();
    _name = name;
    _sets = sets;
    _reps = reps;
    _favorite = favorite;
  }

  /// updateState() Constructor is for when you need to update State Providers holding Exercises.
  /// unlike with createNew(), You pass in the ID you wish to preserve for the new Exercise State.
  Exercise.updateState(String id, String name, int sets, int reps, bool favorite) {
    _id = id;
    _name = name;
    _sets = sets;
    _reps = reps;
    _favorite = favorite;
  }

  /// Default Constructor
  Exercise() {
    _id = const Uuid().v4();
  }

  /// Overridden function from Activity abstract class
  /// Generates a JSON string of Exercise
  @override
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'sets': _sets.toString(),
        'reps': _reps.toString(),
        'favorite': _favorite.toString(),
      };

  /// Constructor to generate object from JSON
  Exercise.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _sets = int.parse(json['sets']);
    _reps = int.parse(json['reps']);
    if (json['favorite'] == "true") {
      _favorite = true;
    } else {
      _favorite = false;
    }
  }

  /// Overridden function from Activity abstract class.
  /// Returns the ID of the Exercise
  @override
  String getId() {
    return _id;
  }

  /// Overridden function from Activity abstract class.
  /// Returns the name of the Exercise
  @override
  getName() {
    return _name;
  }

  /// Sets the name of this exercise
  setName(String name) {
    _name = name;
  }

  /// Gets the sets of this exercise
  getSets() {
    return _sets;
  }

  /// Sets the sets of this exercise
  setSets(int sets) {
    _sets = sets;
  }

  /// Gets the reps of this exercise
  getReps() {
    return _reps;
  }

  /// Sets the reps of this exercise
  setReps(int reps) {
    _reps = reps;
  }

  /// Returns true if favorite, false if not
  getFavorite() {
    return _favorite;
  }

  /// Sets the favorite
  setFavorite(bool favorite) {
    _favorite = favorite;
  }

  /// Toggles the favorite
  void toggleFavorite() {
    if (_favorite) {
      _favorite = false;
    } else {
      _favorite = true;
    }
  }
}
