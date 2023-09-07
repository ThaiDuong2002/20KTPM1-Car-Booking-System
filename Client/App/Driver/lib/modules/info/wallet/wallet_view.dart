import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController addMoneyController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Observer(
        builder: (context) {
          return Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Available Balance',
                              style: secondaryTextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$ 0.00',
                              style: boldTextStyle(size: 22, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Recent Transactions',
                      style: primaryTextStyle(),
                    ),
                    AnimationLimiter(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return AnimationConfiguration.staggeredList(
                            delay: const Duration(milliseconds: 200),
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              child: Container(
                                margin: const EdgeInsets.only(top: 8, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(defaultRadius),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.add,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Money Debit',
                                            style: boldTextStyle(size: 16),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            printDate('2018-09-28T10:55:51.603Z'),
                                            style: secondaryTextStyle(size: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '\$ 0.00',
                                      style: secondaryTextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: false,
                child: loaderWidget(),
              ),
              const SizedBox(height: 16)
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: AppButtonWidget(
                text: 'Withdraw',
                textStyle: boldTextStyle(color: Colors.white),
                width: MediaQuery.of(context).size.width,
                color: primaryColor,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButtonWidget(
                text: 'Add Money',
                textStyle: boldTextStyle(color: Colors.white),
                color: primaryColor,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(defaultRadius),
                            topRight: Radius.circular(defaultRadius))),
                    builder: (_) {
                      return Form(
                        key: formKey,
                        child: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Add Money', style: boldTextStyle()),
                                    const SizedBox(height: 16),
                                    AppTextField(
                                      controller: addMoneyController,
                                      textFieldType: TextFieldType.PHONE,
                                      keyboardType: TextInputType.number,
                                      errorThisFieldRequired: 'This field is required',
                                      onChanged: (val) {
                                        //
                                      },
                                      validator: (String? val) {
                                        addMoneyController.text = val!.trim();
                                        addMoneyController.selection = TextSelection.fromPosition(
                                          TextPosition(offset: addMoneyController.text.length),
                                        );
                                        return "Maximum 100 required";
                                      },
                                      decoration: inputDecoration(context, label: 'Amount'),
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      runSpacing: 8,
                                      spacing: 8,
                                      children: '100|200|300'.split('|').map((e) {
                                        return inkWellWidget(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.circular(defaultRadius),
                                            ),
                                            child: Text(
                                              '$e VND',
                                              style: boldTextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppButtonWidget(
                                            text: 'Cancel',
                                            textStyle: boldTextStyle(color: Colors.white),
                                            width: MediaQuery.of(context).size.width,
                                            color: Colors.red,
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: AppButtonWidget(
                                            text: 'Add Money',
                                            textStyle: boldTextStyle(color: Colors.white),
                                            width: MediaQuery.of(context).size.width,
                                            color: primaryColor,
                                            onTap: () {},
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
