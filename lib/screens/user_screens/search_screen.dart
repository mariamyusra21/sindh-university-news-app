import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/screens/user_screens/news_detail_screen.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/view_models/news_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    // Call showSearch function directly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSearch(context: context, delegate: CustomSearch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: appBgColor,
        // leading: Image.asset('assets/images/usindh image.jpg'),
        title: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/usindh image.png',
              height: 50,
              // width: 50,
            ),
            Text('USINDH NEWS', style: appBarTextStyle),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Search',
          style: appBarTextStyle,
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> searchedItem = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

    //TO return clear query
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final currentNewsViewModel =
        Provider.of<NewsViewModel>(context, listen: false);
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: false);
    return FutureBuilder(
      future: currentNewsViewModel.fetchCategoryWiseNews(
          '0', languageProvider.selectedLanguage, '0'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('loading...');

        final results = snapshot.data?.where((a) => a.title.contains(query));

        return ListView(
          children: results!
              .map<Widget>((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                        url: a.image,
                                        title: a.title,
                                        date: a.date,
                                        details: a.desc)));
                          },
                          child: Text(a.title)),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final currentNewsViewModel =
        Provider.of<NewsViewModel>(context, listen: false);
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: false);
    return FutureBuilder(
      future: currentNewsViewModel.fetchCategoryWiseNews(
          '0', languageProvider.selectedLanguage, '0'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('loading...');

        final results = snapshot.data?.where((a) => a.title.contains(query));

        return ListView(
          children: results!
              .map<Widget>((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                      url: a.image,
                                      title: a.title,
                                      date: a.date,
                                      details: a.desc)));
                        },
                        child: Text(a.title)),
                  ))
              .toList(),
        );
      },
    );
  }
}
