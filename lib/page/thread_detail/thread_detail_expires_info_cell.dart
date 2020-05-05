import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThreadDetailExpiresInfoCell extends StatelessWidget {
  const ThreadDetailExpiresInfoCell({Key key, this.expiresDateTime})
      : super(key: key);

  final DateTime expiresDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(_message()),
      ],
    );
  }

  String _message() {
    final now = DateTime.now();
    String text;
    if (now.year != expiresDateTime.year) {
      text = DateFormat('yyyy年M月d日 HH:mm').format(expiresDateTime);
    } else if (now.day != expiresDateTime.day) {
      text = DateFormat('M月d日 HH:mm').format(expiresDateTime);
    } else {
      text = DateFormat('HH:mm').format(expiresDateTime);
    }
    return '$text頃消えます';
  }
}
