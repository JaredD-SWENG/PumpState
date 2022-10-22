class CompletedWorkout {
  DateTime _date = DateTime.now();
  int _pumpPoints = 0;

  CompletedWorkout(String s, String pumpPoints) {
    _date = DateTime.parse(s);
    _pumpPoints = int.parse(pumpPoints);
  }

  int getPumpPoints() {
    return _pumpPoints;
  }
}
