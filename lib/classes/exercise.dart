import 'package:pump_state/classes/activity.dart';
import 'package:uuid/uuid.dart';

class Exercise extends Activity {
  String _id = "";
  String _name = "";
  int _sets = 0;
  int _reps = 0;
  bool _favorite = false;

  /**
   * createNew() Constructor is for when you are creating a brand new Exercise.
   * This Constructor provides a new ID for the exercise object.
   */
  Exercise.createNew(String name, int sets, int reps, bool favorite) {
    _id = const Uuid().v4();
    _name = name;
    _sets = sets;
    _reps = reps;
    _favorite = favorite;
  }

  /**
   * updateState() Constructor is for when you need to update State Providers holding Exercises.
   * unlike with createNew(), You pass in the ID you wish to preserve for the new Exercise State.
   */
  Exercise.updateState(String id, String name, int sets, int reps, bool favorite) {
    _id = id;
    _name = name;
    _sets = sets;
    _reps = reps;
    _favorite = favorite;
  }

  Exercise() {
    _id = const Uuid().v4();
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'sets': _sets.toString(),
        'reps': _reps.toString(),
        'favorite': _favorite.toString(),
      };

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

  @override
  String getId() {
    return _id;
  }

  getName() {
    return _name;
  }

  setName(String name) {
    _name = name;
  }

  getSets() {
    return _sets;
  }

  setSets(int sets) {
    _sets = sets;
  }

  getReps() {
    return _reps;
  }

  setReps(int reps) {
    _reps = reps;
  }

  getFavorite() {
    return _favorite;
  }

  setFavorite(bool favorite) {
    _favorite = favorite;
  }

  void toggleFavorite() {
    if (_favorite) {
      _favorite = false;
    } else {
      _favorite = true;
    }
  }
}
