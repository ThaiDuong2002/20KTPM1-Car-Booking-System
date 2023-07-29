import 'package:flutter/material.dart';
import 'package:user/presentation/notification/views/notification_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationView(),
    );
  }
}
