import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/screens/user_screens/news_detail_screen.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/view_models/news_view_model.dart';
import 'package:usindh_news/widgets/news_card.dart';

class GeneralNewsScreen extends StatefulWidget {
  final String title;
  final String id;
  final String language;

  GeneralNewsScreen({
    Key? key,
    required this.title,
    required this.id,
    required this.language,
  }) : super(key: key);

  @override
  State<GeneralNewsScreen> createState() => _GeneralNewsScreenState();
}

class _GeneralNewsScreenState extends State<GeneralNewsScreen> {
  final ValueNotifier<int> _startOffsetVN = ValueNotifier<int>(0);

  void _setOffsetToTen() {
    _startOffsetVN.value += 10;
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    final languageViewModel =
        Provider.of<LanguageNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: mainColor,
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/usindh image.png',
              height: 50,
            ),
            const Text('USINDH NEWS', style: appBarTextStyle),
          ],
        ),
      ),
      body: RefreshIndicator(
        semanticsLabel: "Refresh News",
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: mainColor,
        onRefresh: () async {
          await newsViewModel.fetchCategoryWiseNews(
              widget.id,
              languageViewModel.selectedLanguage,
              _startOffsetVN.value.toString(),
              isRefresh: true);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.title}',
                        style: headingTextStyle,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _startOffsetVN,
                    builder: (context, value, child) {
                      return FutureBuilder(
                        future: newsViewModel.fetchCategoryWiseNews(
                            widget.id,
                            languageViewModel.selectedLanguage,
                            value.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: mainColor,
                                      strokeAlign: CircularProgressIndicator
                                          .strokeAlignCenter)),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Uh-oh! It looks like there’s a problem with your connection.\nPlease check and try again.'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Text('No data available');
                          } else {
                            return Column(
                              children: [
                                Consumer<NewsViewModel>(
                                  builder: (context, model, child) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: model.news.length,
                                      itemBuilder: (context, index) {
                                        final news = model.news[index];
                                        DateTime date =
                                            DateTime.parse(news.date);
                                        String formattedDate =
                                            DateFormat('EEEE d MMMM yyyy')
                                                .format(date);
                                        return InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(
                                                          url: news.image,
                                                          title: news.title,
                                                          date: news.date,
                                                          details: news.desc))),
                                          child: NewsCard(
                                            url: news.image,
                                            title: news.title,
                                            date: formattedDate,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                if (newsViewModel.loading)
                                  CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: mainColor, // Use your desired color
                                  child: Container(
                                    height: 4.h, // Adjust height as needed
                                    alignment: AlignmentDirectional.center,
                                    width: 30.w,
                                    child: TextButton(
                                        child: Text(
                                          'Load More',
                                          style: TextStyle(
                                              color: appBgColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        onPressed: () {
                                          _setOffsetToTen();
                                          newsViewModel.fetchCategoryWiseNews(
                                              widget.id,
                                              languageViewModel
                                                  .selectedLanguage,
                                              _startOffsetVN.value.toString());
                                        }),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
