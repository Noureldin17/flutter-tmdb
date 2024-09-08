import 'package:flutter/material.dart';
import 'package:flutter_tmdb/authentication/presentation/widgets/custom_outline.dart';
import '../../../../utils/colors.dart' as colors;
import 'package:sizer/sizer.dart';

import '../../../../utils/default_text.dart';

class GradientButton extends StatefulWidget {
  const GradientButton(
      {super.key, required this.onButtonPressed, required this.buttonText});
  final Function onButtonPressed;
  final String buttonText;
  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.sp),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colors.primaryBlue, colors.primaryPurple]),
        ),
        child: UnicornOutlineButton(
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 167, 204, 241),
                Color.fromARGB(255, 193, 152, 207)
              ]),
          onPressed: () {},
          radius: 8.sp,
          strokeWidth: 1.sp,
          child: ElevatedButton(
            onPressed: () {
              widget.onButtonPressed();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp)),
                elevation: 4.sp,
                shadowColor: Colors.transparent,
                fixedSize: Size(90.w, 35.sp),
                padding: EdgeInsets.all(0.sp),
                backgroundColor: Colors.transparent),
            child: DefaultText.bold(text: widget.buttonText, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
