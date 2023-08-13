import 'package:flutter/material.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../widget/custom_text.dart';

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key});
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
            text: "Thay đổi ngôn ngữ",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 10),
                  const TextCustom(
                      text: "Tiếng Việt",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w700),
                  Checkbox(value: false, onChanged: (value) {})
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 10),
                  const TextCustom(
                      text: "Tiếng Anh",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.w700),
                  Checkbox(value: false, onChanged: (value) {})
                ],
              ),
            ],
          ),
        ));
  }
}
