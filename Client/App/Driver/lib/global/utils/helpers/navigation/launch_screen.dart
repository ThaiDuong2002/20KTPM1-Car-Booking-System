import 'package:flutter/material.dart';

/// Launch a new screen
Future<T?> launchScreen<T>(
  BuildContext context,
  Widget child, {
  bool isNewTask = false,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
}) async {
  if (isNewTask) {
    return await Navigator.of(context).pushAndRemoveUntil(
      buildPageRoute(child, pageRouteAnimation, duration),
      (route) => false,
    );
  } else {
    return await Navigator.of(context).push(
      buildPageRoute(child, pageRouteAnimation, duration),
    );
  }
}

// ignore: constant_identifier_names
enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

Route<T> buildPageRoute<T>(
  Widget? child,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.Fade) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child!,
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 1000),
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Rotate) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child!,
        transitionsBuilder: (c, anim, a2, child) => RotationTransition(
          turns: ReverseAnimation(anim),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 700),
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Scale) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child!,
        transitionsBuilder: (c, anim, a2, child) => ScaleTransition(
          scale: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 700),
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Slide) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child!,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(anim),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 500),
      );
    } else if (pageRouteAnimation == PageRouteAnimation.SlideBottomTop) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child!,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).animate(anim),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
  }
  return MaterialPageRoute<T>(builder: (_) => child!);
}
