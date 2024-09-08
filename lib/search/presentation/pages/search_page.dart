import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../utils/default_text.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late CacheManager customCacheManager;
  @override
  void initState() {
    customCacheManager = CacheManager(Config('customPosterKey',
        stalePeriod: const Duration(minutes: 10), maxNrOfCacheObjects: 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primaryDark,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: 50.sp,
          backgroundColor: colors.primaryDark,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 12.sp),
            child: IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                color: Colors.white,
              ),
            ),
          ),
          shadowColor: Colors.transparent,
          title: const DefaultText.bold(text: "Search Movies", fontSize: 16),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.sp, 6.sp, 12.sp, 12.sp),
                    child: Hero(
                        tag: "SearchBar",
                        child: CustomSearchBar(
                          enabled: true,
                          onSearch: (value) {
                            BlocProvider.of<SearchBloc>(context)
                                .add(SearchMoviesEvent(value));
                          },
                        )),
                  ),
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [SearchResults(customCacheManager: customCacheManager)]),
            )
          ],
        ));
  }
}
