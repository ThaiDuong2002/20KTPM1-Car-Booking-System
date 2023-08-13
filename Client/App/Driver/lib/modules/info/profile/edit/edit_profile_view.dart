import 'dart:io';

import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/others_contants.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageProfile;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode firstnameFocus = FocusNode();
  FocusNode lastnameFocus = FocusNode();
  FocusNode contactFocus = FocusNode();

  List<String> gender = [MALE, FEMALE, OTHER];
  String selectGender = MALE;

  Future<void> getImage() async {
    imageProfile = null;
    imageProfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    setState(() {});
  }

  Widget profileImage() {
    if (imageProfile != null) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.file(
            File(imageProfile!.path),
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
              height: 100,
              width: 100,
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
          'Edit Profile',
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              top: 30,
              right: 16,
              bottom: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      profileImage(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 60, left: 80),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), color: primaryColor),
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
                  const SizedBox(height: 16),
                  AppTextField(
                    readOnly: true,
                    controller: emailController,
                    textFieldType: TextFieldType.EMAIL,
                    focus: emailFocus,
                    nextFocus: userNameFocus,
                    decoration: inputDecoration(context, label: 'Email'),
                    onTap: () {
                      toast('You cannot Change email');
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: firstNameController,
                    textFieldType: TextFieldType.NAME,
                    focus: firstnameFocus,
                    nextFocus: lastnameFocus,
                    decoration: inputDecoration(context, label: 'First Name'),
                    errorThisFieldRequired: 'This field is required',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: lastNameController,
                    textFieldType: TextFieldType.NAME,
                    focus: lastnameFocus,
                    nextFocus: contactFocus,
                    decoration: inputDecoration(context, label: 'Last Name'),
                    errorThisFieldRequired: 'This field is required',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: contactNumberController,
                    textFieldType: TextFieldType.PHONE,
                    focus: contactFocus,
                    readOnly: true,
                    decoration: inputDecoration(
                      context,
                      label: 'Contact Number',
                    ),
                    onTap: () {
                      toast('You cannot Change Contact Number');
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Gender', style: boldTextStyle()),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    decoration: inputDecoration(context, label: ""),
                    value: selectGender,
                    onChanged: (String? value) {
                      setState(() {
                        selectGender = value!;
                      });
                    },
                    items: gender
                        .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.capitalizeFirstLetter(),
                              style: primaryTextStyle(),
                            )))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: false,
                child: loaderWidget(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AppButtonWidget(
          text: 'Update',
          textStyle: boldTextStyle(color: Colors.white),
          color: primaryColor,
          onTap: () {},
        ),
      ),
    );
  }
}
