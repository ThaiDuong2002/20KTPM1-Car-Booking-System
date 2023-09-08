import 'package:flutter/material.dart';

class DynamicAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  DynamicAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}
