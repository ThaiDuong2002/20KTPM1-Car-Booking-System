import 'package:dotted_line/dotted_line.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/about_widget.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDetailView extends StatefulWidget {
  final int orderId;
  const RideDetailView({
    super.key,
    required this.orderId,
  });

  @override
  State<RideDetailView> createState() => _RideDetailViewState();
}

class _RideDetailViewState extends State<RideDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(MaterialCommunityIcons.head_question),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.05),
                    borderRadius: radius(),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Ionicons.calendar, color: textSecondaryColor, size: 18),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  printDate('2018-09-28T10:55:51.603Z'),
                                  style: primaryTextStyle(size: 14),
                                ),
                              ),
                            ],
                          ),
                          inkWellWidget(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Invoice',
                                  style: primaryTextStyle(color: primaryColor),
                                ),
                                const SizedBox(width: 4),
                                const Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    MaterialIcons.file_download,
                                    size: 18,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 36, thickness: 1),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Column(
                            children: [
                              Icon(Icons.near_me, color: Colors.green),
                              SizedBox(height: 4),
                              SizedBox(
                                height: 50,
                                child: DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: double.infinity,
                                  lineThickness: 1,
                                  dashLength: 2,
                                  dashColor: primaryColor,
                                ),
                              ),
                              SizedBox(height: 2),
                              Icon(Icons.location_on, color: Colors.red),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),
                                Text(printDate('2018-09-28T10:55:51.603Z'),
                                    style: secondaryTextStyle(size: 12)),
                                const SizedBox(height: 4),
                                Text(
                                  '165 W 46th St, New York, NY 10036, USA',
                                  style: primaryTextStyle(size: 14),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  printDate('2018-09-28T10:55:51.603Z'),
                                  style: secondaryTextStyle(size: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '165 W 46th St, New York, NY 10036, USA',
                                  style: primaryTextStyle(size: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      inkWellWidget(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View History',
                              style: primaryTextStyle(color: primaryColor),
                            ),
                            const Icon(Entypo.chevron_right, color: primaryColor, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.05),
                    borderRadius: radius(),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Detail',
                        style: boldTextStyle(size: 16),
                      ),
                      const Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Type', style: primaryTextStyle()),
                          Text(
                            paymentStatus('cash'),
                            style: boldTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Status', style: primaryTextStyle()),
                          Text(
                            paymentStatus('paid'),
                            style: boldTextStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.05),
                        borderRadius: radius(),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rider Information'.capitalizeFirstLetter(),
                            style: boldTextStyle(),
                          ),
                          const Divider(height: 30, thickness: 1),
                          Row(
                            children: [
                              const Icon(
                                FontAwesome.user,
                                size: 18,
                                color: textSecondaryColor,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Name',
                                style: primaryTextStyle(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=165+W+46th+St,+New+York,+NY+10036,+USA'),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration:
                                      BoxDecoration(color: Colors.green, borderRadius: radius(6)),
                                  child:
                                      const Icon(Icons.call_sharp, color: Colors.white, size: 16),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '0918048189',
                                  style: primaryTextStyle(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: AboutWidget(driverId: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About Rider', style: boldTextStyle(size: 16)),
                        const Divider(height: 30, thickness: 1),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: commonCachedNetworkImage(
                                'https://images.unsplash.com/photo-1612833603922-5e9b5f0b0b0f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VhJTIwZmFjdCUyMG1hcmtldCUyMHN0YXRpb24lMjB0byUyMGJ1dCUyMGFib3V0JTIwY2FyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Duong', style: boldTextStyle()),
                                  const SizedBox(height: 6),
                                  RatingBar.builder(
                                    direction: Axis.horizontal,
                                    glow: false,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    wrapAlignment: WrapAlignment.spaceBetween,
                                    itemCount: 5,
                                    itemSize: 20,
                                    initialRating: double.parse('4.5'),
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      //
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '0918048189',
                                          style: primaryTextStyle(size: 14),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchUrl(
                                            Uri.parse('tel:+1 123 456 7890'),
                                            mode: LaunchMode.externalApplication,
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(defaultRadius),
                                          ),
                                          child: const Icon(
                                            Icons.call_sharp,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price Detail', style: boldTextStyle(size: 16)),
                      const Divider(height: 30, thickness: 1),
                      const SizedBox(height: 12),
                      totalCount(title: 'Base Fare', description: '', subTitle: '4.5'),
                      const SizedBox(height: 8),
                      totalCount(title: 'Distance Fare', description: '', subTitle: '4.5'),
                      const SizedBox(height: 8),
                      totalCount(title: 'Duration', description: '', subTitle: '4.5'),
                      const SizedBox(height: 8),
                      totalCount(title: 'Waiting Charge', description: '', subTitle: '30 min'),
                      const SizedBox(height: 8),
                      totalCount(
                        title: 'Driver Tips',
                        description: '',
                        subTitle: '4.5',
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Extra Charge', style: boldTextStyle()),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '5465465'.validate().capitalizeFirstLetter(),
                                  style: primaryTextStyle(),
                                ),
                                Text(
                                  '4466',
                                  style: primaryTextStyle(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Coupon Discount',
                            style: primaryTextStyle(color: Colors.red),
                          ),
                          Text(
                            '',
                            style: primaryTextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      totalCount(
                        title: 'Total',
                        description: '',
                        subTitle: '4.5',
                        isTotal: true,
                      ),
                    ],
                  ),
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
          ),
        ],
      ),
    );
  }
}
