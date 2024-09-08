import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class ProfileItem extends StatefulWidget {
  const ProfileItem(
      {super.key,
      required this.active,
      required this.iconAsset,
      required this.text,
      required this.onPressed});
  final bool active;
  final String iconAsset;
  final String text;
  final Function onPressed;
  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26.sp,
      child: InkWell(
        onTap: () {
          widget.onPressed();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.sp, 6.sp, 16.sp, 0.sp),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/${widget.iconAsset}',
                height: 20.sp,
                width: 20.sp,
                color: widget.text == "Logout"
                    ? const Color.fromARGB(255, 165, 56, 22)
                    : widget.active
                        ? Colors.white
                        : colors.primaryGrey,
              ),
              Padding(padding: EdgeInsets.only(left: 18.sp)),
              Text(
                widget.text,
                style: GoogleFonts.roboto(
                    color: widget.text == "Logout"
                        ? const Color.fromARGB(255, 165, 56, 22)
                        : widget.active
                            ? Colors.white
                            : colors.primaryGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
