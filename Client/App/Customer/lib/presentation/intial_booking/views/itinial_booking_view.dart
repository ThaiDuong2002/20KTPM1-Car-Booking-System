import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user/app/constant/color.dart';

import '../../../model_gobal/mylocation.dart';

class InitialBokingView extends StatelessWidget {
  const InitialBokingView({super.key});
  @override
  Widget build(BuildContext context) {
    print("rebuild initial booking view");
      var myLocation = Provider.of<MyLocation>(context, listen: false);
      print(myLocation.toString());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Column(
          children: [
            Image.asset(
              'assets/images/home/1.png',
              height: 300,
              width: 500,
              fit: BoxFit.fitWidth,
            ),
            Expanded(
                child: Container(
              color: Colors.grey.shade100,
            ))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: COLOR_BLUE_MAIN,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hé lu, Thanh',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Bạn muốn đi đâu?',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        height: 150,
                        child: const ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            // compassEnabled: false,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(10.8415169, 106.7098374),
                                zoom: 12),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(200, 249, 249, 249),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                enabled: true,
                                onTap: () {
                                  Navigator.popAndPushNamed(
                                      context, '/searchPage');
                                },
                                decoration: InputDecoration(
                                  enabled: false,
                                  hintText: 'Tìm điểm đến',
                                  hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                print('search');
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.bookmark_add,
                                size: MediaQuery.of(context).size.width *
                                    0.1, // 10% of screen width
                                color: COLOR_BLUE_MAIN,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.03, // 3% of screen height
                            ),
                            Text(
                              "Lưu địa điểm để đặt chuyến nhanh hơn",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035, // 3.5% of screen width
                                  color: Colors.black),
                            ),
                            Text(
                              "Để đỡ tốn công điền thông tin, hãy lưu địa điểm quen thuộc nhé!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.03, // 3% of screen width
                                  color: Colors.grey.shade500),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.01, // 1% of screen height
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.02, // 2% of screen width
                                  ),
                                  height: MediaQuery.of(context).size.height *
                                      0.05, // 5% of screen height
                                  decoration: BoxDecoration(
                                    color: COLOR_BLUE_MAIN,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/placeFavoritePage');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Lưu nhà riêng",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03, // 3% of screen width
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/placeFavoritePage');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.02, // 2% of screen width
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.05, // 5% of screen height
                                    decoration: BoxDecoration(
                                      color: COLOR_BLUE_MAIN,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.business,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Lưu công ty",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03, // 3% of screen width
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
        ),
        Positioned(
          top:
              MediaQuery.of(context).size.height * 0.05, // Position from bottom
          left: 20.0,
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.navigate_before, color: Colors.black)),
        ),
      ]),
    );
  }
}
