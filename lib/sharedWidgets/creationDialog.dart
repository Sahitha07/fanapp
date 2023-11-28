import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  PopupDialog({super.key, this.onPressed, this.title, this.description});
  Function? onPressed;
  String? title;
  String? description;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'User does not exist'),
      content: Text(description ?? 'Please check email or password'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            this.onPressed!();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
