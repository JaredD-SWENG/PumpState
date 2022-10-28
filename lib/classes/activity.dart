import 'dart:convert';

abstract class Activity {
  String _id = "";

  String getId();

  String getName();

  Map<String, dynamic> toJson();
}
