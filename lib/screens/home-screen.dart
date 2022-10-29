import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pump_state/providers/config-provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/start');
              },
              child: const Text('Start')),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/library');
              },
              child: const Text('Library')),
        ]),
      ),
    );
  }
}
