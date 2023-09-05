import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BankInfoView extends StatefulWidget {
  const BankInfoView({super.key});

  @override
  State<BankInfoView> createState() => _BankInfoViewState();
}

class _BankInfoViewState extends State<BankInfoView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankCodeController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Info', style: boldTextStyle(color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppTextField(
                    controller: bankNameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(context, label: 'Bank Name'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: bankCodeController,
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: 'This field is required',
                    decoration: inputDecoration(context, label: 'Bank Code'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: accountHolderNameController,
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: 'This field is required',
                    decoration: inputDecoration(context, label: 'Account Holder Name'),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: accountNumberController,
                    textFieldType: TextFieldType.PHONE,
                    errorThisFieldRequired: 'This field is required',
                    decoration: inputDecoration(context, label: 'Account Number'),
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
