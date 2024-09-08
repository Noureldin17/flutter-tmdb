import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
// import '../../../../utils/pages.dart' as pages;

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.enabled,
    required this.onSearch,
  });

  final bool enabled;
  final Function onSearch;
  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 40.sp,
      child: TextFormField(
        textInputAction: TextInputAction.search,
        autofocus: true,
        enabled: widget.enabled,
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            widget.onSearch(value);
          }
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.onSearch(value);
          }
        },
        controller: controller,
        style: GoogleFonts.roboto(color: Colors.white),
        decoration: InputDecoration(
            prefixIconConstraints:
                BoxConstraints(maxHeight: 35.sp, maxWidth: 35.sp),
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset('assets/navbar_icons/search.svg',
                  height: 25.sp, width: 25.sp, color: Colors.white),
            ),
            focusedBorder: GradientOutlineInputBorder(
                borderRadius: BorderRadius.circular(22.sp),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [colors.primaryBlue, colors.primaryPurple])),
            border: GradientOutlineInputBorder(
                borderRadius: BorderRadius.circular(22.sp),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [colors.primaryBlue, colors.primaryPurple])),
            labelStyle: const TextStyle(
              color: colors.primaryGrey,
            ),
            // labelText: "Username",
            hintStyle: GoogleFonts.roboto(
              color: colors.primaryGrey,
            ),
            hintText: "Search for movies..."),
      ),
    );
  }
}
