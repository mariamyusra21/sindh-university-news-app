import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/models/categories_model.dart';
import 'package:usindh_news/screens/user_screens/all_news_screen.dart';
import 'package:usindh_news/view_models/fetch_category_view_model.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/view_models/news_view_model.dart';

class DrawerButton extends StatefulWidget {
  final CategoriesModel category;

  const DrawerButton({required this.category});

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    // final selectedLanguage = context.watch<LanguageNotifier>().selectedLanguage;
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: false);
    String? title;
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);

    switch (languageProvider.selectedLanguage) {
      case 'SIND':
        title = widget.category.sindhiName ?? widget.category.categoryName;
        break;
      case 'URDU':
        title = widget.category.urduName ?? widget.category.categoryName;
        break;
      case 'ENGG':
      default:
        title = widget.category.categoryName ?? '';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () async {
          // await newsViewModel.fetchCategoryWiseNews(
          //   widget.category.categoryId,
          //   languageProvider.selectedLanguage,
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneralNewsScreen(
                title: title!,
                id: widget.category.categoryId,
                language: languageProvider.selectedLanguage,
              ),
            ),
          );
        },
        //  Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GeneralNewsScreen(
        //               title: title!,
        //               id: widget.category.categoryId,
        //               language: languageProvider.selectedLanguage,
        //             ))),

        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: const Color.fromARGB(218, 255, 255, 255),
          margin: const EdgeInsets.all(7.0),
          child: Container(
            height: 50,
            alignment: AlignmentDirectional.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '  $title',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatefulWidget {
  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    // final selectedLanguage = context.watch<LanguageNotifier>().selectedLanguage;
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: true);
    final fetchCategoryProvider =
        Provider.of<FetchCategoryViewModel>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SegmentedButton<String>(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Color.fromRGBO(12, 132, 218, 1);
            }
            return Colors.grey[200];
          }),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        segments: const <ButtonSegment<String>>[
          ButtonSegment<String>(
            value: 'ENGG',
            label: Text(
              'English',
              style: postTextStyle,
            ),
          ),
          ButtonSegment<String>(
            value: 'SIND',
            label: Text(
              'سنڌي',
              style: postTextStyle,
            ),
          ),
          ButtonSegment<String>(
            value: 'URDU',
            label: Text(
              'اردو',
              style: postTextStyle,
            ),
          ),
        ],
        selected: <String>{languageProvider.selectedLanguage},
        onSelectionChanged: (Set<String> newSelection) {
          languageProvider.setLanguage(newSelection.first);
          fetchCategoryProvider.fetchCategories(newSelection.first);
        },
      ),
    );
  }
}

class DrawerStaticCard extends StatelessWidget {
  final String? title;
  const DrawerStaticCard({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: const Color.fromARGB(218, 255, 255, 255),
        margin: const EdgeInsets.all(7.0),
        child: Container(
          height: 50,
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  '${title}',
                  style: const TextStyle(
                      color: mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
