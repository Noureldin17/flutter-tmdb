import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/default_text.dart';
import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../widgets/gradient_divider.dart';
import '../widgets/movie_list_tile.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  late CacheManager customCacheManager;
  @override
  void dispose() {
    Future.delayed(
      Duration.zero,
      () async {
        await customCacheManager.emptyCache().then((value) async {
          await customCacheManager.dispose();
        });
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
    BlocProvider.of<AuthenticationBloc>(context).add(GetWatchListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colors.primaryDark,
        shadowColor: Colors.transparent,
        title: const Center(
            child: DefaultText.bold(text: "Watchlist", fontSize: 18)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<AuthenticationBloc>(context).add(GetWatchListEvent());
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) =>
              current is WatchListSuccess ||
              current is WatchListError ||
              current is WatchListLoading,
          builder: (context, state) {
            if (state is WatchListSuccess) {
              if (state.watchList.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => MovieListTile(
                                key: UniqueKey(),
                                movie: state.watchList[index],
                                movieType: 'Watchlist',
                                cacheManager: customCacheManager),
                            separatorBuilder: (context, index) => Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                                  child: const GradientDivider(),
                                ),
                            itemCount: state.watchList.length)),
                  ],
                );
              } else {
                return ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 100.sp)),
                          SvgPicture.asset(
                            'assets/icons/video-cross.svg',
                            height: 120.sp,
                            width: 120.sp,
                            color: colors.primaryBlue,
                          ),
                          Padding(padding: EdgeInsets.only(top: 12.sp)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 22.sp),
                            child: Text(
                              'Empty Watchlist',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 6.sp)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40.sp),
                            child: Text(
                              'There are no movies in your watchlist, add more movies to your watchlist!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: colors.primaryGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            } else if (state is WatchListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: colors.primaryBlue,
                ),
              );
            } else if (state is WatchListError) {
              return Center(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 100.sp)),
                    SvgPicture.asset(
                      'assets/icons/video-cross.svg',
                      height: 120.sp,
                      width: 120.sp,
                      color: colors.primaryBlue,
                    ),
                    Padding(padding: EdgeInsets.only(top: 12.sp)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.sp),
                      child: Text(
                        "Unable to Access feature",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 6.sp)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40.sp),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: colors.primaryGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
