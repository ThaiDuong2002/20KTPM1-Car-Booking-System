import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/widget/custom_text.dart';

class HomeView extends StatelessWidget {
  static final List promotion = [
    {
      "image": "assets/images/promotion/2.png",
      "title": "Ưu đãi cuốc xe cho thành viên mới",
      "description": "Giảm 50% cho đơn hàng đầu tiên",
    },
    {
      "image": "assets/images/promotion/2.png",
      "title": "Ưu đãi cuốc xe cho thành viên mới",
      "description": "Giảm 50% cho đơn hàng đầu tiên",
    },
    {
      "image": "assets/images/promotion/2.png",
      "title": "Ưu đãi cuốc xe cho thành viên mới",
      "description": "Giảm 50% cho đơn hàng đầu tiên",
    },
  ];
  static final List IconBooking = [
    {
      "image": "assets/images/home/bike.png",
      "title": "GoBike",
      "route": "/initialBookingPage",
      "slug": 'bike'
    },
    {
      "image": "assets/images/home/car.png",
      "title": "GoCar",
      "route": "/initialBookingPage",
      "slug": 'car'
    },
    {
      "image": "assets/images/home/food.png",
      "title": "GoFood",
      "route": "/initialBookingPage",
      "slug": 'food'
    },
    {
      "image": "assets/images/home/send.png",
      "title": "GoSend",
      "route": "/initialBookingPage",
      "slug": 'send'
    },
  ];
  static final List moreUtilsList = [
    {
      "image": "assets/images/icons/star.png",
      "title": "Gói hội viên",
      "route": "/upgradePage",
      "slug": 'bike'
    },
    {
      "image": "assets/images/icons/promotion.png",
      "title": "Tìm ưu đãi",
      "route": "/listPromotionPage",
      "slug": 'car'
    },
    {
      "image": "assets/images/icons/call.png",
      "title": "Tổng đài",
      "route": "/callCentarPage",
      "slug": 'car'
    }
  ];
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print("rebuild home");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.1), // 10% of screen height
          child: AppBar(
            backgroundColor: COLOR_BLUE_MAIN,
            flexibleSpace: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.04, // 2% of screen height
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: MediaQuery.of(context).size.height *
                            0.08, // 8% of screen height
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height *
                                0.01, // 2% of screen height
                            horizontal: MediaQuery.of(context).size.width *
                                0.02), // 2% of screen width
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchBar(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                leading: InkWell(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    print('search');
                                  },
                                ),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.02, // 2% of screen width
                                        vertical: 0)),
                                hintText: 'Tìm dịch vụ , món ngon, địa điểm',
                                hintStyle: MaterialStatePropertyAll(TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/userInformationPage');
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.02), // 2% of screen width
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ...IconBooking.map((item) => Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/initialBookingPage',
                                    arguments: item['slug']);
                              },
                              child: Column(
                                children: [
                                  Image(
                                    height: 50,
                                    width: 80,
                                    image: AssetImage(item['image']),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Text(
                                    item['title'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )).toList(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Image(
                          width: 20,
                          height: 20,
                          image: AssetImage("assets/images/icons/icon.png"),
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: "GoCar",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: " | ",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "GoRide",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                    CarouselSlider.builder(
                        itemCount: promotion.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/detailPromotionPage',
                                  arguments: promotion[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    promotion[index]['title'],
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    promotion[index]['description'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                          promotion[index]['image'])),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 265,
                          aspectRatio: 18 / 9,
                          viewportFraction: 0.92,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          padEnds: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.1,
                          scrollDirection: Axis.horizontal,
                        )),
                  ],
                ),
                Row(
                  children: [
                    const Image(
                      width: 20,
                      height: 20,
                      image: AssetImage("assets/images/icons/icon.png"),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tiện ích",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " | ",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "RideNow Unlimited",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    itemCount: moreUtilsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, moreUtilsList[index]['route'],
                                arguments: moreUtilsList[index]);
                          },
                          child: Container(
                            height: 20,
                            margin: const EdgeInsets.only(
                                right: 10, bottom: 10, top: 2),
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(75, 172, 228, 1),
                                  Color.fromRGBO(75, 172, 228, 0.9),
                                  Color.fromRGBO(75, 172, 228, 0.8),
                                  Color.fromRGBO(76, 166, 255, 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextCustom(
                                    text: moreUtilsList[index]['title'],
                                    color: Colors.white,
                                    fontSize: FONT_SIZE_NORMAL,
                                    fontWeight: FontWeight.w700),
                                Image.asset(
                                  moreUtilsList[index]['image'],
                                  height: 15,
                                  width: 15,
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
