import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final bool isShowTextError;

  ErrorView(this.isShowTextError);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isShowTextError ? Text('Get data error') : Container(),
    );
  }
}
