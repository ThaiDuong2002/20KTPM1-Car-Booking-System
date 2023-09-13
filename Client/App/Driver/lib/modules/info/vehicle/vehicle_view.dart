import 'package:driver/global/services/exceptions/dio_service_exception.dart';
import 'package:driver/global/services/general/user/user_service.dart';
import 'package:driver/global/services/general/vehicle.type/vehicle_type_service.dart';
import 'package:driver/global/services/general/vehicle/vehicle_service.dart';
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

  @override
  void initState() {
    super.initState();
    fetchVehicleType();
  }

  String _vehicleType = 'Choose Type';
  String _capacity = 'Capacity';
  String? _vehicleImageUrl;

  VehicleTypeService vehicleTypeService = VehicleTypeService();
  VehicleService vehicleService = VehicleService();
  UserService userService = UserService();

  Future<void> fetchVehicleType() async {
    try {
      // final driverId = await secureStorage.read(key: 'userId');
      final userData = await userService.getUser();
      final vehicle = await vehicleService.getVehicle(userData.vehicleId);
      final dataList = await vehicleTypeService.getlistVehicleType();
      final vehicleSet = dataList.map((e) => e.name).toSet().toList();
      final capacitySet = dataList.map((e) => e.capacity).toSet().toList();
      _vehicleList.addAll(vehicleSet);
      _capacityList.addAll(capacitySet.map((e) => e.toString()));
      final vehicleType = await vehicleTypeService.getVehicleType(vehicle.typeId);
      if (mounted) {
        setState(() {
          _vehicleType = vehicleType.name;
          _capacity = vehicleType.capacity.toString();
          vehicleColorController.text = vehicle.color;
          vehicleLicenseController.text = vehicle.licensePlate;
          _vehicleImageUrl = vehicle.image;
        });
      }
    } catch (e) {
      if (e is UnknowFetchingDataException) {
        debugPrint('DioServiceException');
      } else {
        debugPrint('Exception: $e');
      }
    }
  }

  final _vehicleList = [
    'Choose Type',
  ];

  final _capacityList = [
    'Capacity',
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
    if (_vehicleImageUrl != null) {
      return Center(
        child: ClipRRect(
          child: Image.network(
            _vehicleImageUrl!,
            fit: BoxFit.fitWidth,
            height: 200,
            width: 200,
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
    return _vehicleImageUrl != null
        ? Scaffold(
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
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
