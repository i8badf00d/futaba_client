import 'package:flutter/material.dart';
import 'package:futaba_client/entity/futaba_thread.dart';

class ThreadPage extends StatelessWidget {
  const ThreadPage({Key key, this.thread}) : super(key: key);

  final FutabaThread thread;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(thread.body),
      ),
      body: const Scaffold(),
    );
  }
}
