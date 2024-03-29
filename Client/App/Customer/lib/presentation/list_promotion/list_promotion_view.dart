import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../app/constant/color.dart';

class ListPromotionView extends StatelessWidget {
  const ListPromotionView({super.key});
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
                text: "Danh sách ưu đãi",
                color: COLOR_TEXT_BLACK,
                fontSize: FONT_SIZE_LARGE,
                fontWeight: FontWeight.w600)),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 40,
                      ),
                      child: SearchBar(
                        elevation: const MaterialStatePropertyAll(1),
                        shadowColor:
                            MaterialStatePropertyAll(Colors.grey.shade100),
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 231, 231, 231)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                        trailing: [
                          InkWell(
                            child: const Icon(
                              Icons.search,
                              color: COLOR_TEXT_MAIN,
                            ),
                            onTap: () {
                              print('search');
                            },
                          )
                        ],
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
                        hintText: 'Tên khuyến mãi ...',
                        hintStyle: MaterialStatePropertyAll(
                            GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: FONT_SIZE_NORMAL,
                                color: COLOR_TEXT_MAIN)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print('filter');
                    },
                    child: const Icon(
                      Icons.filter_alt,
                      size: 32,
                      color: COLOR_TEXT_MAIN,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/promotion/3.png',
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                        text:
                                            'Ưu đãi tháng 6 - 10% thành viên mới',
                                        color: COLOR_TEXT_BLACK,
                                        fontSize: FONT_SIZE_NORMAL,
                                        fontWeight: FontWeight.w600),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextCustom(
                                        text: 'Còn 6 ngày',
                                        color: COLOR_TEXT_MAIN,
                                        fontSize: FONT_SIZE_NORMAL,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
