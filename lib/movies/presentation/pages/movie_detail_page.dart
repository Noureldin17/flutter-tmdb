import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../utils/pages.dart' as pages;
import '../../domain/models/more_movies_args_model.dart';
import '../../domain/models/movie_detail_args_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieDetailArgs});
  final MovieDetailArgs movieDetailArgs;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isButtonVisible = true;
  bool isVideoVisible = true;
  late CacheManager customCacheManager;
  @override
  void dispose() {
    Future.delayed(
      Duration.zero,
      () async {
        await customCacheManager.emptyCache();
        await customCacheManager.dispose();
      },
    );
    super.dispose();
  }

  @override
  void initState() {
    customCacheManager = CacheManager(Config(
        'castCacheKey${UniqueKey().toString()}',
        stalePeriod: const Duration(minutes: 10),
        maxNrOfCacheObjects: 100));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    BlocProvider.of<MoviesBloc>(context)
        .add(GetDetailsEvent(widget.movieDetailArgs.movie.movieId));
    BlocProvider.of<MoviesBloc>(context)
        .add(GetAccountStatesEvent(widget.movieDetailArgs.movie.movieId));
    BlocProvider.of<MoviesBloc>(context)
        .add(GetCreditsEvent(widget.movieDetailArgs.movie.movieId));
    BlocProvider.of<MoviesBloc>(context)
        .add(GetRecommendationsEvent(widget.movieDetailArgs.movie.movieId));
    super.initState();
  }

  void onMovieClick(MovieDetailArgs movieDetailArgs) {
    Navigator.pushNamed(context, pages.movieDetailPage,
        arguments: movieDetailArgs);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBarPage(
      movieDetailArgs: widget.movieDetailArgs,
      body: SliverToBoxAdapter(
        child: SizedBox(
          child: Column(
            children: [
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is DetailsSuccess ||
                    current is DetailsError ||
                    current is DetailsLoading,
                builder: (context, state) {
                  if (state is DetailsSuccess) {
                    return MovieInfo(
                      movieDetails: state.movieDetails,
                      movie: widget.movieDetailArgs.movie,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is CreditsSuccess ||
                    current is CreditsLoading ||
                    current is CreditsError,
                builder: (context, state) {
                  if (state is CreditsSuccess) {
                    return MovieCastsView(
                      cast: state.castsList,
                      cacheManager: customCacheManager,
                    );
                  } else if (state is CreditsLoading) {
                    return Container();
                  } else if (state is CreditsError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              BlocConsumer<MoviesBloc, MoviesState>(
                builder: (context, state) => Container(),
                listenWhen: (previous, current) =>
                    current is TrailerSuccess ||
                    current is TrailerError ||
                    current is TrailerLoading,
                listener: (context, state) {
                  if (state is TrailerSuccess) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          YoutubePodPlayer(movieVideo: state.trailer.last),
                    );
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    // showModalBottomSheet(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(12.sp),
                    //       topRight: Radius.circular(12.sp),
                    //     )),
                    //     constraints:
                    //         BoxConstraints(maxHeight: 300.sp, maxWidth: 100.w),
                    //     backgroundColor: colors.primaryDark,
                    //     context: context,
                    //     builder: (context) => Align(
                    //         alignment: Alignment.topCenter,
                    //         child: YoutubePodPlayer(
                    //             movieVideo: state.trailer.last)));
                  } else if (state is TrailerError) {
                    Fluttertoast.showToast(msg: state.message);
                  } else if (state is TrailerLoading) {}
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is RecommendationsSuccess ||
                    current is RecommendationsLoading ||
                    current is RecommendationsError,
                builder: (context, state) {
                  if (state is RecommendationsSuccess) {
                    return MoviesScrollview(
                      onMoreClick: () {
                        final args =
                            MoreMoviesArgs('Recommendations', state.movieList);
                        Navigator.pushNamed(context, pages.moreMoviesPage,
                            arguments: args);
                      },
                      isLoading: false,
                      hasMore: false,
                      movieList: state.movieList,
                      moviesType: 'Recommendations',
                      onMovieClick: onMovieClick,
                    );
                  } else if (state is RecommendationsError) {
                    return Container();
                  } else if (state is RecommendationsLoading) {
                    return MoviesScrollview(
                        onMoreClick: () {},
                        isLoading: true,
                        hasMore: false,
                        onMovieClick: onMovieClick,
                        movieList: const [],
                        moviesType: "Recommendations");
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
