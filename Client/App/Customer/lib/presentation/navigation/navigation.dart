import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/presentation/home/views/home_page.dart';
import 'package:user/presentation/notification/views/notification_page.dart';
import 'package:user/presentation/order/views/order_page.dart';
import 'package:user/presentation/promotion/views/promotion_page.dart';

import '../../app/constant/color.dart';

class NavigationBottom extends StatefulWidget {
  final int initialIndex;
  const NavigationBottom({super.key, this.initialIndex = 0});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  static int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialIndex;
    _widgetOptions = <Widget>[
      const HomePage(),
      const PromotionPage(),
      const OrderPage(),
      const NotificationPage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        selectedItemColor: COLOR_BLUE_MAIN,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Ưu đãi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            label: 'Chuyến đi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
        ],
      ),
    );
  }
}
