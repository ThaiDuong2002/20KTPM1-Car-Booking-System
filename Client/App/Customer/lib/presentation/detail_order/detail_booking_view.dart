import 'package:flutter/material.dart';

import '../../app/constant/color.dart';
import '../../app/constant/size.dart';
import '../widget/custom_text.dart';

class DetailOrderView extends StatelessWidget {
  const DetailOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
            text: 'Chi tiết chuyến đi',
            color: Colors.white,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w500),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 15),
                  child: TextCustom(
                      text: 'Mã chuyến đi: ',
                      color: Colors.black,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: TextCustom(
                      text: '123456',
                      color: Colors.black,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/5556/5556468.png")),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                            text: 'Tài xế',
                            color: Colors.black,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 5,
                        ),
                        TextCustom(
                            text: 'Phạm Giang Thái Dương',
                            color: Colors.black,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                          text: 'Tổng cộng',
                          color: Colors.black,
                          fontSize: FONT_SIZE_XLARGE,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: '33.000đ',
                          color: Colors.black,
                          fontSize: FONT_SIZE_XLARGE,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                          text: 'Hình thức thanh toán',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: 'Tiền mặt',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                          text: 'Thời gian đặt xe',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: '12:00 12/12/2021',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                          text: 'Ưu đãi',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                      TextCustom(
                          text: '0đ',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextCustom(
                          text: 'Gocar',
                          color: Colors.black,
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.w500),
                      Row(
                        children: [
                          TextCustom(
                              text: '3.4km - ',
                              color: Colors.black,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                          TextCustom(
                              text: '8 phút',
                              color: Colors.black,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: COLOR_BLUE_MAIN,
                                size: 20,
                              ),
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                  text: "Điểm đón",
                                  color: COLOR_TEXT_BLACK,
                                  fontSize: FONT_SIZE_NORMAL,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                  text: "Thời gian đón",
                                  color: COLOR_TEXT_MAIN,
                                  fontSize: FONT_SIZE_SMALL,
                                  fontWeight: FontWeight.w500)
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: 1,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                  text: "Điểm đến",
                                  color: COLOR_TEXT_BLACK,
                                  fontSize: FONT_SIZE_NORMAL,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                  text: "Thời gian đến",
                                  color: COLOR_TEXT_MAIN,
                                  fontSize: FONT_SIZE_SMALL,
                                  fontWeight: FontWeight.w500)
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
