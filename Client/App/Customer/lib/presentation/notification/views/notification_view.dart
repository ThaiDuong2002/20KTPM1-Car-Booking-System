
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/constant/color.dart';
import '../../../app/constant/size.dart';
import '../../widget/custom_text.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  static final List notifycationList = [
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Gấp! Hoàn điểm 50%",
      "time": "12/07/2021",
      "description": "Miễn phí dùng thử",
      "type": "notifycation",
    },
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Chuyến đi đến",
      "time": "12/07/2021",
      "description": "Tiết kiệm 110.000. Xem ngay!!",
      "type": "system",
    },
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Ưu đãi liên kết ZaloPay vào Grab",
      "time": "12/07/2021",
      "description": "Dành riêng cho bạn! Xem ngay",
      "type": "notifycation",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text('Thông báo',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: notifycationList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/detailNotification');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 5, top: 20),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/1280/1280098.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: TextCustom(
                                          text: notifycationList[index]
                                              ["title"],
                                          color: COLOR_TEXT_BLACK,
                                          fontSize: FONT_SIZE_NORMAL,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      child: TextCustom(
                                          text: notifycationList[index]
                                              ["description"],
                                          color: COLOR_TEXT_MAIN,
                                          fontSize: FONT_SIZE_NORMAL,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.only(right: 10, top: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextCustom(
                                            text: notifycationList[index]
                                                ["time"],
                                            color: COLOR_TEXT_BLACK,
                                            fontSize: FONT_SIZE_SMALL_X,
                                            fontWeight: FontWeight.w600),
                                        const Icon(
                                          Icons.circle,
                                          size: 15,
                                          color: Colors.amber,
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                    ),
                  );
                },
              ))
            ],
          ),
        ));
  }
}
