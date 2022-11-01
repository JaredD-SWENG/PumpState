import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

class LibraryActivitiesScreen extends ConsumerWidget {
  const LibraryActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> activityButtons = ref.watch(configProvider).getLibraryActivitiesAsButtons(context, ref);
    return Scaffold(
      appBar: AppBar(
        title: Text('Library/Activities'),
      ),
      body: Center(
        child: Column(
          children: activityButtons,
        ),
      ),
    );
  }
}
