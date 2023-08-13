import 'package:flutter/material.dart';
import 'package:user/presentation/order/views/order_view.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OrderView(),
    );
  }
}
