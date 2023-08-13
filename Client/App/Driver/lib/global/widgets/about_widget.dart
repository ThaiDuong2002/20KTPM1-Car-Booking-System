import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AboutWidget extends StatefulWidget {
  final int? driverId;

  const AboutWidget({
    super.key,
    this.driverId,
  });

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  bool? userData;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return userData == true
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rider Information'.capitalizeFirstLetter(), style: boldTextStyle()),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: commonCachedNetworkImage(
                        'https://picsum.photos/seed/picsum/200/300',
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duong', style: boldTextStyle(size: 14)),
                        const SizedBox(height: 4),
                        RatingBar.builder(
                          direction: Axis.horizontal,
                          glow: false,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          wrapAlignment: WrapAlignment.spaceBetween,
                          itemCount: 5,
                          itemSize: 10,
                          initialRating: double.parse('4.5'),
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            //
                          },
                        ),
                        const SizedBox(height: 4),
                        Text('thaiduong032002@gmail.com', style: secondaryTextStyle()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        : Visibility(
            visible: false,
            child: loaderWidget(),
          );
  }
}
