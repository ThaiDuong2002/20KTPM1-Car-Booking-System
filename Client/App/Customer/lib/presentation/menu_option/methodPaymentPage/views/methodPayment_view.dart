import 'package:flutter/material.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../widget/custom_text.dart';

class MethodPaymentView extends StatelessWidget {
  const MethodPaymentView({super.key});
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
            text: "Phương thức thanh toán",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            const Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(width: 10),
                TextCustom(
                    text: "Thanh toán trực tiếp",
                    color: COLOR_TEXT_BLACK,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w700)
              ],
            ),
            const SizedBox(height: 10),
            const TextCustom(
                text:
                    "Thanh toán trực tiếp là hình thức thanh toán tiền mặt khi tới điểm đến. Quý khách vui lòng chuẩn bị đủ tiền mặt để thanh toán cho nhân viên.",
                color: COLOR_TEXT_MAIN,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w500),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(width: 10),
                TextCustom(
                    text: "Thanh toán qua ví điện tử",
                    color: COLOR_TEXT_BLACK,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w700)
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Image.asset("assets/images/icons/zalo.png", width: 50),
                const SizedBox(width: 10),
                const TextCustom(
                    text: "ZaloPay",
                    color: COLOR_TEXT_MAIN,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w500)
              ],
            ),
            const SizedBox(height: 15),
            Opacity(
              opacity: 0.5,
              child: Row(
                children: [
                  Image.asset("assets/images/icons/momo.png", width: 50),
                  const SizedBox(width: 10),
                  const TextCustom(
                      text: "Momo (Sắp ra mắt)",
                      color: COLOR_TEXT_MAIN,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
          ]),
        ));
  }
}
