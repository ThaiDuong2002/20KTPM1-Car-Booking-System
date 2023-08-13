import 'package:flutter/material.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../widget/custom_text.dart';

class ManagementView extends StatelessWidget {
  const ManagementView({super.key});
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
            text: "Quản lý tài khoản",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/intro");
                },
                child: const Row(
                  children: [
                    Icon(Icons.change_circle_rounded),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: "Thay đổi mật khẩu",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_LARGE,
                              fontWeight: FontWeight.w600),
                          TextCustom(
                              text:
                                  "Thay đổi mật khẩu để bảo mật tài khoản của bạn",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/intro");
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: "Đăng xuất",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_LARGE,
                              fontWeight: FontWeight.w600),
                          TextCustom(
                              text:
                                  "Bạn cần đăng nhập lại khi muốn sử dụng ứng dụng",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/intro");
                },
                child: const Row(
                  children: [
                    Icon(Icons.remove_circle_outline_sharp),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: "Xoá tài khoản",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_LARGE,
                              fontWeight: FontWeight.w600),
                          TextCustom(
                              text: "Tài khoản của bạn sẽ bị xoá vĩnh viễn!",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
