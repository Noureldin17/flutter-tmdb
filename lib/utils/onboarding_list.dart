import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart' as colors;

List<Widget> onBoardingList = [
  Column(
    children: [
      Stack(
        children: [
          Image.asset(
            'assets/posters/shelby2.jpg',
            color: colors.primaryDark.withOpacity(0.3),
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            width: 100.w,
            height: 90.h,
            decoration: const BoxDecoration(
                color: colors.primaryDark,
                gradient: LinearGradient(
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(153, 8, 8, 29),
                      colors.primaryDark
                    ])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 380.sp),
            child: Column(
              children: [
                Text(
                  "Discover",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25.sp, 20.sp, 25.sp, 0.sp),
                  child: Text(
                    "Get information about movies & Tv shows, cast, and crew",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
  Column(
    children: [
      Stack(
        children: [
          Image.asset(
            'assets/posters/wick.jpg',
            color: colors.primaryDark.withOpacity(0.4),
            fit: BoxFit.fitHeight,
            colorBlendMode: BlendMode.darken,
            width: 100.w,
            height: 90.h,
          ),
          Container(
            width: 100.w,
            height: 90.h,
            decoration: const BoxDecoration(
                color: colors.primaryDark,
                gradient: LinearGradient(
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(153, 8, 8, 29),
                      colors.primaryDark
                    ])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 380.sp),
            child: Column(
              children: [
                Text(
                  "Browse Movies",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25.sp, 20.sp, 25.sp, 0.sp),
                  child: Text(
                    "Browse the latest movies available and watch their trailers",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
  Column(
    children: [
      Stack(
        children: [
          Image.asset(
            'assets/posters/leo2.jpg',
            color: colors.primaryDark.withOpacity(0.4),
            fit: BoxFit.fitHeight,
            colorBlendMode: BlendMode.darken,
            width: 100.w,
            height: 90.h,
          ),
          Container(
            width: 100.w,
            height: 90.h,
            decoration: const BoxDecoration(
                color: colors.primaryDark,
                gradient: LinearGradient(
                    stops: [
                      0.1,
                      0.4,
                      0.6,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(153, 8, 8, 29),
                      colors.primaryDark
                    ])),
          ),
          Padding(
            padding: EdgeInsets.only(top: 380.sp),
            child: Column(
              children: [
                Text(
                  "Real Time",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25.sp, 20.sp, 25.sp, 0.sp),
                  child: Text(
                    "Movie & TV information and updates movie trailer",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  )
];
