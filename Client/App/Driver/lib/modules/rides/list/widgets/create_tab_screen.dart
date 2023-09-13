import 'package:dotted_line/dotted_line.dart';
import 'package:driver/global/models/booking/booking_model.dart';
import 'package:driver/global/services/exceptions/dio_service_exception.dart';
import 'package:driver/global/services/general/booking/booking_service.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/my_rides_status.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/helpers/navigation/launch_screen.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/loader.dart';
import 'package:driver/main.dart';
import 'package:driver/modules/rides/detail/ride_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CreateTabScreen extends StatefulWidget {
  final String? status;

  const CreateTabScreen({super.key, this.status});

  @override
  CreateTabScreenState createState() => CreateTabScreenState();
}

class CreateTabScreenState extends State<CreateTabScreen> {
  String? status;
  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  int totalPage = 1;
  List<String> riderStatus = [COMPLETED, CANCELED];

  static List<BookingModel>? bookingData;

  BookingService bookingService = BookingService();

  @override
  void initState() {
    super.initState();
    status = widget.status ?? COMPLETED;
    fetchBookingData();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  Future<void> fetchBookingData() async {
    try {
      final driverId = await secureStorage.read(key: 'userId');
      final data = await bookingService.getBookingListByDriver(
        driverId!,
      );
      bookingData = data.where((element) => element.status == status).toList();
    } catch (e) {
      if (e is UnknowFetchingDataException) {
        debugPrint('DioServiceException');
      } else {
        debugPrint('Exception: $e');
      }
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return bookingData != null
        ? Observer(
            builder: (context) {
              return Stack(
                children: [
                  AnimationLimiter(
                    child: ListView.builder(
                      itemCount: bookingData?.length ?? 0,
                      controller: scrollController,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          delay: const Duration(milliseconds: 200),
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            child: IntrinsicHeight(
                              child: inkWellWidget(
                                onTap: () {
                                  launchScreen(
                                    context,
                                    RideDetailView(
                                      userId: bookingData?[index].userId ?? '',
                                      driverId: bookingData?[index].driverId ?? '',
                                      customerName: bookingData?[index].customerName ?? '',
                                      customerPhone: bookingData?[index].customerPhone ?? '',
                                      pickupAddress: bookingData?[index].pickupAddress ?? '',
                                      destinationAddress:
                                          bookingData?[index].destinationAddress ?? '',
                                      type: bookingData?[index].type ?? '',
                                      status: bookingData?[index].status ?? '',
                                      createdAt: bookingData?[index].createdAt ?? '',
                                      total: bookingData?[index].total ?? 0,
                                      distance: bookingData?[index].distance ?? 0,
                                      pickupTime: bookingData?[index].pickupTime ?? '',
                                      dropOffTime: bookingData?[index].dropOffTime ?? '',
                                      paymentMethodId: bookingData?[index].paymentMethodId ?? '',
                                      promotionId: bookingData?[index].promotionId ?? '',
                                    ),
                                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(defaultRadius),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: const Offset(0.0, 0.0)),
                                    ],
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Ionicons.calendar,
                                                  color: textSecondaryColor,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    printDate(bookingData?[index].createdAt ?? ''),
                                                    style: primaryTextStyle(size: 14),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Divider(height: 24, thickness: 0.5),
                                        Row(
                                          children: [
                                            const Column(
                                              children: [
                                                Icon(Icons.near_me, color: Colors.green, size: 18),
                                                SizedBox(height: 2),
                                                SizedBox(
                                                  height: 34,
                                                  child: DottedLine(
                                                    direction: Axis.vertical,
                                                    lineLength: double.infinity,
                                                    lineThickness: 1,
                                                    dashLength: 2,
                                                    dashColor: primaryColor,
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Icon(Icons.location_on,
                                                    color: Colors.red, size: 18),
                                              ],
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    bookingData?[index].pickupAddress ?? '',
                                                    style: primaryTextStyle(size: 14),
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(height: 35),
                                                  Text(
                                                    bookingData?[index].destinationAddress ?? '',
                                                    style: primaryTextStyle(size: 14),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: loaderWidget(),
                  ),
                ],
              );
            },
          )
        : loaderWidget();
  }
}
