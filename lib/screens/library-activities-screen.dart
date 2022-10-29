import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

class LibraryActivitiesScreen extends StatelessWidget {
  const LibraryActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library/Activities'),
      ),
      body: ActivityButtonsList(),
    );
  }
}

class ActivityButtonsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: ref
            .watch(configProvider.notifier)
            .state
            .getLibraryActivitiesAsButtons(context, ref),
      ),
    );
  }
}
