import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class MovieInfoItem extends StatelessWidget {
  const MovieInfoItem({
    super.key,
    required this.imageAsset,
    required this.label,
  });
  final String imageAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/$imageAsset.svg',
          color: colors.primaryGrey,
        ),
        Padding(padding: EdgeInsets.only(left: 6.sp)),
        Text(
          label,
          style: GoogleFonts.roboto(
              color: colors.primaryGrey,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
