import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pump_state/providers/config-provider.dart';
import 'dart:convert';
import 'activity.dart';
import 'config.dart';

class FileIO {
  static Future<void> initConfig(WidgetRef ref) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/config.json";
    Config c = Config();
    // if file does not exist
    if (!File(filePath).existsSync()) {
      Map<String, dynamic> initConfig = c.toJson(); //Generate empty JSON
      String initS = jsonEncode(initConfig);
      File file = File(filePath);
      file.writeAsStringSync(initS);
      ref
          .read(configProvider.notifier)
          .state = c;
    } else {
      readConfig(ref);
    }
  }

  static Future<void> readConfig(WidgetRef ref) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/config.json";

    File file = File(filePath);
    String readS = file.readAsStringSync();
    Map<String, dynamic> readMap = jsonDecode(readS);

    Config c = Config.fromJson(readMap);
    ref
        .read(configProvider.notifier)
        .state = c;
  }

  static Future<void> writeConfig(Config c) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/config.json";

    Map<String, dynamic> writeMap = c.toJson();
    String writeS = jsonEncode(writeMap);

    File file = File(filePath);
    file.writeAsStringSync(writeS);
  }
}
