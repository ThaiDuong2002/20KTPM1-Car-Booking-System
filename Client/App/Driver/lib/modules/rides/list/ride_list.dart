import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/my_rides_status.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/modules/rides/list/widgets/create_tab_screen.dart';
import 'package:flutter/material.dart';

class RideListView extends StatefulWidget {
  const RideListView({super.key});

  @override
  State<RideListView> createState() => _RideListViewState();
}

class _RideListViewState extends State<RideListView> {
  List<String> riderStatus = [
    COMPLETED,
    CANCELED,
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Rides',
            style: boldTextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
              decoration: BoxDecoration(
                color: dividerColor,
                borderRadius: radius(),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: radius(),
                  color: primaryColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: primaryColor,
                labelStyle: boldTextStyle(color: Colors.white, size: 14),
                tabs: riderStatus.map((e) {
                  return Tab(
                    child: Text(changeStatusText(e)),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: riderStatus.map((e) {
                  return CreateTabScreen(status: e);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
