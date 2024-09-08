import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tmdb/movies/presentation/widgets/backdrop_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';
import '../../../../utils/colors.dart' as colors;
import '../bloc/movies_bloc.dart';

class SliverAppBarPage extends StatefulWidget {
  const SliverAppBarPage(
      {super.key, required this.movieDetailArgs, required this.body});
  final MovieDetailArgs movieDetailArgs;
  final Widget body;

  @override
  State<SliverAppBarPage> createState() => _SliverAppBarPageState();
}

class _SliverAppBarPageState extends State<SliverAppBarPage>
    with SingleTickerProviderStateMixin {
  late CacheManager customCacheManager2;
  late CacheManager customCacheManager;
  final controller = ScrollController();

  bool isButtonVisible = true;
  bool isVideoVisible = true;
  double previousOffset = 0;

  double titleSize = 18.sp;
  double titleLeftPad = 12.sp;
  double borderRadius = 12.sp;
  double posterHeight = 125.sp;
  double posterWidth = 90.sp;
  double bottomPadding = 20.sp;
  @override
  void dispose() {
    Future.delayed(
      Duration.zero,
      () async {
        await customCacheManager2.emptyCache();
        await customCacheManager2.dispose();
        controller.dispose();
      },
    );
    super.dispose();
  }

  @override
  void initState() {
    customCacheManager = CacheManager(Config('customBackdropKey',
        stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
    customCacheManager2 = CacheManager(Config('customPosterKey',
        stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    controller.addListener(() {
      _controllerHandler();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isButtonVisible
          ? SizedBox(
              height: 48.sp,
              width: 48.sp,
              child: FloatingActionButton(
                tooltip: "Watch Trailer",
                onPressed: () {
                  BlocProvider.of<MoviesBloc>(context).add(
                      GetTrailerEvent(widget.movieDetailArgs.movie.movieId));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [colors.primaryBlue, colors.primaryPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/video-play.svg',
                        color: Colors.white,
                        width: 18.sp,
                        height: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: colors.primaryDark,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!isButtonVisible) {
              setState(() {
                isButtonVisible = true;
              });
            }
          } else if (notification.direction == ScrollDirection.reverse) {
            if (isButtonVisible) {
              setState(() {
                isButtonVisible = false;
              });
            }
          }
          return true;
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              excludeHeaderSemantics: true,
              pinned: true,
              backgroundColor: colors.primaryDark,
              expandedHeight: 220.sp,
              collapsedHeight: 45.sp,
              shadowColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: BackdropImage(
                    cacheManager: customCacheManager,
                    backdropPath: widget.movieDetailArgs.movie.backdropPath,
                    sigma: 2),
                centerTitle: false,
                expandedTitleScale: 1,
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsets.only(
                    right: 12.sp,
                    left: titleLeftPad,
                    top: 20.sp,
                    bottom: bottomPadding),
                title: Row(
                  children: [
                    Hero(
                      tag: widget.movieDetailArgs.tag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image(
                          key: UniqueKey(),
                          height: posterHeight,
                          width: posterWidth,
                          fit: BoxFit.fill,
                          // loadingBuilder: (context, child, loadingProgress) =>
                          //     Skeleton(
                          //         darkShimmerGradient:
                          //             const LinearGradient(colors: [
                          //           colors.shimmerLoad,
                          //           colors.shimmerBase,
                          //         ]),
                          //         isLoading: true,
                          //         themeMode: ThemeMode.dark,
                          //         skeleton: Column(
                          //           children: [
                          //             SizedBox(
                          //               width: posterWidth,
                          //               height: posterHeight,
                          //             ),
                          //           ],
                          //         ),
                          //         child: Container()),
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    colors.shimmerBase,
                                    colors.shimmerLoad
                                  ]),
                            ),
                            width: posterWidth,
                            height: posterHeight,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/error.svg',
                                color: Colors.white,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          image: CachedNetworkImageProvider(
                            "${TMDBApiConstants.IMAGE_BASE_URL}${widget.movieDetailArgs.movie.posterPath}",
                            cacheManager: customCacheManager2,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 12.sp)),
                    Flexible(
                      child: Text(
                        widget.movieDetailArgs.movie.movieTitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: titleSize),
                      ),
                    )
                  ],
                ),
              ),
            ),
            widget.body
          ],
        ),
      ),
    );
  }

  void _controllerHandler() {
    final collapsePosition = 220.sp - kToolbarHeight;
    final currentPosition = controller.offset;
    bool isCollapsed = collapsePosition <= currentPosition;
    bool isExpanded = currentPosition == 0;
    var scale = currentPosition / collapsePosition;

    if (previousOffset > currentPosition && !isExpanded) {
      setState(() {
        posterHeight = 40.sp + ((125.sp - 40.sp) * (1 - scale));
        posterWidth = 40.sp + ((90.sp - 40.sp) * (1 - scale));
        titleLeftPad = 38.sp - ((38.sp - 12.sp) * (1 - scale));
        borderRadius = 100.sp - ((100.sp - 12.sp) * (1 - scale));
        titleSize = 12.sp + ((18.sp - 12.sp) * (1 - scale));
        bottomPadding = 0.sp + ((20.sp - 0.sp) * (1 - scale));
        previousOffset = currentPosition;
      });
    } else if (previousOffset < currentPosition && !isCollapsed) {
      setState(() {
        posterHeight = 125.sp - ((125.sp - 40.sp) * scale);
        posterWidth = 90.sp - ((90.sp - 40.sp) * scale);
        titleLeftPad = 12.sp + ((38.sp - 12.sp) * scale);
        borderRadius = 12.sp + ((100.sp - 12.sp) * scale);
        titleSize = 18.sp - ((18.sp - 12.sp) * scale);
        bottomPadding = 20.sp - ((20.sp - 0.sp) * scale);
        previousOffset = currentPosition;
      });
    } else {
      if (isExpanded) {
        setState(() {
          posterHeight = 125.sp;
          posterWidth = 90.sp;
          titleLeftPad = 12.sp;
          borderRadius = 12.sp;
          titleSize = 18.sp;
          bottomPadding = 20.sp;
        });
      } else if (isCollapsed) {
        setState(() {
          posterHeight = 40.sp;
          posterWidth = 40.sp;
          titleLeftPad = 38.sp;
          borderRadius = 100.sp;
          titleSize = 12.sp;
          bottomPadding = 0.sp;
        });
      }
    }
  }
}
