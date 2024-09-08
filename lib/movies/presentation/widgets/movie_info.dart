import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/movie_account_states.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/movie_description.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/movie_info_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../core/api/tmdb_api_constants.dart';
import '../../domain/models/movie_model.dart';
import '../../domain/models/movies_details_model.dart';
import '../bloc/movies_bloc.dart';
import 'gradient_divider.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key, required this.movieDetails, required this.movie});
  final MovieDetails movieDetails;
  final Movie movie;
  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          current is AccountStatesSuccess ||
          current is AccountStatesLoading ||
          current is AccountStatesError,
      builder: (context, state) {
        if (state is AccountStatesSuccess || state is AccountStatesError) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.sp, 0.sp, 12.sp, 0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100.sp,
                      child: Column(children: [
                        Text('Produced by',
                            style: GoogleFonts.roboto(
                                fontSize: 10.sp,
                                color: colors.primaryGrey,
                                fontWeight: FontWeight.bold)),
                        Padding(padding: EdgeInsets.only(top: 2.sp)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(widget.movieDetails.productionCompany,
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]),
                    ),
                    Column(
                      children: [
                        RatingBar.builder(
                          itemSize: 16.sp,
                          unratedColor: Colors.grey,
                          itemBuilder: (context, index) => SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: Colors.yellow),
                          onRatingUpdate: ((value) {}),
                          allowHalfRating: true,
                          ignoreGestures: true,
                          initialRating:
                              (widget.movieDetails.voteAverage * 5) / 10,
                        ),
                        Padding(padding: EdgeInsets.only(top: 2.sp)),
                        Text(
                          'From ${widget.movieDetails.voteCount} users',
                          style: GoogleFonts.roboto(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: colors.primaryGrey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 16.sp)),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MovieInfoItem(
                        imageAsset: 'clock',
                        label: '${widget.movieDetails.runtime} minutes'),
                    const VerticalDivider(
                      color: colors.primaryGrey,
                      thickness: 1,
                    ),
                    MovieInfoItem(
                        imageAsset: 'video-vertical',
                        label: widget.movie.genreIds.isEmpty
                            ? 'unknown'
                            : '${TMDBApiConstants.MOVIE_GENRES[widget.movie.genreIds[0]]}'),
                    const VerticalDivider(
                      color: colors.primaryGrey,
                      thickness: 1,
                    ),
                    MovieInfoItem(
                        imageAsset: 'global',
                        label:
                            '${TMDBApiConstants.MOVIE_LANGUAGES[widget.movieDetails.originalLanguage]}'),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 6.sp)),
              if (state is AccountStatesSuccess)
                MovieAccountStates(
                  currentRatedState:
                      state.accountStates.rated?.value == null ? false : true,
                  currentWatchlistState: state.accountStates.watchlist,
                  movieId: widget.movie.movieId,
                  initialRating: state.accountStates.rated?.value == null
                      ? 0.0
                      : state.accountStates.rated!.value!,
                ),
              if (state is AccountStatesError)
                MovieAccountStates(
                  currentRatedState: false,
                  currentWatchlistState: false,
                  movieId: widget.movie.movieId,
                  initialRating: 0.0,
                ),
              Padding(padding: EdgeInsets.only(top: 10.sp)),
              const GradientDivider(),
              MovieDescription(overview: widget.movieDetails.overview),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
