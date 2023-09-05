import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:flutter/material.dart';

Widget settingItemWidget(
  IconData icon,
  String title,
  Function() onTap, {
  bool isLast = false,
  IconData? suffixIcon,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        leading: Icon(
          icon,
          size: 25,
          color: primaryColor,
        ),
        title: Text(
          title,
          style: primaryTextStyle(),
        ),
        trailing: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: Colors.green,
              )
            : const Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
        onTap: onTap,
      ),
      if (!isLast) const Divider(height: 0)
    ],
  );
}
