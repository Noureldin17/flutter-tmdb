import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;
import '../../../utils/default_text.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkboxValue = true;
  final formkey = GlobalKey<FormState>();
  final usernamekey = GlobalKey<FormFieldState>();
  final passwordkey = GlobalKey<FormFieldState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: colors.primaryDark,
          centerTitle: true,
          title: const DefaultText.bold(text: "Login", fontSize: 18),
        ),
        backgroundColor: colors.primaryDark,
        body: Column(
          children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50.sp, left: 10.sp, right: 10.sp),
                      child: TextFormField(
                        key: usernamekey,
                        onChanged: (value) {
                          usernamekey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty please enter your username";
                          } else if (value.length < 4) {
                            return "Username should be at least 4 characters long";
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            border: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            labelStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            labelText: "Username",
                            hintStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            hintText: "Enter your username"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.sp, left: 10.sp, right: 10.sp),
                      child: TextFormField(
                        key: passwordkey,
                        onChanged: (value) {
                          passwordkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is empty please enter your password";
                          } else if (value.length < 4) {
                            return "Password should be at least 4 characters long";
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: passwordHidden,
                        decoration: InputDecoration(
                            suffixIcon: passwordHidden
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordHidden = !passwordHidden;
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/eye.svg',
                                      color: colors.primaryGrey,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordHidden = !passwordHidden;
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/eye-slash.svg',
                                      color: colors.primaryGrey,
                                    )),
                            focusedBorder: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            border: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            labelStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            labelText: "Password",
                            hintStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            hintText: "Enter your password"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp, right: 12.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(children: [
                              Checkbox(
                                side:
                                    const BorderSide(color: colors.primaryGrey),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.sp)),
                                value: checkboxValue,
                                onChanged: (value) {
                                  setState(() {
                                    checkboxValue = value!;
                                  });
                                },
                              ),
                              const DefaultText.normal(
                                  text: "Keep me signed in", fontSize: 10)
                            ]),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.roboto(
                                color: colors.primaryGrey,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.sp)),
                    GradientButton(
                        onButtonPressed: () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                LoginEvent(usernameController.text,
                                    passwordController.text, checkboxValue));
                          }
                        },
                        buttonText: "Login"),
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state is LoginSuccessState) {
                          Navigator.pushReplacementNamed(
                              context, pages.appMainPage);
                          EasyLoading.showSuccess('Login Success',
                              duration: const Duration(milliseconds: 700));
                        } else if (state is LoginLoadingState) {
                          EasyLoading.show(status: "Logging in...");
                        } else if (state is LoginErrorState) {
                          EasyLoading.showError(' Login Error ',
                              duration: const Duration(milliseconds: 700));
                        }
                      },
                      child: Container(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
