import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../../utils/colors.dart' as colors;
// import '../../../../utils/pages.dart' as pages;
import 'package:sizer/sizer.dart';

import '../../../../core/api/tmdb_api_constants.dart';

class CarouselSliderImage extends StatefulWidget {
  const CarouselSliderImage({
    super.key,
    required this.posterPath,
    required this.onClick,
  });

  final String posterPath;
  final Function onClick;

  @override
  State<CarouselSliderImage> createState() => _CarouselSliderImageState();
}

class _CarouselSliderImageState extends State<CarouselSliderImage> {
  late CacheManager customCacheManager;
  @override
  void initState() {
    customCacheManager = CacheManager(Config('customPosterKey',
        stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
      },
      child: Hero(
        transitionOnUserGestures: true,
        tag: '${widget.posterPath}Discover',
        child: CachedNetworkImage(
          imageUrl: "${TMDBApiConstants.IMAGE_BASE_URL}${widget.posterPath}",
          cacheManager: customCacheManager,
          imageBuilder: (context, imageProvider) => Container(
            width: 140.sp,
            height: 200.sp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
          ),
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colors.shimmerBase, colors.shimmerLoad]),
                borderRadius: BorderRadius.circular(12.sp)),
            width: 140.sp,
            height: 200.sp,
          ),
        ),
      ),
    );
  }
}
