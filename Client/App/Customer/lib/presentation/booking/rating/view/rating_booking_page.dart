import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/booking/rating/widget/RatingWidget.dart';
import 'package:user/presentation/widget/custom_text.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  List<RatingOption> ratingOptions = [
    RatingOption(label: 'Tài xế lái không an toàn và thân thiện.', value: 1),
    RatingOption(label: 'Tài xế lái an toàn nhưng không thân thiện.', value: 2),
    RatingOption(label: 'Tài xế lái ổn và có phản ứng tốt.', value: 3),
    RatingOption(label: 'Tài xế rất thân thiện và lái xe tốt.', value: 4),
    RatingOption(
        label: 'Tài xế xuất sắc trong cả lái xe và giao tiếp.', value: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BLUE_MAIN,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: COLOR_TEXT_BLACK),
              alignment:
                  const Alignment(-0.2, 1), // move icon a bit to the left
            );
          },
        ),
        title: TextCustom(
            text: "Đánh giá tài xế",
            color: Colors.white,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600),
      ),
      body: Container(
        color: COLOR_BLUE_MAIN,
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 200, left: 10, right: 10),
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                  height: 10,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    child: RatingWidgets(ratingOptions: ratingOptions)),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextCustom(
                      textAlign: TextAlign.center,
                      text:
                          "Đánh giá của bạn sẽ giúp chúng tôi cải thiện dịch vụ",
                      color: COLOR_TEXT_BLACK,
                      fontSize: 16,
                      maxLines: 2,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print("Đánh giá");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
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
                    child: const Center(
                      child: TextCustom(
                          text: "Gửi đánh giá",
                          color: Colors.white,
                          fontSize: FONT_SIZE_LARGE,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 400),
            padding: EdgeInsets.all(10),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-avatar-sadboiz.jpg",
                  width: 130,
                  height: 130,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
