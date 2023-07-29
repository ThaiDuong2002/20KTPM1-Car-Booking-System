import 'package:flutter/material.dart';

class ManagementView extends StatelessWidget {
  const ManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChangeLanguageView'),
        ),
        body: Center(
          child: Text('ManagementView'),
        ));
  }
}
