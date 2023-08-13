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
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              alignment:
                  const Alignment(-0.2, 1), // move icon a bit to the left
            );
          },
        ),
        backgroundColor: Colors.white,
        title: const TextCustom(
          text: "Nâng cấp tài khoản",
          color: COLOR_TEXT_BLACK,
          fontSize: FONT_SIZE_LARGE,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const TextCustom(
                text:
                    "Nâng cấp tài khoản cùng RideNow để sử dụng đầy đủ tính năng",
                color: Colors.black,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const TextCustom(
                text: "Gói nâng cấp này có gì ?",
                color: Colors.black,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                const Expanded(
                  child: TextCustom(
                    text: "Đặt xe nhanh chóng",
                    color: Colors.black,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                const Expanded(
                  child: TextCustom(
                    text: "Chức năng đặt trước",
                    color: Colors.black,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 0.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/icons/vip.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: const [
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

  const ItemExpansionTile({
    super.key,
    required this.headerValue,
    required this.expandedValues,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
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
