import 'package:flutter/material.dart';

import '../../../app/constant/color.dart';
import '../../../app/constant/size.dart';
import '../../widget/custom_text.dart';

class DetailNotificationView extends StatelessWidget {
  const DetailNotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                alignment: const Alignment(-0.2, 1), // move icon a bit to the left
              );
            },
          ),
          backgroundColor: Colors.white,
          title: const TextCustom(
            text: "Chi tiết thông báo",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: const Center(child: Text('DetailNotificationView')));
  }
}
