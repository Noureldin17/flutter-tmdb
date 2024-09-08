import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;
import '../../../../core/api/tmdb_api_constants.dart';

class MovieListTile extends StatelessWidget {
  MovieListTile(
      {super.key,
      required this.movie,
      required this.movieType,
      required this.cacheManager});
  final Movie movie;
  final String movieType;
  final CacheManager cacheManager;

  final Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final movieDetailArgs = MovieDetailArgs(
          movie.posterPath + movieType + key.toString(),
          movie,
        );
        Navigator.pushNamed(context, pages.movieDetailPage,
            arguments: movieDetailArgs);
      },
      highlightColor: colors.shimmerBase,
      focusColor: colors.shimmerBase,
      splashColor: colors.shimmerLoad,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.sp, 0.sp, 12.sp, 0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              child: Hero(
                tag: movie.posterPath + movieType + key.toString(),
                child: CachedNetworkImage(
                  cacheManager: cacheManager,
                  imageUrl:
                      "${TMDBApiConstants.IMAGE_BASE_URL}${movie.posterPath}",
                  imageBuilder: (context, imageProvider) => Container(
                      height: 90.sp,
                      width: 65.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      )),
                  errorWidget: (context, url, error) => Container(
                      height: 90.sp,
                      width: 65.sp,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.shimmerBase, colors.shimmerLoad]),
                        borderRadius: BorderRadius.circular(12.sp),
                      )),
                  placeholder: (context, url) => Container(
                      height: 90.sp,
                      width: 65.sp,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.shimmerBase, colors.shimmerLoad]),
                        borderRadius: BorderRadius.circular(12.sp),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.sp,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        movie.movieTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 6.sp)),
                  RatingBar.builder(
                    itemSize: 14.sp,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, index) => SvgPicture.asset(
                        'assets/icons/star.svg',
                        color: Colors.yellow),
                    onRatingUpdate: ((value) {}),
                    allowHalfRating: true,
                    ignoreGestures: true,
                    initialRating: (movie.voteAverage * 5) / 10,
                  ),
                  Padding(padding: EdgeInsets.only(top: 6.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/calender.svg',
                        color: colors.primaryGrey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 4.sp)),
                      Text(
                        movie.releaseDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.roboto(
                            color: colors.primaryGrey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 6.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/video-vertical.svg',
                        color: colors.primaryGrey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 4.sp)),
                      Text(
                        movie.genreIds.isEmpty
                            ? 'unknown'
                            : '${TMDBApiConstants.MOVIE_GENRES[movie.genreIds[0]]}',
                        style: GoogleFonts.roboto(
                            color: colors.primaryGrey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
