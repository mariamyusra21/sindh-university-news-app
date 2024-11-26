import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/models/categories_model.dart';
import 'package:usindh_news/view_models/fetch_category_view_model.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/widgets/drawer_widgets.dart';

import 'drawer_widgets.dart' as custom_widgets;

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final fetchCategoryViewModel =
        Provider.of<FetchCategoryViewModel>(context, listen: false);
    // context.watch<FetchCategoryViewModel>();
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: false);
    // context.watch<LanguageNotifier>().selectedLanguage;

    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: mainColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/usindh image.png',
                        height: 100,
                        width: 1000,
                      ),
                      Text('USINDH NEWS', style: appBarTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: LanguageButton(),
          ),
          FutureBuilder<List<CategoriesModel>>(
            future: fetchCategoryViewModel
                .fetchCategories(languageProvider.selectedLanguage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                      strokeWidth: 5,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Error Fetching Data.\nCheck your INTERNET connection.',
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No data available'),
                  ),
                );
              } else {
                List<CategoriesModel> categoryList = snapshot.data!;
                return Consumer<FetchCategoryViewModel>(
                    builder: (context, model, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = categoryList[index];
                        return custom_widgets.DrawerButton(category: category);
                      },
                      childCount: categoryList.length,
                    ),
                  );
                });
              }
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'About Us');
                },
                child: DrawerStaticCard(
                  title: '  About Us',
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: InkWell(
          //       onTap: () => throw Exception(),
          //       child: DrawerStaticCard(
          //         title: '  Throw Test Exception',
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
