import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/config.dart';

///configProvider acts as a State Provider throughout the PumpState Appication,
///The UI reads the instance of Config stored here, and generates different
///UI elements and behaviors based off of what instance of Config is stored in this provider.
final configProvider = StateProvider<Config>((ref) {
  return Config();
});
