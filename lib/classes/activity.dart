import 'dart:convert';

abstract class Activity {
  String _id = "";

  String getId();

  Map<String, dynamic> toJson();
}
