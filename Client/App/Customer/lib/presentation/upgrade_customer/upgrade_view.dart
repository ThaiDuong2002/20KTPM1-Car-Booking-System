import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
import '../../app/constant/size.dart';
import '../widget/custom_text.dart';

class UpgradeCustomerView extends StatelessWidget {
  const UpgradeCustomerView({Key? key})
      : super(key: key); // Thêm 'Key?' vào khai báo key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: COLOR_BLUE_LIGHT,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        child: const Center(
          child: TextCustom(
              text: "Đăng kí nâng cấp",
              color: Colors.white,
              fontSize: FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600),
        ),
      ),
      appBar: AppBar(
        title: TextCustom(
          text: "Nâng cấp tài khoản",
          color: Colors.white,
          fontSize: FONT_SIZE_LARGE,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextCustom(
                text:
                    "Nâng cấp tài khoản cùng RideNow để sử dụng đầy đủ tính năng",
                color: Colors.black,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextCustom(
                text: "Gói nâng cấp này có gì ?",
                color: Colors.black,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: TextCustom(
                    text: "Đặt xe nhanh chóng",
                    color: Colors.black,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: TextCustom(
                    text: "Chức năng đặt trước",
                    color: Colors.black,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://lelogama.go-jek.com/cache/9a/8a/9a8a61993a034f3837579933107096ac.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  ItemExpansionTile(
                    headerValue: 'Điều khoản',
                    expandedValues: [
                      'Nội dung 1 của Điều khoản',
                      'Nội dung 2 của Điều khoản'
                    ],
                  ),
                  ItemExpansionTile(
                    headerValue: 'Chính sách',
                    expandedValues: [
                      'Nội dung 1 của Chính sách',
                      'Nội dung 2 của Chính sách'
                    ],
                  ),
                  // Thêm các item khác tại đây
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemExpansionTile extends StatelessWidget {
  final String headerValue;
  final List<String> expandedValues;

  ItemExpansionTile({
    required this.headerValue,
    required this.expandedValues,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      title: TextCustom(
          text: headerValue,
          color: COLOR_TEXT_MAIN,
          fontSize: FONT_SIZE_NORMAL,
          fontWeight: FontWeight.w500),
      children: expandedValues.map((String value) {
        return ListTile(
          title: TextCustom(
              text: value,
              color: COLOR_TEXT_MAIN,
              fontSize: FONT_SIZE_NORMAL,
              fontWeight: FontWeight.w500),
        );
      }).toList(),
    );
  }
}
