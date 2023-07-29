import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

class UserInforView extends StatelessWidget {
  const UserInforView({super.key});

  static final List menuList = [
    {
      "image": "assets/images/menu/1.png",
      "title": "Chuyến đi",
      "route": "/initialBookingPage",
    },
    {
      "image": "assets/images/menu/2.png",
      "title": "Ưu đãi",
      "route": "/initialBookingPage",
    },
    {
      "image": "assets/images/menu/3.png",
      "title": "Phương thức thanh toán",
      "route": "/initialBookingPage",
    },
    {
      "image": "assets/images/menu/4.png",
      "title": "Địa điểm yêu thích",
      "route": "/initialBookingPage",
    },
    {
      "image": "assets/images/menu/5.png",
      "title": "Thay đổi ngôn ngữ",
      "route": "/initialBookingPage",
    },
    {
      "image": "assets/images/menu/6.png",
      "title": "Quản lý tài khoản",
      "route": "/initialBookingPage",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextCustom(
              text: "Thông tin tài khoản",
              color: Colors.white,
              fontSize: FONT_SIZE_LARGE,
              fontWeight: FontWeight.w700),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                      height: 60,
                      padding: EdgeInsets.all(5),
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(
                          "https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-8-avatar-2754583_120515.png")),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                                text: "Bùi Quang Thành",
                                color: COLOR_TEXT_BLACK,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 5,
                            ),
                            TextCustom(
                                text: "buiquangthanh1709@gmail.com",
                                color: COLOR_TEXT_MAIN,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              height: 5,
                            ),
                            TextCustom(
                                text: "0368826352",
                                color: COLOR_TEXT_MAIN,
                                fontSize: FONT_SIZE_NORMAL,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextCustom(
                  text: "Tài khoản",
                  color: COLOR_TEXT_BLACK,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w500),
              Expanded(
                  child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          minLeadingWidth: 0,
                          onTap: () {
                            Navigator.pushNamed(
                                context, menuList[index]["route"]);
                          },
                          leading: Image.asset(
                            menuList[index]["image"],
                            width: 30,
                            height: 30,
                          ),
                          title: TextCustom(
                              text: menuList[index]["title"],
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        Container(height: 1, color: Colors.grey.shade200)
                      ],
                    ),
                  );
                },
              ))
            ],
          ),
        ));
  }
}
