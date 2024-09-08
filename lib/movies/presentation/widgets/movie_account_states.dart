import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class MovieAccountStates extends StatefulWidget {
  const MovieAccountStates(
      {super.key,
      required this.currentRatedState,
      required this.currentWatchlistState,
      required this.movieId,
      required this.initialRating});
  final int movieId;
  final bool currentRatedState;
  final bool currentWatchlistState;
  final num initialRating;
  @override
  State<MovieAccountStates> createState() => _MovieAccountStatesState();
}

class _MovieAccountStatesState extends State<MovieAccountStates> {
  late bool ratedState;
  late bool watchlistState;
  late num currentRating;
  @override
  void initState() {
    ratedState = widget.currentRatedState;
    watchlistState = widget.currentWatchlistState;
    currentRating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AddRatingSuccess) {
                setState(() {
                  ratedState = true;
                  watchlistState = false;
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(GetWatchListEvent());
                });
              } else if (state is AddRatingError) {
                setState(() {
                  currentRating = widget.initialRating;
                });
                Fluttertoast.showToast(msg: state.message);
              }
              if (state is DeleteRatingSuccess) {
                setState(() {
                  ratedState = false;
                  currentRating = 0.0;
                });
              } else if (state is DeleteRatingError) {}
            },
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Center(
                          child: Container(
                            height: 160.sp,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12.sp)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 4.sp)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ratedState
                                        ? IconButton(
                                            onPressed: () {
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(DeleteRatingEvent(
                                                      widget.movieId));

                                              Navigator.of(context).pop();
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/icons/trash.svg',
                                              color: Colors.white,
                                            ))
                                        : SizedBox(
                                            height: 25.sp,
                                            width: 25.sp,
                                          ),
                                  ],
                                ),
                                const DefaultText.bold(
                                    text: 'Add Rating', fontSize: 16),
                                Padding(padding: EdgeInsets.only(top: 12.sp)),
                                RatingBar.builder(
                                  itemSize: 24.sp,
                                  itemPadding: EdgeInsets.all(4.sp),
                                  unratedColor: Colors.grey,
                                  itemBuilder: (context, index) =>
                                      SvgPicture.asset('assets/icons/star.svg',
                                          color: Colors.yellow),
                                  onRatingUpdate: ((value) {
                                    setState(() {
                                      currentRating = value;
                                    });
                                  }),
                                  allowHalfRating: true,
                                  initialRating: currentRating as double,
                                ),
                                Padding(padding: EdgeInsets.only(top: 12.sp)),
                                Container(
                                  height: 30.sp,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(8.sp),
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          colors.primaryBlue,
                                          colors.primaryPurple
                                        ]),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (currentRating > 0.0 &&
                                          currentRating !=
                                              widget.initialRating) {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(AddRatingEvent(
                                                widget.movieId, currentRating));
                                        Navigator.of(context).pop();
                                      } else if (currentRating == 0.0) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Rating should be higher than 0');
                                      } else if (currentRating ==
                                          widget.initialRating) {
                                        Fluttertoast.showToast(
                                            msg: 'Rating has not changed');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        elevation: 4.sp,
                                        shadowColor: Colors.transparent,
                                        fixedSize: Size(130.sp, 20.sp),
                                        padding: EdgeInsets.all(0.sp),
                                        backgroundColor: Colors.transparent),
                                    child: const DefaultText.bold(
                                        text: 'Save', fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: !ratedState
                        ? SvgPicture.asset('assets/icons/star-outline.svg',
                            color: colors.primaryGrey)
                        : SvgPicture.asset('assets/icons/star.svg',
                            color: Colors.yellow)),
                Text(
                  'Rate',
                  style: GoogleFonts.roboto(
                      color: colors.primaryGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AddToWatchListSuccess) {
                setState(() {
                  watchlistState = !watchlistState;
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(GetWatchListEvent());
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                        color: colors.primaryBlue,
                        title: watchlistState ? "Added!" : "Removed!",
                        message: watchlistState
                            ? "Movie added to your watchlist successfully!"
                            : "Movie removed from your watchlist successfully!",
                        contentType: ContentType.success)));
              } else if (state is AddToWatchListError) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AddToWatchListEvent(widget.movieId, !watchlistState));
                    },
                    icon: !watchlistState
                        ? SvgPicture.asset(
                            'assets/icons/archive.svg',
                            color: colors.primaryGrey,
                          )
                        : SvgPicture.asset(
                            'assets/icons/archive-filled.svg',
                            color: Colors.white,
                          )),
                Text(
                  'Add to List',
                  style: GoogleFonts.roboto(
                      color: colors.primaryGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
