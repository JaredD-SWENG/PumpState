/// Abstract class that is either a Exercise or Break
abstract class Activity {
  String getId();

  String getName();

  Map<String, dynamic> toJson();
}
