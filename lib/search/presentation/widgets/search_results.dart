import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../movies/presentation/widgets/movie_list_tile.dart';
import '../bloc/search_bloc.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.customCacheManager});
  final CacheManager customCacheManager;
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchMoviesSuccess) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.movieList.length,
              itemBuilder: (context, index) => MovieListTile(
                  movie: state.movieList[index],
                  movieType: "search",
                  cacheManager: widget.customCacheManager),
            ),
          );
        } else if (state is SearchMoviesLoading) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) => Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp),
                child: Row(
                  children: [
                    Skeleton(
                      skeleton: Row(
                        children: [
                          Container(
                            height: 90.sp,
                            width: 65.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                color: colors.shimmerBase),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150.sp,
                                  height: 12.sp,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: colors.shimmerBase),
                                ),
                                Padding(padding: EdgeInsets.only(top: 8.sp)),
                                Container(
                                  width: 90.sp,
                                  height: 12.sp,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: colors.shimmerBase),
                                ),
                                Padding(padding: EdgeInsets.only(top: 8.sp)),
                                Container(
                                  width: 140.sp,
                                  height: 12.sp,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: colors.shimmerBase),
                                ),
                                Padding(padding: EdgeInsets.only(top: 8.sp)),
                                Container(
                                  width: 100.sp,
                                  height: 12.sp,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: colors.shimmerBase),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      isLoading: true,
                      shimmerGradient: const LinearGradient(
                          colors: [colors.shimmerBase, colors.shimmerLoad]),
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is SearchMoviesError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
