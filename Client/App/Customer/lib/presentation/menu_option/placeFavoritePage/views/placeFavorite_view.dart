import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/presentation/menu_option/placeFavoritePage/model/address.dart';

import '../../../../app/constant/color.dart';
import '../../../../app/constant/size.dart';
import '../../../widget/custom_text.dart';
import '../blocs/placeFavorite_bloc.dart';
import '../blocs/placeFavorite_state.dart';
import '../widget/placeItem.dart';

class PlaceFavoriteView extends StatelessWidget {
  const PlaceFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: COLOR_BLUE_LIGHT,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/searchPage');
            },
            child: const Center(
              child: TextCustom(
                  text: "Thêm địa điểm",
                  color: Colors.white,
                  fontSize: FONT_SIZE_LARGE,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                alignment:
                    const Alignment(-0.2, 1), // move icon a bit to the left
              );
            },
          ),
          backgroundColor: Colors.white,
          title: const TextCustom(
            text: "Địa điểm quen thuộc",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
          builder: (context, state) {
            if (state is FavoritePlaceInitial) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/icons/no_place.png",
                        height: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextCustom(
                        text: "Bạn chưa lưu địa điểm nào !!",
                        color: COLOR_TEXT_MAIN,
                        fontSize: FONT_SIZE_NORMAL,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              );
            }
            if (state is FavoritePlaceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoritePlaceFetchData) {
              List<Address> personalLocations = state.addresses
                  .where((location) => location.type == "Personal")
                  .toList();
              List<Address> workLocations = state.addresses
                  .where((location) => location.type == "Work")
                  .toList();
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: COLOR_TEXT_BLACK,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: FONT_SIZE_NORMAL,
                              color: COLOR_TEXT_MAIN,
                            ),
                            indicatorColor: COLOR_BLUE_MAIN,
                            tabs: const [
                              Tab(text: "Cá nhân"),
                              Tab(text: "Công ty"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 15.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: personalLocations.length,
                                      itemBuilder: (context, index) {
                                        return ExpandableContainer(
                                          address: personalLocations[index],
                                        );
                                      }),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: workLocations.length,
                                      itemBuilder: (context, index) {
                                        return ExpandableContainer(
                                          address: workLocations[index],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )));
            }

            return SizedBox();
          },
        ));
  }
}
