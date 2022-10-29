import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/config.dart';

final configProvider = StateProvider<Config>((ref) {
  return Config();
});
