import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/new-exercise'),
        child: Icon(Icons.add),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/library/activities');
            },
            child: Text('Activities'),
          ),
          ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/library/workouts'),
              child: Text('Workouts'))
        ],
      )),
    );
  }
}
