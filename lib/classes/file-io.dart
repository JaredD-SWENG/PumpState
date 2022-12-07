import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'dart:convert';
import 'config.dart';

/// FileIO contains static functions used in writing/reading data from local storage
class FileIO {
  /// Initializes the file store by instantiating a blank config json blob
  static Future<void> initConfig(WidgetRef ref) async {
    Directory dir = await getApplicationDocumentsDirectory(); // Get local storage directory
    String filePath = "${dir.path}/config.json"; // Generate the file path name from directory
    Config c = Config(); // Create a new config file
    // If the file does not already exist in local storage
    if (!File(filePath).existsSync()) {
      Map<String, dynamic> initConfig = c.toJson(); // Generate empty JSON map
      String initS = jsonEncode(initConfig); // Encode to JSON string
      File file = File(filePath); // Create the file
      file.writeAsStringSync(initS); // Write the data
      ref.read(configProvider.notifier).state = c; // Set the provider state
    } else {
      readConfig(ref);
    }
  }

  /// Reads config file as string from local storage, converts to
  /// Config object and stores in provider state
  static Future<void> readConfig(WidgetRef ref) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/config.json";
    File file = File(filePath);
    String readS = file.readAsStringSync();
    Map<String, dynamic> readMap = jsonDecode(readS);
    Config c = Config.fromJson(readMap);
    ref.read(configProvider.notifier).state = c;
  }

  /// Converts current Config object in provider state
  /// to string and writes to local storage
  static Future<void> writeConfig(Config c) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/config.json";
    Map<String, dynamic> writeMap = c.toJson();
    String writeS = jsonEncode(writeMap);
    File file = File(filePath);
    file.writeAsStringSync(writeS);
  }
}
