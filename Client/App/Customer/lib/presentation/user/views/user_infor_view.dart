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
      "route": "/orderPageMenu",
    },
    {
      "image": "assets/images/menu/2.png",
      "title": "Ưu đãi",
      "route": "/promotionPageMenu",
    },
    {
      "image": "assets/images/menu/3.png",
      "title": "Phương thức thanh toán",
      "route": "/methodPaymentPage",
    },
    {
      "image": "assets/images/menu/4.png",
      "title": "Địa điểm yêu thích",
      "route": "/placeFavoritePage",
    },
    {
      "image": "assets/images/menu/5.png",
      "title": "Thay đổi ngôn ngữ",
      "route": "/changeLanguagePage",
    },
    {
      "image": "assets/images/menu/6.png",
      "title": "Quản lý tài khoản",
      "route": "/manageAccountPage",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: "Thông tin tài khoản",
              color: Colors.black,
              fontSize: FONT_SIZE_LARGE,
              fontWeight: FontWeight.w700),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                      height: 60,
                      padding: const EdgeInsets.all(5),
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:
                          Image.asset("assets/images/icons/icon_avatar.png")),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: const Column(
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
                      onPressed: () {
                        Navigator.pushNamed(context, "/editProfilePage");
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const TextCustom(
                  text: "Tài khoản",
                  color: COLOR_TEXT_BLACK,
                  fontSize: FONT_SIZE_NORMAL,
                  fontWeight: FontWeight.w500),
              Expanded(
                  child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
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
                          trailing: const Icon(Icons.arrow_forward_ios),
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
