import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/others_contants.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode imageFocus = FocusNode();

  FocusNode vehicleColorFocus = FocusNode();
  FocusNode vehicleLicensePlateFocus = FocusNode();

  String countryCode = defaultCountryCode;

  File? _image;

  Future getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Form(
              child: Stepper(
                currentStep: _currentIndex,
                onStepCancel: () {
                  if (_currentIndex > 0) {
                    _currentIndex--;
                    setState(() {});
                  }
                },
                onStepContinue: () {
                  if (_formKeys[_currentIndex].currentState!.validate()) {
                    if (_currentIndex < _formKeys.length - 1) {
                      _currentIndex++;
                      setState(() {});
                    } else {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomeView()));
                    }
                  }
                },
                onStepTapped: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                steps: [
                  Step(
                    isActive: _currentIndex <= 0,
                    state: _currentIndex <= 0 ? StepState.disabled : StepState.complete,
                    title: Text(
                      'Personal Details',
                      style: boldTextStyle(),
                    ),
                    content: Form(
                      key: _formKeys[0],
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.NAME,
                                  focus: firstNameFocus,
                                  nextFocus: lastNameFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'First Name',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.NAME,
                                  focus: lastNameFocus,
                                  nextFocus: emailFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Last Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.EMAIL,
                                  focus: emailFocus,
                                  nextFocus: phoneFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Email',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.PHONE,
                                  focus: phoneFocus,
                                  nextFocus: passwordFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Phone',
                                    prefixIcon: IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CountryCodePicker(
                                            padding: EdgeInsets.zero,
                                            initialSelection: countryCode,
                                            showCountryOnly: false,
                                            dialogSize: Size(
                                              MediaQuery.of(context).size.width - 60,
                                              MediaQuery.of(context).size.height * 0.6,
                                            ),
                                            showFlag: true,
                                            showFlagDialog: true,
                                            showOnlyCountryWhenClosed: false,
                                            alignLeft: false,
                                            textStyle: primaryTextStyle(),
                                            dialogBackgroundColor: Theme.of(context).cardColor,
                                            barrierColor: Colors.black12,
                                            dialogTextStyle: primaryTextStyle(),
                                            searchDecoration: InputDecoration(
                                              iconColor: Theme.of(context).dividerColor,
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).dividerColor),
                                              ),
                                              focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: primaryColor),
                                              ),
                                            ),
                                            searchStyle: primaryTextStyle(),
                                            onInit: (c) {
                                              countryCode = c!.dialCode!;
                                            },
                                            onChanged: (c) {
                                              countryCode = c.dialCode!;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.PASSWORD,
                                  focus: passwordFocus,
                                  nextFocus: confirmPasswordFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.PASSWORD,
                                  focus: confirmPasswordFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Confirm Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: _currentIndex <= 1,
                    state: _currentIndex <= 1 ? StepState.disabled : StepState.complete,
                    title: Text(
                      'Personal Image',
                      style: boldTextStyle(),
                    ),
                    content: Form(
                      key: _formKeys[1],
                      child: Column(
                        children: [
                          _image != null
                              ? Image.file(
                                  _image!,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.account_box_outlined,
                                  size: 200,
                                  color: primaryColor,
                                ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  getImageFromGallery();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  getImageFromCamera();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.photo_camera_outlined,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: _currentIndex <= 2,
                    state: _currentIndex <= 2 ? StepState.disabled : StepState.complete,
                    title: Text(
                      'Vehicle Details',
                      style: boldTextStyle(),
                    ),
                    content: Form(
                      key: _formKeys[2],
                      child: Column(
                        children: [
                          Column(
                            children: [
                              _image != null
                                  ? Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.car_rental,
                                      size: 200,
                                      color: primaryColor,
                                    ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromCamera();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.NAME,
                                  focus: vehicleColorFocus,
                                  nextFocus: vehicleLicensePlateFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'Color',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(
                                  textFieldType: TextFieldType.NAME,
                                  focus: vehicleLicensePlateFocus,
                                  errorThisFieldRequired: 'This field is required',
                                  decoration: inputDecoration(
                                    context,
                                    label: 'License Plate',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  Step(
                    isActive: _currentIndex <= 3,
                    state: _currentIndex <= 3 ? StepState.disabled : StepState.complete,
                    title: Text(
                      'Driver License',
                      style: boldTextStyle(),
                    ),
                    content: Form(
                      key: _formKeys[3],
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Front',
                                style: boldTextStyle(),
                              ),
                              _image != null
                                  ? Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.car_rental,
                                      size: 200,
                                      color: primaryColor,
                                    ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromCamera();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 50),
                          Column(
                            children: [
                              Text(
                                'Back',
                                style: boldTextStyle(),
                              ),
                              _image != null
                                  ? Image.file(
                                      _image!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.car_rental,
                                      size: 200,
                                      color: primaryColor,
                                    ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.image_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      getImageFromCamera();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.photo_camera_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
