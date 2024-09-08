import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../utils/default_text.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({super.key, required this.overview});
  final String overview;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 2.sp,
                height: 16.sp,
                color: colors.primaryBlue,
              ),
              Padding(padding: EdgeInsets.only(left: 6.sp)),
              const DefaultText.bold(text: 'Description', fontSize: 16)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 6.sp)),
          Text(
            overview,
            style: GoogleFonts.roboto(
                height: 1.sp,
                color: colors.primaryGrey,
                fontWeight: FontWeight.normal,
                fontSize: 11.sp),
          )
        ],
      ),
    );
  }
}
