import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/helpers/dialogs/confirm_dialog.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Observer(builder: (context) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: radius(),
                        child: commonCachedNetworkImage(
                            'https://thebowdoinharpoon.com/2016/12/14/professor-really-spicing-up-class-as-course-questionnaire-nears/',
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                      Text('Thái Dương', style: boldTextStyle()),
                      const SizedBox(height: 4),
                      Text('thaiduong032002@gmail.com', style: secondaryTextStyle()),
                    ],
                  );
                }),
              ),
            ),
            const Divider(
              thickness: 2,
              height: 40,
            ),
            DrawerWidget(
              title: 'My Profile',
              iconData: Icons.person_outline_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'My Rides',
              iconData: Icons.car_rental_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Vehicle Details',
              iconData: Icons.car_crash_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'My Wallet',
              iconData: Icons.wallet_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Driver License',
              iconData: Icons.edit_document,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Bank Info',
              iconData: Icons.other_houses_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Setting',
              iconData: Icons.settings_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 50),
            Center(
              child: AppButtonWidget(
                text: 'Log Out',
                color: primaryColor,
                textStyle: boldTextStyle(color: Colors.white),
                onTap: () async {
                  await showConfirmDialogCustom(_scaffoldKey.currentState!.context,
                      primaryColor: primaryColor,
                      dialogType: DialogType.CONFIRMATION,
                      title: 'Are you sure you want to logout?',
                      positiveText: 'Yes',
                      negativeText: 'No', onAccept: (v) async {
                    await Future.delayed(const Duration(milliseconds: 500));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
