// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/my_rides_status.dart';
import 'package:driver/global/utils/constants/payment_status.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

Widget inkWellWidget({
  Function()? onTap,
  required Widget child,
}) {
  return InkWell(
    onTap: onTap,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    child: child,
  );
}

String changeStatusText(String? status) {
  if (status == COMPLETED) {
    return 'Completed';
  } else if (status == CANCELED) {
    return 'Canceled';
  }
  return '';
}

Widget totalCount({String? title, String? subTitle, String? description, bool? isTotal = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(title!, style: isTotal == true ? boldTextStyle() : primaryTextStyle()),
      ),
      Expanded(
        child: Text(description!, style: isTotal == true ? boldTextStyle() : primaryTextStyle()),
      ),
      Text(
        '($subTitle)',
        style: isTotal == true ? boldTextStyle() : primaryTextStyle(),
      ),
    ],
  );
}

String paymentStatus(String paymentStatus) {
  if (paymentStatus.toLowerCase() == PAYMENT_PENDING.toLowerCase()) {
    return 'Pending';
  } else if (paymentStatus.toLowerCase() == PAYMENT_FAILED.toLowerCase()) {
    return 'Failed';
  } else if (paymentStatus == PAYMENT_PAID) {
    return 'Paid';
  } else if (paymentStatus == CASH) {
    return 'Cash';
  }
  return 'Pending';
}

String printDate(String date) {
  return "${DateFormat('dd MMM yyyy').format(DateTime.parse(date).toLocal())} at ${DateFormat('hh:mm a').format(DateTime.parse(date).toLocal())}";
}

Widget placeHolderWidget({
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  double? radius,
}) {
  return Image.asset(
    'images/placeholder.jpg',
    height: height,
    width: width,
    fit: fit ?? BoxFit.cover,
    alignment: alignment ?? Alignment.center,
  );
}

Widget commonCachedNetworkImage(
  String? url, {
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  bool usePlaceholderIfUrlEmpty = true,
  double? radius,
}) {
  if (url != null && url.isEmpty) {
    return placeHolderWidget(
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      radius: radius,
    );
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
          height: height,
          width: width,
          fit: fit,
          alignment: alignment,
          radius: radius,
        );
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(
          height: height,
          width: width,
          fit: fit,
          alignment: alignment,
          radius: radius,
        );
      },
    );
  } else {
    return Image.network(
      url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment ?? Alignment.center,
    );
  }
}

class DrawerWidget extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;

  const DrawerWidget({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return inkWellWidget(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withOpacity(0.6)),
                    // color: primaryColor.withOpacity(0.2),
                    color: Colors.white,
                    borderRadius: radius(10),
                  ),
                  child: Icon(
                    widget.iconData,
                    color: primaryColor,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(widget.title, style: primaryTextStyle()),
                ),
                Icon(Icons.arrow_forward_ios, size: 16)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
