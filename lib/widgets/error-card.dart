import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final Function changeScreen;
  final String title;
  final String body;
  final int screenNumber;
  final String buttonText;
  final bool closeOnButtonPress;

  const ErrorCard(
      {Key? key,
      required this.changeScreen,
      required this.title,
      required this.body,
      required this.screenNumber,
      required this.buttonText,
      required this.closeOnButtonPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Color.fromRGBO(48, 47, 47, 1.0),
      content: Text(body, style: TextStyle(color: Colors.red, fontSize: 20.00)),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            changeScreen(screenNumber);
            if (closeOnButtonPress) {
              Navigator.pop(context);
            }
          },
          child: Text(buttonText),
        )
      ],
    );
  }
}
