import 'package:flutter/material.dart';
import 'package:pump_state/styles/styles.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: linearGradient(),
      child: Center(
        child: Text('Placeholder for Play'),
      ),
    );
  }
}
