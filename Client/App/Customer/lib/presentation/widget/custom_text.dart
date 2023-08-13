import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines=1,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines.toInt(),
      style: GoogleFonts.montserrat(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
