import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';

import '../../app/constant/size.dart';
import '../widget/custom_text.dart';

class CallcenterView extends StatelessWidget {
  const CallcenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: COLOR_BLUE_MAIN,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          child: const Center(
            child: TextCustom(
                text: "Sao chép số liên hệ",
                color: Colors.white,
                fontSize: FONT_SIZE_LARGE,
                fontWeight: FontWeight.w600),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
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
          title: const TextCustom(
              text: "Tổng đài",
              color: Colors.black,
              fontSize: FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/icons/callcenter_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextCustom(
                  text:
                      "Tổng đài hỗ trợ ! Nếu bạn bè chưa tải ứng dụng có thể sử dụng số điện thoại phía trên để đặt xe",
                  color: Colors.black,
                  fontSize: FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600),
              const SizedBox(
                height: 15,
              ),
              const TextCustom(
                  text: "RideNow chúng tôi sẽ hỗ trợ bạn 24/7 !",
                  color: Colors.black,
                  fontSize: FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600),
              const SizedBox(
                height: 15,
              ),
              const TextCustom(
                  text: "Cám ơn bạn đã sử dụng dịch vụ của chúng tôi",
                  color: Colors.black,
                  fontSize: FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600)
            ],
          ),
        ));
  }
}
