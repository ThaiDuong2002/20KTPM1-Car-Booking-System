import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int _currentIndex = 0;
  static final List order_history = [
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Chuyến đi đến",
      "total": "33.000đ",
      "time": "Thứ 2, 12/07/2021 10:00",
      "destination": "123 Nguyễn Thị Minh Khai, Quận 1, TP.HCM",
      "type": "bike",
    },
    {
      "image": "assets/images/order/car_icon.png",
      "title": "Chuyến đi đến",
      "total": "123.000đ",
      "time": "Thứ 2, 12/07/2021 10:00",
      "destination": "13, Phường Hiệp Bình Phước, TP.HCM",
      "type": "car",
    },
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Chuyến đi đến",
      "total": "233.000đ",
      "time": "Thứ 2, 12/07/2021 10:00",
      "destination": "227 Nguyễn Văn Cừ,Quận 5, TP.HCM",
      "type": "bike",
    },
  ];
  static final List order_current = [
    {
      "image": "assets/images/order/bike_icon.png",
      "title": "Chuyến đi đến",
      "total": "33.000đ",
      "time": "Thứ 2, 12/07/2021 10:00",
      "destination": "123 Nguyễn Thị Minh Khai, Quận 1, TP.HCM",
      "type": "bike",
    },
  ];

  void _handleTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text('Chuyến đi',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black)),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    isScrollable: true,
                    labelStyle: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    unselectedLabelColor: Colors.grey,
                    onTap: _handleTabTap,
                    tabs: const [
                      Tab(text: 'Chuyến đi hiện tại'),
                      Tab(text: 'Lịch sử'),
                      Tab(text: 'Đặt trước'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ListView.builder(
                          itemCount: order_current.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/orderDetailPage');
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 5, top: 25),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Image.asset(
                                            order_current[index]["image"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: TextCustom(
                                                    text:
                                                        'Chuyến đi đến ${order_current[index]["destination"]}',
                                                    color: COLOR_TEXT_BLACK,
                                                    fontSize: FONT_SIZE_NORMAL,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                child: TextCustom(
                                                    text: order_current[index]
                                                        ["time"],
                                                    color: COLOR_TEXT_MAIN,
                                                    fontSize: FONT_SIZE_NORMAL,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(
                                              right: 10, top: 20),
                                          child: TextCustom(
                                              text:
                                                  '${order_current[index]["total"]}',
                                              color: COLOR_TEXT_BLACK,
                                              fontSize: FONT_SIZE_SMALL_X,
                                              fontWeight: FontWeight.w600),
                                        ))
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: order_history.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/orderDetailPage');
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 5, top: 25),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Image.asset(
                                            order_history[index]["image"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: TextCustom(
                                                    text:
                                                        'Chuyến đi đến ${order_history[index]["destination"]}',
                                                    color: COLOR_TEXT_BLACK,
                                                    fontSize: FONT_SIZE_NORMAL,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                child: TextCustom(
                                                    text: order_history[index]
                                                        ["time"],
                                                    color: COLOR_TEXT_MAIN,
                                                    fontSize: FONT_SIZE_NORMAL,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(
                                              right: 10, top: 20),
                                          child: TextCustom(
                                              text:
                                                  '${order_history[index]["total"]}',
                                              color: COLOR_TEXT_BLACK,
                                              fontSize: FONT_SIZE_SMALL,
                                              fontWeight: FontWeight.w600),
                                        ))
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                        Center(
                          child: Text('Đặt trước'),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
