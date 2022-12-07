import 'package:flutter/material.dart';

///ErrorCard is a Widget called to display Error messages to the User is in certain Contexts.
class ErrorCard extends StatelessWidget {
  final Function changeScreen;
  final String title;
  final String body;
  final int screenNumber;
  final String buttonText;
  final bool closeOnButtonPress;

  const ErrorCard(

      ///Parameetrs of the ErrorCard are provided and set on instantiation.
      {Key? key,
      required this.changeScreen,
      required this.title,

      ///Title of the Card
      required this.body,

      ///Body Text of the error message.
      required this.screenNumber,

      ///Screen Number of Main Screen where error was caught.
      required this.buttonText,

      ///Text of the TextButton
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
