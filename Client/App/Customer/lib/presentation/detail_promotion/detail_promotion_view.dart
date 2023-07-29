import 'package:flutter/material.dart';
import 'package:user/presentation/detail_promotion/detail_promotion_page.dart';

class DetailPromotionView extends StatelessWidget {
  const DetailPromotionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPromotion'),
      ),
      body: DetailPromotionPage(),
    );
  }
}
