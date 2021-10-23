import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView({Key? key, this.message = 'Unknow Error'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Processing'),
        ),
        body: Text(message));
  }
}
