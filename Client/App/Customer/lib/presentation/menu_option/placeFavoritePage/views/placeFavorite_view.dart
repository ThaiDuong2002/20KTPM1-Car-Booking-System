import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../widget/custom_text.dart';
import '../widget/placeItem.dart';

class PlaceFavoriteView extends StatelessWidget {
  const PlaceFavoriteView({super.key});
  static final List placePersonalList = [
    {
      "name": "Cà phê hay đi",
      "address": "727 Đ Trần Hưng Đạo,Phường 1, Quận 5, Thành phố Hồ Chí Minh",
    },
    {
      "name": "Trường học của tôi",
      "address": "727 Đ Trần Hưng Đạo,Phường 1, Quận 5, Thành phố Hồ Chí Minh",
    },
    {
      "name": "Quán ăn ngon",
      "address": "727 Đ Trần Hưng Đạo,Phường 1, Quận 5, Thành phố Hồ Chí Minh",
    },
  ];
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
                text: "Thêm địa điểm",
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
                alignment: const Alignment(-0.2, 1), // move icon a bit to the left
              );
            },
          ),
          backgroundColor: Colors.white,
          title: const TextCustom(
            text: "Địa điểm quen thuộc",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: COLOR_TEXT_BLACK,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: FONT_SIZE_NORMAL,
                        color: COLOR_TEXT_MAIN,
                      ),
                      indicatorColor: COLOR_BLUE_MAIN,
                      tabs: const [
                        Tab(text: "Cá nhân"),
                        Tab(text: "Công ty"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: placePersonalList.length,
                                itemBuilder: (context, index) {
                                  return ExpandableContainer(
                                    place: placePersonalList[index],
                                  );
                                }),
                          ),
                          const Center(child: Text('Công ty')),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
