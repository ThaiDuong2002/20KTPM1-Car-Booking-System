import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:driver/modules/setting/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                settingItemWidget(Icons.lock_outline, 'Change Password', () {}),
                settingItemWidget(Icons.language, 'Language', () {}),
                settingItemWidget(Icons.assignment_outlined, 'Privacy Policy', () {}),
                settingItemWidget(Icons.help_outline, 'Help', () {}),
                settingItemWidget(Icons.assignment_outlined, 'Terms Conditions', () {}),
                settingItemWidget(
                  Icons.info_outline,
                  'About',
                  () {},
                ),
                settingItemWidget(Icons.delete_outline, 'Delete Account', () {}),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  leading: const Icon(Icons.offline_bolt_outlined, size: 25, color: primaryColor),
                  title: Text('Available', style: primaryTextStyle()),
                  trailing: Switch(
                      value: true,
                      onChanged: (val) {
                        //
                      }),
                  onTap: () async {},
                ),
              ],
            ),
          ),
          Observer(builder: (context) {
            return Visibility(
              visible: false,
              child: loaderWidget(),
            );
          })
        ],
      ),
    );
  }
}
