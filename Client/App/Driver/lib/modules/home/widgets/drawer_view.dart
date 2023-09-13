import 'package:driver/global/services/bloc/auth/auth_bloc.dart';
import 'package:driver/global/services/bloc/auth/auth_event.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/helpers/dialogs/confirm_dialog.dart';
import 'package:driver/global/utils/helpers/navigation/launch_screen.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/main.dart';
import 'package:driver/modules/info/bank/bank_view.dart';
import 'package:driver/modules/info/profile/edit/edit_profile_view.dart';
import 'package:driver/modules/info/vehicle/vehicle_view.dart';
import 'package:driver/modules/info/wallet/wallet_view.dart';
import 'package:driver/modules/rides/list/ride_list.dart';
import 'package:driver/modules/setting/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  void initState() {
    initUserInfo();
    super.initState();
  }

  String userFirstname = '';
  String userLastname = '';
  String userEmail = '';
  String userAvatar = '';

  void initUserInfo() async {
    userFirstname = await secureStorage.read(key: 'userFirstName') ?? '';
    userLastname = await secureStorage.read(key: 'userLastName') ?? '';
    userEmail = await secureStorage.read(key: 'userEmail') ?? '';
    userAvatar = await secureStorage.read(key: 'userAvatar') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return userAvatar != '' ? Drawer(
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
                        child: Image.network(
                          userAvatar,
                          width: 65,
                          height: 65,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$userLastname $userFirstname',
                        style: boldTextStyle(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: secondaryTextStyle(),
                      ),
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
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const EditProfileView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'My Rides',
              iconData: Icons.car_rental_outlined,
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const RideListView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Vehicle Details',
              iconData: Icons.car_crash_outlined,
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const VehicleDetailView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'My Wallet',
              iconData: Icons.wallet_outlined,
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const WalletView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Bank Info',
              iconData: Icons.other_houses_outlined,
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const BankInfoView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 16),
            DrawerWidget(
              title: 'Setting',
              iconData: Icons.settings_outlined,
              onTap: () {
                Navigator.pop(context);
                launchScreen(
                  context,
                  const SettingView(),
                  pageRouteAnimation: PageRouteAnimation.Slide,
                );
              },
            ),
            const SizedBox(height: 50),
            Center(
              child: AppButtonWidget(
                text: 'Log Out',
                color: primaryColor,
                textStyle: boldTextStyle(color: Colors.white),
                onTap: () async {
                  await showConfirmDialogCustom(
                    scaffoldKey.currentContext!,
                    primaryColor: primaryColor,
                    dialogType: DialogType.CONFIRMATION,
                    title: 'Are you sure you want to logout?',
                    positiveText: 'Yes',
                    negativeText: 'No',
                    onAccept: (v) async {
                      context.read<AuthBloc>().add(const AuthLogoutEvent());
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    ) : const Center(child: CircularProgressIndicator());
  }
}
