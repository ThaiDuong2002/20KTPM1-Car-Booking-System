import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

class VerifyPromotionView extends StatelessWidget {
  const VerifyPromotionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Container(
            width: 40,
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: Colors.red,
              ),
            )),
        body: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/5939/5939991.png',
                  width: 70,
                  height: 65,
                ),
                const SizedBox(height: 20),
                TextCustom(
                    text: "Bạn có khuyến mãi ? ",
                    color: COLOR_TEXT_BLACK,
                    fontSize: FONT_SIZE_LARGE,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 20),
                TextCustom(
                    text:
                        "Hãy nhập mã khuyến mãi của bạn vào ô bên dưới để đổi thưởng!",
                    color: COLOR_TEXT_MAIN,
                    fontSize: FONT_SIZE_NORMAL,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 15),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: FONT_SIZE_NORMAL,
                        color: COLOR_TEXT_MAIN),
                    hintText: 'Nhập mã',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(COLOR_BLUE_MAIN)),
                  onPressed: () {},
                  child: const Text('Xác minh mã của bạn'),
                )
              ],
            ),
          ),
        ));
  }
}
