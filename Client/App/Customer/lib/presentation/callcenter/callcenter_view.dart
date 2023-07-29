import 'package:flutter/material.dart';

import '../../app/constant/size.dart';
import '../widget/custom_text.dart';

class CallcenterView extends StatelessWidget {
  const CallcenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
            text: "Tổng đài",
            color: Colors.white,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600),
      ),
      body: Center(
        child: Text('Callcenter Page'),
      ),
    );
  }
}
