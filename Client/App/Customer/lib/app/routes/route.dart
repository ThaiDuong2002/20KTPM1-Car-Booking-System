import 'package:flutter/material.dart';
import 'package:user/model_gobal/mylocation.dart';
import 'package:user/presentation/booking/confirm_booking/views/confirm_booking_page.dart';
import 'package:user/presentation/booking/in_progress/views/in_progress_booking_view.dart';
import 'package:user/presentation/booking/rating/view/rating_booking_view.dart';
import 'package:user/presentation/callcenter/callcenter_page.dart';
import 'package:user/presentation/detail_notification/views/detail_notification_page.dart';
import 'package:user/presentation/detail_promotion/detail_promotion_page.dart';
import 'package:user/presentation/intial_booking/views/initial_booking_page.dart';
import 'package:user/presentation/intro/views/intro_view.dart';
import 'package:user/presentation/list_promotion/list_promotion_page.dart';
import 'package:user/presentation/order/views/order_page.dart';
import 'package:user/presentation/detail_order/detail_booking_page.dart';
import 'package:user/presentation/promotion/views/promotion_page.dart';
import 'package:user/presentation/upgrade_customer/upgrade_page.dart';
import '../../model_gobal/pick_des.dart';
import '../../presentation/booking/check_address/views/check_addres_view.dart';
import '../../presentation/booking/confirm_booking/views/confirm_booking_view.dart';
import '../../presentation/menu_option/changeLanguagePage/views/changeLanguage_page.dart';
import '../../presentation/menu_option/manageAccount/views/manegement_page.dart';
import '../../presentation/menu_option/methodPaymentPage/views/methodPayment_page.dart';
import '../../presentation/menu_option/placeFavoritePage/views/placeFavorite_page.dart';
import '../../presentation/navigation/navigation.dart';
import '../../presentation/presentation.dart';
import '../../presentation/search_location_page/views/search_location_page.dart';
import '../../presentation/user/views/user_infor_page.dart';
import '../../presentation/editProfile/views/editProfile_page.dart';
import 'route_name.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // check các điều kiện để trả về route tương ứng với settings.name
    switch (settings.name) {
      case AppRouterName.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRouterName.userInformationPage:
        return MaterialPageRoute(builder: (_) => const UserInforPage());
      case AppRouterName.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRouterName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRouterName.introPage:
        return MaterialPageRoute(builder: (_) => const IntroView());
      case AppRouterName.orderPage:
        return MaterialPageRoute(builder: (_) => const OrderPage());
      case AppRouterName.promotionPageMenu:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NavigationBottom(initialIndex: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.orderPageMenu:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NavigationBottom(initialIndex: 2),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      case AppRouterName.promotionPage:
        return MaterialPageRoute(builder: (_) => const PromotionPage());
      case AppRouterName.intialBookingPage:
        return MaterialPageRoute(builder: (_) => const InitalBookingPage());
      case AppRouterName.navigation:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NavigationBottom(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      case AppRouterName.detailPromotionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DetailPromotionPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.detailPromotionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DetailPromotionPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.methodPaymentPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MethodPaymentPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.changeLanguagePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ChangeLanguagePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.manageAccountPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ManagementPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.placeFavoritePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PlaceFavoritePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.detailNotification:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DetailNotificationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.orderDetailPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DetailOrderPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.callCentarPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CallcenterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.listPromotionPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ListPromotionPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.upgradePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UpgradePCustomerPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      case AppRouterName.searchPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SearchLocationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.checkAddressPage:
        final MyLocation data = args as MyLocation;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CheckAddressView(
            currentLocation: data,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.confirmBookingPage:
        final PickUpAndDestication data = args as PickUpAndDestication;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ConfirmBookingView(
            data: data,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.ratingPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => RatingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.inProgressPage:
        final PickUpAndDestication data = args as PickUpAndDestication;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              InProgressBookingView(
            data: data,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case AppRouterName.editProfilePage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EditProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      default:
        _errPage();
    }
    return _errPage();
  }

  static Route _errPage() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No Router! Please check your configuration'),
        ),
      );
    });
  }
}
