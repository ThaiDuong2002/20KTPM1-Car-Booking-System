import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:flutter/material.dart';

Widget loaderWidget() {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0.0, 0.0)),
        ],
      ),
      width: 50,
      height: 50,
      child: const CircularProgressIndicator(strokeWidth: 3),
    ),
  );
}

class Loader extends StatefulWidget {
  final Color? color;

  @Deprecated(
    'accentColor is now deprecated and not being used. use defaultLoaderAccentColorGlobal instead',
  )
  final Color? accentColor;
  final Decoration? decoration;
  final int? size;
  final double? value;
  final Animation<Color?>? valueColor;

  const Loader({
    super.key,
    this.color,
    this.decoration,
    this.size,
    this.value,
    this.valueColor,
    this.accentColor,
  });

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 40,
        width: 40,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.color ?? defaultLoaderBgColorGlobal,
              shape: BoxShape.circle,
              boxShadow: defaultBoxShadow(),
            ),
        //Progress color uses accentColor from ThemeData
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: widget.value,
        ),
      ),
    );
  }
}
