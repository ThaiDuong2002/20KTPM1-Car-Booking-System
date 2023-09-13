import 'package:dotted_line/dotted_line.dart';
import 'package:driver/global/models/payment.method/payment_method_model.dart';
import 'package:driver/global/models/promotion/promotion_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';
import 'package:driver/global/services/general/payment.method/payment_method_service.dart';
import 'package:driver/global/services/general/promotion/promotion_service.dart';
import 'package:driver/global/services/general/rating/rating_service.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/extensions/string_extension.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/about_widget.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDetailView extends StatefulWidget {
  final String userId;
  final String driverId;
  final String customerName;
  final String customerPhone;
  final String type;
  final String pickupAddress;
  final String destinationAddress;
  final String pickupTime;
  final String dropOffTime;
  final String createdAt;
  final String paymentMethodId;
  final String promotionId;
  final String status;
  final int total;
  final int distance;
  const RideDetailView({
    super.key,
    required this.userId,
    required this.driverId,
    required this.customerName,
    required this.customerPhone,
    required this.type,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.pickupTime,
    required this.dropOffTime,
    required this.createdAt,
    required this.paymentMethodId,
    required this.promotionId,
    required this.status,
    required this.total,
    required this.distance,
  });

  @override
  State<RideDetailView> createState() => _RideDetailViewState();
}

class _RideDetailViewState extends State<RideDetailView> {
  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  PaymentMethodService paymentMethodService = PaymentMethodService();
  PromotionService promotionService = PromotionService();
  RatingService ratingService = RatingService();

  PaymentMethodModel? paymentMethod;
  PromotionModel? promotion;

  String? driverName;
  String? driverPhone;
  String? driverAvatar;
  double? driverRating;

  var ratingPoints = 0.0;
  void fetchingData() async {
    try {
      final paymentData = await paymentMethodService.getPaymentMethod(widget.paymentMethodId);
      final promotionData = await promotionService.getPromotion(widget.promotionId);
      final ratingData = await ratingService.getRatingByDriverId(widget.driverId);

      debugPrint('testing $ratingData');

      for (var item in ratingData) {
        debugPrint('testing ${item.star}');
        ratingPoints + item.star.toDouble();
      }

      final ratingPoint = ratingPoints / ratingData.length;

      final firstname = await secureStorage.read(key: 'userFirstName');
      final lastname = await secureStorage.read(key: 'userLastName');
      final phone = await secureStorage.read(key: 'userPhone');
      final avatar = await secureStorage.read(key: 'userAvatar');

      debugPrint('testing $ratingPoint $firstname $lastname $phone $avatar');

      if (mounted) {
        setState(() {
          paymentMethod = paymentData;
          promotion = promotionData;
          driverName = '$firstname $lastname';
          driverPhone = phone;
          driverAvatar = avatar;
          driverRating = ratingPoint;
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

  @override
  Widget build(BuildContext context) {
    return driverAvatar != null
        ? Scaffold(
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
                                    const Icon(Ionicons.calendar,
                                        color: textSecondaryColor, size: 18),
                                    const SizedBox(width: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        printDate(widget.createdAt),
                                        style: primaryTextStyle(size: 14),
                                      ),
                                    ),
                                  ],
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
                                      Text(
                                        printDate(widget.pickupTime),
                                        style: secondaryTextStyle(size: 12),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.pickupAddress,
                                        style: primaryTextStyle(size: 14),
                                      ),
                                      const SizedBox(height: 22),
                                      Text(
                                        printDate(widget.dropOffTime),
                                        style: secondaryTextStyle(size: 12),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.destinationAddress,
                                        style: primaryTextStyle(size: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                  paymentMethod?.name ?? 'No payment method',
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
                                  'Customer Information'.capitalizeFirstLetter(),
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
                                      widget.customerName,
                                      style: primaryTextStyle(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse(
                                        'tel:+${widget.customerPhone}',
                                      ),
                                      mode: LaunchMode.externalApplication,
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: radius(6),
                                        ),
                                        child: const Icon(
                                          Icons.call_sharp,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.customerPhone,
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
                              Text('About Driver', style: boldTextStyle(size: 16)),
                              const Divider(height: 30, thickness: 1),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.network(
                                      driverAvatar ??
                                          'https://cdn.icon-icons.com/icons2/2620/PNG/512/among_us_player_red_icon_156942.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(driverName ?? 'No Name', style: boldTextStyle()),
                                        const SizedBox(height: 6),
                                        RatingBar.builder(
                                          direction: Axis.horizontal,
                                          glow: false,
                                          allowHalfRating: true,
                                          ignoreGestures: true,
                                          wrapAlignment: WrapAlignment.spaceBetween,
                                          itemCount: 5,
                                          itemSize: 20,
                                          initialRating:
                                              double.parse((driverRating ?? 0.0).toString()),
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
                                                driverPhone ?? 'No phone',
                                                style: primaryTextStyle(size: 14),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                // launchUrl(
                                                //   Uri.parse('tel:+1 123 456 7890'),
                                                //   mode: LaunchMode.externalApplication,
                                                // );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(defaultRadius),
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
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Promotion',
                                  style: primaryTextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    promotion?.name ?? 'No promotion',
                                    style: primaryTextStyle(color: Colors.green),
                                    maxLines: 5,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Discount',
                                  style: primaryTextStyle(color: Colors.red),
                                ),
                                Text(
                                  '${promotion!.discount * 100.0}%',
                                  style: primaryTextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 30, thickness: 1),
                            totalCount(
                              title: 'Total',
                              description: '',
                              subTitle: widget.total.toString(),
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
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
