import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../app/routes/route_name.dart';

class DetailPromotionPage extends StatelessWidget {
  const DetailPromotionPage({super.key});
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
        child: InkWell(
          onTap: () {
               Navigator.pushNamed(context, AppRouterName.intialBookingPage);
          },
          child: const Center(
            child: TextCustom(
                text: "Sử dụng",
                color: Colors.white,
                fontSize: FONT_SIZE_LARGE,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(
          text: "Chi tiết khuyến mãi",
          color: COLOR_TEXT_BLACK,
          fontSize: FONT_SIZE_LARGE,
          fontWeight: FontWeight.w600,
        ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/promotion/2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Column(
                children: [
                  Center(
                    child: TextCustom(
                        text: "Giảm 15% tối đa 35k",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: "Ngày bắt đầu",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10,
                          ),
                          TextCustom(
                              text: "29/07/2023",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              text: "Ngày kết thúc",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10,
                          ),
                          TextCustom(
                              text: "29/08/2023",
                              color: COLOR_TEXT_BLACK,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  BulletList(
                    text: 'Mô tả thứ 1.Mô tả thứ 2. Mô tả thứ 3',
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

class BulletList extends StatelessWidget {
  final String text;

  const BulletList({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = text.split('.'); // Split text into sentences

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            leading: const Text('_',
                style: TextStyle(fontSize: 16, color: COLOR_TEXT_MAIN)),
            title: TextCustom(
                text: items[index].trim(),
                color: COLOR_TEXT_MAIN,
                fontSize: FONT_SIZE_NORMAL,
                fontWeight: FontWeight.w500),
          );
        },
      ),
    );
  }
}
