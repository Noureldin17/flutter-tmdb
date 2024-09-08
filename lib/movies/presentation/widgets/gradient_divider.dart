import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class GradientDivider extends StatelessWidget {
  const GradientDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 0.5.sp,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            colors.primaryDark,
            colors.primaryBlue,
            colors.primaryPurple,
            colors.primaryDark
          ], begin: Alignment.centerRight, end: Alignment.centerLeft),
          color: colors.primaryBlue),
      child: const SizedBox(),
    );
  }
}
