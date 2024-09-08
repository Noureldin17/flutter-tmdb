import 'dart:ui';
import '../../../../utils/colors.dart' as colors;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';

class BackdropImage extends StatefulWidget {
  const BackdropImage({
    super.key,
    required this.backdropPath,
    required this.sigma,
    required this.cacheManager,
  });
  final String backdropPath;
  final double sigma;
  final CacheManager cacheManager;
  @override
  State<BackdropImage> createState() => _BackdropImageState();
}

class _BackdropImageState extends State<BackdropImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: widget.cacheManager,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      fadeOutCurve: Curves.easeOut,
      fadeOutDuration: const Duration(milliseconds: 300),
      errorWidget: (context, url, error) => Container(
        height: 220.sp,
        width: 100.w,
        decoration: BoxDecoration(
          color: colors.primaryDark,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.sp),
            bottomRight: Radius.circular(12.sp),
          ),
        ),
      ),
      imageUrl: "${TMDBApiConstants.IMAGE_BASE_URL}${widget.backdropPath}",
      imageBuilder: (context, imageProvider) => Stack(
        children: [
          Container(
            height: 220.sp,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.sp),
                  bottomRight: Radius.circular(12.sp),
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            width: 100.w,
            height: 240.sp,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    stops: [
                      0.1,
                      0.7,
                      0.9,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromARGB(153, 8, 8, 29),
                      colors.primaryDark
                    ])),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.sigma,
              sigmaY: widget.sigma,
            ),
            child: SizedBox(
              height: 230.sp,
              width: 100.w,
            ),
          )
        ],
      ),
      placeholder: (context, url) => Stack(
        children: [
          Container(
            height: 220.sp,
            width: 100.w,
            decoration: BoxDecoration(
              color: colors.primaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.sp),
                bottomRight: Radius.circular(12.sp),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: SizedBox(
              height: 230.sp,
              width: 100.w,
            ),
          )
        ],
      ),
    );
  }
}
