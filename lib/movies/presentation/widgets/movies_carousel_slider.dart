import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/backdrop_image.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/carousel_slider_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
// import '../../../../utils/colors.dart' as colors;
import '../../../../utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';

class MoviesCarouselSlider extends StatefulWidget {
  const MoviesCarouselSlider({
    super.key,
    required this.movieList,
    required this.onMovieClick,
    required this.onMoreClick,
  });
  final List<Movie> movieList;
  final Function onMovieClick;
  final Function onMoreClick;
  @override
  State<MoviesCarouselSlider> createState() => _MoviesCarouselSliderState();
}

class _MoviesCarouselSliderState extends State<MoviesCarouselSlider>
    with WidgetsBindingObserver {
  late CacheManager customCacheManager;
  final carousalController = CarouselController();
  final key = UniqueKey();
  String backdropPath = '';
  bool animate = true;

  @override
  void initState() {
    customCacheManager = CacheManager(Config('customBackdropKey',
        stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     Future.delayed(Duration.zero, () {
  //       setState(() {
  //         animate = false;
  //         carousalController.stopAutoPlay();
  //       });
  //     });
  //   } else if (state == AppLifecycleState.resumed) {
  //     Future.delayed(Duration.zero, () {
  //       setState(() {
  //         animate = true;
  //       });
  //     });
  //   } else if (state == AppLifecycleState.inactive) {
  //     Future.delayed(Duration.zero, () {
  //       setState(() {
  //         animate = false;
  //         carousalController.stopAutoPlay();
  //       });
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: backdropPath,
          child: backdropPath == ''
              ? BackdropImage(
                  cacheManager: customCacheManager,
                  backdropPath: widget.movieList[0].backdropPath,
                  sigma: 15,
                )
              : BackdropImage(
                  backdropPath: backdropPath,
                  sigma: 15,
                  cacheManager: customCacheManager,
                ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.sp, 24.sp, 12.sp, 0.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultText.bold(text: 'Discover', fontSize: 20),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          widget.onMoreClick();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(16.sp))),
                        child: SizedBox(
                          height: 30.sp,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'See more',
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                              SvgPicture.asset(
                                'assets/icons/arrow-right.svg',
                                height: 12.sp,
                                width: 12.sp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ]),
            ),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            CarouselSlider(
                carouselController: carousalController,
                items: [
                  ...widget.movieList.map((movie) => CarouselSliderImage(
                      onClick: () {
                        final movieDetailArgs = MovieDetailArgs(
                            '${movie.posterPath}Discover', movie);
                        widget.onMovieClick(movieDetailArgs);
                      },
                      posterPath: movie.posterPath))
                ],
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      Future.delayed(Duration.zero, () {
                        setState(() {
                          backdropPath =
                              '${TMDBApiConstants.IMAGE_BASE_URL}${widget.movieList[index].backdropPath}';
                        });
                      });
                    },
                    enlargeCenterPage: true,
                    animateToClosest: true,
                    height: 200.sp,
                    viewportFraction: 0.55,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: animate,
                    pageSnapping: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(milliseconds: 7000),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1500))),
          ],
        ),
      ],
    );
  }
}
