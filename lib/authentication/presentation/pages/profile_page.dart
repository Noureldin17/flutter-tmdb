import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;
import '../../../movies/presentation/widgets/gradient_divider.dart';
import '../../../utils/default_text.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/profile_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context).add(GetUserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colors.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const DefaultText.bold(text: "Profile", fontSize: 18),
        actions: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) => current is LogoutSuccessState,
              listener: (context, state) {
                Navigator.of(context).pushReplacementNamed(pages.welcomePage);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 12.sp),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    splashRadius: 18.sp,
                    onPressed: () {
                      onLogout();
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/logout.svg',
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 280.sp,
                width: 100.w,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      colors.primaryBlue,
                      colors.primaryDark,
                      // colors.primaryDark,
                      colors.primaryPurple
                    ])),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
                  child: SizedBox(
                    height: 100.sp,
                    width: 100.w,
                  ),
                ),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                buildWhen: (previous, current) =>
                    current is UserDetailsSuccess ||
                    current is UserDetailsLoading ||
                    current is UserDetailsError,
                builder: (context, state) {
                  if (state is UserDetailsSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 40.sp)),
                        state.user.avatar != ''
                            ? CachedNetworkImage(
                                imageUrl:
                                    '${TMDBApiConstants.IMAGE_BASE_URL}${state.user.avatar}',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage: imageProvider,
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage: const AssetImage(
                                      'assets/blank-profile.png'),
                                ),
                                placeholder: (context, url) => CircleAvatar(
                                  radius: 25.sp,
                                  child: Container(
                                    height: 100.sp,
                                    width: 100.sp,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.sp),
                                        gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              colors.shimmerBase,
                                              colors.shimmerLoad
                                            ])),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                foregroundImage: const AssetImage(
                                    'assets/blank-profile.png'),
                                radius: 50.sp,
                                backgroundImage: const AssetImage(
                                    'assets/blank-profile.png'),
                              ),
                        Padding(padding: EdgeInsets.only(top: 25.sp)),
                        DefaultText.bold(text: state.user.name, fontSize: 16),
                        Padding(padding: EdgeInsets.only(top: 4.sp)),
                        Text(
                          '@${state.user.username}',
                          style: GoogleFonts.roboto(
                              color: colors.primaryGrey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  } else if (state is UserDetailsLoading) {
                    return SizedBox(
                      height: 280.sp,
                      width: 100.w,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: colors.primaryBlue),
                      ),
                    );
                  } else if (state is UserDetailsError) {
                    return Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 40.sp)),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundImage:
                              const AssetImage('assets/blank-profile.png'),
                          radius: 50.sp,
                          backgroundImage:
                              const AssetImage('assets/blank-profile.png'),
                        ),
                        Padding(padding: EdgeInsets.only(top: 12.sp)),
                        const DefaultText.bold(
                            text: "Guest User", fontSize: 16),
                        Padding(padding: EdgeInsets.only(top: 4.sp)),
                        Text(
                          '@guest_username',
                          style: GoogleFonts.roboto(
                              color: colors.primaryGrey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
          // Padding(padding: EdgeInsets.only(top: 40.sp)),

          Container(
              height: 280.sp,
              width: 100.w,
              padding: EdgeInsets.only(top: 40.sp, left: 14.sp, right: 20.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.sp),
                  color: colors.primaryDark.withOpacity(0.3)),
              child: Column(
                children: [
                  ProfileItem(
                      active: true,
                      iconAsset: "archive.svg",
                      text: 'Watchlist',
                      onPressed: () {}),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    child: const GradientDivider(),
                  ),
                  ProfileItem(
                      active: true,
                      iconAsset: "star-outline.svg",
                      text: 'Rated Movies',
                      onPressed: () {}),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    child: const GradientDivider(),
                  ),
                  ProfileItem(
                      active: false,
                      iconAsset: "heart.svg",
                      text: 'Favorite Movies',
                      onPressed: () {}),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    child: const GradientDivider(),
                  ),
                  ProfileItem(
                      active: true,
                      iconAsset: "logout.svg",
                      text: 'Logout',
                      onPressed: () {
                        onLogout();
                      }),
                ],
              )),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is LogoutLoadingState) {
                EasyLoading.show(status: "Logging out...");
              } else {
                EasyLoading.dismiss();
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }

  void onLogout() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 100.h,
        width: 100.w,
        color: colors.primaryDark.withOpacity(0.3),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 0.sp),
            height: 120.sp,
            width: 200.sp,
            decoration: BoxDecoration(
                color: colors.primaryDark,
                border: Border.all(color: colors.primarySilver, width: 0.3),
                borderRadius: BorderRadius.circular(12.sp)),
            child: Column(
              children: [
                const DefaultText.bold(text: "Logout", fontSize: 14),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.sp),
                  child: const GradientDivider(),
                ),
                Text(
                  "Are you sure you want to logout from your account?",
                  style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      height: 1.1.sp,
                      color: colors.primaryGrey,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70.sp,
                        height: 25.sp,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: colors.primaryGrey,
                      ),
                      Container(
                        width: 70.sp,
                        height: 25.sp,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LogoutEvent());
                          },
                          child: Text(
                            "Yes",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                color: colors.primaryBlue,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
