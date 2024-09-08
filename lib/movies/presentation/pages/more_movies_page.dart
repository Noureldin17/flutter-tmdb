import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../utils/default_text.dart';
import '../../domain/models/more_movies_args_model.dart';
import '../../domain/models/movie_model.dart';
import '../bloc/movies_bloc.dart';
import '../widgets/gradient_divider.dart';
import '../widgets/movie_list_tile.dart';

class MoreMoviesPage extends StatefulWidget {
  const MoreMoviesPage({super.key, required this.moreMoviesArgs});
  final MoreMoviesArgs moreMoviesArgs;
  @override
  State<MoreMoviesPage> createState() => _MoreMoviesPageState();
}

class _MoreMoviesPageState extends State<MoreMoviesPage> {
  late CacheManager customCacheManager;

  final controller = ScrollController();
  List<Movie> movieList = [];
  List<Widget> widgetList = [];
  int page = 2;
  bool actionBtnVisible = false;
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
        'customPosterKey${UniqueKey().toString()}',
        stalePeriod: const Duration(minutes: 10),
        maxNrOfCacheObjects: 100));

    movieList.addAll(widget.moreMoviesArgs.movieList);
    widgetList.addAll(widget.moreMoviesArgs.movieList.map((movie) =>
        MovieListTile(
            key: UniqueKey(),
            movie: movie,
            movieType: widget.moreMoviesArgs.moviesType,
            cacheManager: customCacheManager)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primaryDark,
        shadowColor: Colors.transparent,
        title: DefaultText.bold(
            text: widget.moreMoviesArgs.moviesType, fontSize: 16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: actionBtnVisible
          ? SizedBox(
              height: 35.sp,
              width: 35.sp,
              child: FloatingActionButton(
                tooltip: "Back to top",
                onPressed: () {
                  controller.animateTo(0,
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.decelerate);
                  setState(() {
                    actionBtnVisible = false;
                  });
                },
                child: Container(
                  height: 35.sp,
                  width: 35.sp,
                  padding: EdgeInsets.all(8.sp),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [colors.primaryBlue, colors.primaryPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/top.svg',
                    color: Colors.white,
                    width: 14.sp,
                    height: 14.sp,
                  ),
                ),
              ),
            )
          : null,
      backgroundColor: colors.primaryDark,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent) {
            BlocProvider.of<MoviesBloc>(context).add(
                GetMoreMoviesEvent(widget.moreMoviesArgs.moviesType, page));
          }
          if (notification.metrics.pixels > 100.h) {
            if (!actionBtnVisible) {
              setState(() {
                actionBtnVisible = true;
              });
            }
          } else if (notification.metrics.pixels < 100.h) {
            if (actionBtnVisible) {
              setState(() {
                actionBtnVisible = false;
              });
            }
          }
          return true;
        },
        child: Column(
          children: [
            BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is MoreMoviesSuccess) {
                  setState(() {
                    movieList.addAll(state.movieList);
                    widgetList.addAll(state.movieList.map((movie) =>
                        MovieListTile(
                            key: UniqueKey(),
                            movie: movie,
                            movieType: widget.moreMoviesArgs.moviesType,
                            cacheManager: customCacheManager)));
                    page += 1;
                  });
                }
              },
              builder: (context, state) {
                return const SizedBox();
              },
            ),
            Expanded(
              child: ListView.separated(
                  addSemanticIndexes: true,
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                        child: const GradientDivider(),
                      ),
                  controller: controller,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) => widgetList[index]),
            )
          ],
        ),
      ),
    );
  }
}
