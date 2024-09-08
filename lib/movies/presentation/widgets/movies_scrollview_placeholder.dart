import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';
import '../../../../utils/colors.dart' as colors;

class MoviesScrollViewPlaceholder extends StatelessWidget {
  const MoviesScrollViewPlaceholder({
    super.key,
    required this.hasMore,
  });
  final bool hasMore;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              20,
              (index) => Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: Skeleton(
                        darkShimmerGradient: const LinearGradient(colors: [
                          colors.shimmerLoad,
                          colors.shimmerBase,
                        ]),
                        isLoading: true,
                        themeMode: ThemeMode.dark,
                        skeleton: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: colors.primaryDark,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              width: 90.sp,
                              height: 125.sp,
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: colors.primaryDark,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              width: 60.sp,
                              height: 10.sp,
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: colors.primaryDark,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              width: 25.sp,
                              height: 10.sp,
                            ),
                          ],
                        ),
                        child: Container()),
                  ))
        ],
      ),
    );
  }
}
