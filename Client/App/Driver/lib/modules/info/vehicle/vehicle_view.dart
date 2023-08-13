import 'dart:io';

import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class VehicleDetailView extends StatefulWidget {
  const VehicleDetailView({super.key});

  @override
  State<VehicleDetailView> createState() => _VehicleDetailViewState();
}

class _VehicleDetailViewState extends State<VehicleDetailView> {
  TextEditingController vehicleTypeColorController = TextEditingController();
  TextEditingController vehicleCapacityController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController vehicleLicenseController = TextEditingController();

  String _vehicleType = 'Choose Type';

  final _vehicleList = [
    'Choose Type',
    'Bike',
    'Car',
  ];

  String _capacity = 'Capacity';

  final _capacityList = [
    'Capacity',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
  ];

  XFile? vehicleImage;

  Future<void> getImage() async {
    vehicleImage = null;
    vehicleImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    setState(() {});
  }

  Widget profileImage() {
    if (vehicleImage != null) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.file(
            File(vehicleImage!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      );
    } else {
      // if (sharedPref.getString(USER_PROFILE_PHOTO)!.isNotEmpty) {
      //   return Center(
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(100),
      //       child: commonCachedNetworkImage(
      //         'https://thebowdoinharpoon.com/2016/12/14/professor-really-spicing-up-class-as-course-questionnaire-nears/',
      //         fit: BoxFit.cover,
      //         height: 100,
      //         width: 100,
      //       ),
      //     ),
      //   );
      // } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/user_icon.png',
              height: 200,
              width: 200,
            ),
          ),
        ),
      );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vehicle Detail',
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      profileImage(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 150, left: 150),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primaryColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              getImage();
                            },
                            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: _vehicleType,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _vehicleList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (e) {
                          setState(() {
                            _vehicleType = e!;
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      _vehicleType == 'Car'
                          ? DropdownButton(
                              value: _capacity,
                              icon: const Icon(Icons.arrow_drop_down),
                              items: _capacityList.map((e) {
                                if (e == '1') {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text('$e Person'),
                                  );
                                } else {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text('$e People'),
                                  );
                                }
                              }).toList(),
                              onChanged: (e) {
                                setState(() {
                                  _capacity = e!;
                                });
                              },
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: vehicleColorController,
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: 'This field is required',
                    decoration: inputDecoration(context, label: 'Vehicle Color'),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: vehicleLicenseController,
                    textFieldType: TextFieldType.PHONE,
                    errorThisFieldRequired: 'This field is required',
                    decoration: inputDecoration(context, label: 'Vehicle License'),
                  ),
                ],
              ),
            ),
            Observer(
              builder: (context) {
                return Visibility(
                  visible: false,
                  child: loaderWidget(),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AppButtonWidget(
          text: 'Update',
          color: primaryColor,
          textStyle: boldTextStyle(color: Colors.white),
          onTap: () {},
        ),
      ),
    );
  }
}
