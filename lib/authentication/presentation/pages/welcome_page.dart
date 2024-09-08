import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;
import 'package:sizer/sizer.dart';

import '../../../utils/default_text.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/custom_outline.dart';
import '../widgets/gradient_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: colors.primaryDark,
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 110.sp),
                  child: ClipPath(
                    clipBehavior: Clip.hardEdge,
                    clipper: DiagonalPathClipperTwo(),
                    child: Container(
                      padding: EdgeInsets.only(top: 50.sp),
                      width: 100.w,
                      height: 200.sp,
                      child: Image.asset(
                        'assets/posters/meg.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.sp),
                  child: ClipPath(
                    clipper: DiagonalPathClipperTwo(),
                    child: Container(
                      width: 100.w,
                      height: 130.sp,
                      color: colors.primaryDark,
                    ),
                  ),
                ),
                ClipPath(
                  clipBehavior: Clip.hardEdge,
                  clipper: DiagonalPathClipperTwo(),
                  child: Container(
                    padding: EdgeInsets.only(top: 50.sp),
                    width: 100.w,
                    height: 200.sp,
                    child: Image.asset(
                      'assets/posters/jumanji.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DiagonalPathClipperTwo(),
                  child: Container(
                    width: 100.w,
                    height: 100.sp,
                    color: colors.primaryDark,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30.sp)),
            const DefaultText.bold(text: "Welcome!", fontSize: 26),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            GradientButton(onButtonPressed: () {}, buttonText: "Register"),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            UnicornOutlineButton(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [colors.primaryBlue, colors.primaryPurple]),
              onPressed: () {},
              radius: 8.sp,
              strokeWidth: 2.sp,
              child: ElevatedButton(
                onPressed: (() {
                  Navigator.pushNamed(context, pages.loginPage);
                }),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp)),
                    elevation: 4.sp,
                    shadowColor: Colors.transparent,
                    fixedSize: Size(90.w, 35.sp),
                    padding: EdgeInsets.all(0.sp),
                    backgroundColor: Colors.transparent),
                child: const DefaultText.bold(text: "Login", fontSize: 14),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(GuestLoginEvent());
              },
              child: Text(
                "Continue as guest",
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is GuestLoginSuccessState) {
                  Navigator.pushReplacementNamed(context, pages.appMainPage);
                  EasyLoading.showSuccess('Login Success',
                      duration: const Duration(milliseconds: 700));
                } else if (state is LoginLoadingState) {
                  EasyLoading.show(status: "Logging in...");
                } else if (state is GuestLoginErrorState) {
                  EasyLoading.showError(' Login Error ',
                      duration: const Duration(milliseconds: 700));
                }
              },
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
