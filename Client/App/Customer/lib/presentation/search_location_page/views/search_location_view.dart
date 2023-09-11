import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/model_gobal/pick_des.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_bloc.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_event.dart';
import 'package:user/presentation/search_location_page/blocs/search_location_state.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../../model_gobal/mylocation.dart';

class SearchLocationView extends StatefulWidget {
  const SearchLocationView({super.key});

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  final _controller_location = TextEditingController();
  final _controller_current_location = TextEditingController();
  Timer? _debounceTimer;
  bool _isPersonalSelected = true;

  @override
  void initState() {
    // TODO: implement initState

    _controller_current_location.text = "Vị trí hiện tại";
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentLocation = Provider.of<MyLocation>(context, listen: false);
    print("rebuild searchb");
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Bạn muốn đi đâu ?",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            child: const Icon(Icons.location_on_outlined)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              _controller_current_location.text = "";
                            },
                            onChanged: (value) {
                              // print("123");

                              // context.read<SearchLocationBloc>().add(
                              //     SearchLocationEventSearch(
                              //         value, currentLocation));
                            },
                            controller: _controller_current_location,
                            decoration: const InputDecoration(
                              hintText: "Chọn điểm đến",
                              border: InputBorder.none, // Loại bỏ viền mặc định
                            ),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade600,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: const Icon(Icons.add_location_alt_outlined),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          // Sử dụng Expanded để đảm bảo TextField chiếm đủ không gian còn lại
                          child: TextFormField(
                            onChanged: (value) {
                              // Hủy timer cũ nếu nó đang chạy
                              _debounceTimer?.cancel();

                              // Tạo timer mới để chờ 2 giây trước khi thực hiện hành động
                              _debounceTimer =
                                  Timer(const Duration(milliseconds: 500), () {
                                context.read<SearchLocationBloc>().add(
                                    SearchLocationEventSearch(
                                        value, currentLocation));
                              });
                            },
                            controller: _controller_location,
                            decoration: const InputDecoration(
                              hintText: "Tìm điểm đón",
                              border: InputBorder.none, // Loại bỏ viền mặc định
                            ),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: () {
                            print("Về trang Search page");
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.map,
                                size: 16,
                                color: Color.fromARGB(255, 22, 20, 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Chọn bằng bản đồ",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
              BlocBuilder<SearchLocationBloc, SearchLocationState>(
                builder: (context, state) {
                  if (state is SearchLocationStateInitial) {
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
                          const SizedBox(
                            height: 10,
                          ),
                          const TextCustom(
                              text:
                                  "Vi vu, tận hưởng chuyến đi từ RideNow nhé !",
                              color: COLOR_TEXT_MAIN,
                              fontSize: FONT_SIZE_NORMAL,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    );
                  }
                  if (state is SearchLocationStateLoading) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Lottie.asset("assets/loading.json",
                            height: 50, width: 50),
                      ),
                    );
                  } else if (state is SearchLocationStateSuccess) {
                    print(state.searchEntities.length);
                    if (state.searchEntities.length == 0) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Center(
                          child: Text("Không tìm thấy kết quả"),
                        ),
                      );
                    } else
                      return Expanded(
                          child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.searchEntities.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var updateLocation =
                                  Provider.of<PickUpAndDestication>(context,
                                      listen: false);

                              updateLocation.pickUpLocation =
                                  state.searchEntities[index];

                              Navigator.pushNamed(context, '/checkAddressPage',
                                  arguments: currentLocation);
                            },
                            child: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextCustom(
                                              text: state.searchEntities[index]
                                                          .distance >
                                                      100
                                                  ? state.searchEntities[index]
                                                          .distance
                                                          .toString() +
                                                      " m"
                                                  : state.searchEntities[index]
                                                          .distance
                                                          .toString() +
                                                      " km",
                                              color: COLOR_TEXT_MAIN,
                                              fontSize: FONT_SIZE_SMALL,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextCustom(
                                              text: state
                                                  .searchEntities[index].title
                                                  .toString(),
                                              color: COLOR_TEXT_BLACK,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextCustom(
                                              text: state
                                                  .searchEntities[index].label
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              color: COLOR_TEXT_MAIN,
                                              fontSize: FONT_SIZE_SMALL,
                                              maxLines: 3,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () {
                                            final searchLocation = BlocProvider
                                                .of<SearchLocationBloc>(
                                                    context);
                                            showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )),
                                              context: context,
                                              builder: (context) {
                                                return BlocProvider.value(
                                                  value: searchLocation,
                                                  child: StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        height: 300,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const TextCustom(
                                                                  text:
                                                                      "Thêm địa chỉ",
                                                                  color:
                                                                      COLOR_TEXT_BLACK,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Divider(
                                                                height: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextCustom(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text: state
                                                                      .searchEntities[
                                                                          index]
                                                                      .title,
                                                                  color:
                                                                      COLOR_TEXT_BLACK,
                                                                  fontSize:
                                                                      FONT_SIZE_NORMAL,
                                                                  maxLines: 3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextCustom(
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  text: state
                                                                      .searchEntities[
                                                                          index]
                                                                      .label,
                                                                  color:
                                                                      COLOR_TEXT_BLACK,
                                                                  maxLines: 3,
                                                                  fontSize:
                                                                      FONT_SIZE_NORMAL,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _isPersonalSelected =
                                                                              true;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: _isPersonalSelected
                                                                              ? Colors.blue.shade200
                                                                              : Colors.grey.shade200,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Cá nhân",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Expanded(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _isPersonalSelected =
                                                                              false;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: !_isPersonalSelected
                                                                              ? Colors.blue.shade200
                                                                              : Colors.grey.shade200,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Công ty",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            COLOR_BLUE_MAIN,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        searchLocation.add(SearchLocationEventSearchAddList(
                                                                            item: state.searchEntities[
                                                                                index],
                                                                            type: _isPersonalSelected == true
                                                                                ? "Personal"
                                                                                : "Work"));
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Center(
                                                                        child: TextCustom(
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            text:
                                                                                "Thêm vào danh sách địa chỉ cá nhân",
                                                                            color: Colors
                                                                                .white,
                                                                            maxLines:
                                                                                3,
                                                                            fontSize:
                                                                                FONT_SIZE_NORMAL,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ],
                                                              )
                                                            ]),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Center(
                                              child: Icon(
                                            Icons.bookmark,
                                            color: Colors.grey.shade400,
                                          )),
                                        ))
                                  ],
                                )),
                          );
                        },
                      ));
                  }

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
                        const SizedBox(
                          height: 10,
                        ),
                        const TextCustom(
                            text: "Vi vu, tận hưởng chuyến đi từ RideNow nhé !",
                            color: COLOR_TEXT_MAIN,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
