import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(
      {required this.text,
      required this.fontSize,
      required this.fontWeight,
      super.key});

  const DefaultText.normal(
      {required this.text, required this.fontSize, super.key})
      : fontWeight = FontWeight.normal;

  const DefaultText.bold(
      {required this.text, required this.fontSize, super.key})
      : fontWeight = FontWeight.bold;

  final String text;
  final int fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 5,
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
