import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/screens/user_screens/news_detail_screen.dart';
import 'package:usindh_news/screens/user_screens/search_screen.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/view_models/news_view_model.dart';
import 'package:usindh_news/view_models/video_view_model.dart';
import 'package:usindh_news/widgets/custom_drawer.dart';
import 'package:usindh_news/widgets/date_filter.dart';
import 'package:usindh_news/widgets/home_page_tags.dart';
import 'package:usindh_news/widgets/news_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DashboardScreen extends StatefulWidget {
  final String selectedLanguage;

  DashboardScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> categories = [
    'Home',
    'News',
    'Announcement',
    'Events',
    'Job Opportunities',
    'STAGS',
  ];

  CarouselController videoController = CarouselController();
  final ValueNotifier<int> _startOffsetVN = ValueNotifier<int>(0);
  DateTime? _startDate;
  DateTime? _endDate;
  List<YoutubePlayerController> controllers = [];
  int currentIndex = 0;

  void _setOffsetToTen() {
    _startOffsetVN.value += 10;
  }

  void initState() {
    super.initState();
    Permission.notification.request();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void applyDateFilter(DateTime startDate, DateTime endDate) {
    setState(() {
      _startDate = startDate;
      _endDate = endDate;
    });
    final currentNewsViewModel =
        Provider.of<NewsViewModel>(context, listen: false);
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: true);
    currentNewsViewModel.fetchCurrentNews(
      languageProvider.selectedLanguage,
      _startOffsetVN.value.toString(),
      startDate: _startDate?.toIso8601String() ?? '',
      endDate: _endDate?.toIso8601String() ?? '',
      isRefresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentNewsViewModel =
        Provider.of<NewsViewModel>(context, listen: false);
    final videosViewModel = Provider.of<VideoViewModel>(context, listen: false);
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/usindh image.png',
              height: 50,
            ),
            const Text('USINDH NEWS', style: appBarTextStyle),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DateFilter(
                    onApplyFilter: applyDateFilter,
                  );
                },
              );
            },
            icon: const Icon(
              FontAwesomeIcons.filter,
              color: mainColor,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
            },
            icon: const Icon(
              Icons.search,
              color: mainColor,
              size: 20,
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        semanticsLabel: "Refresh News",
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: mainColor,
        onRefresh: () async {
          setState(() {
            _startDate = DateTime.tryParse('');
            _endDate = DateTime.tryParse('');
          });
          _startOffsetVN.value = 0; // Reset offset
          await currentNewsViewModel.fetchCurrentNews(
            languageProvider.selectedLanguage,
            _startOffsetVN.value.toString(),
            isRefresh: true,
            startDate: _startDate?.toIso8601String() ?? '',
            endDate: _endDate?.toIso8601String() ?? '',
          );
          await videosViewModel.fetchVideos(_startOffsetVN.value.toString(),
              isRefresh: true);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            //color: appBgColor,
            child: ValueListenableBuilder(
                valueListenable: _startOffsetVN,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                      ),
                      HomePageTags(categories: categories),
                      const SizedBox(
                        height: 10,
                      ),
                      // Video SLider
                      FutureBuilder(
                          future: videosViewModel.fetchVideos(value.toString()),
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
                                    'Connection problem. Please check and try again.'),
                              );
                            } else if (snapshot.data == null ||
                                snapshot.data!.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No videos available'),
                              );
                            } else {
                              videosViewModel.videos = snapshot
                                  .data!; // Assign video list from snapshot
                              return
                                  // _videoList.isEmpty
                                  //     ? Center(child: Text('No Videos Available'))
                                  //     :
                                  Consumer<VideoViewModel>(
                                      builder: (context, model, child) {
                                return CarouselSlider.builder(
                                  itemCount: videosViewModel.videos.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final video = videosViewModel.videos[index];
                                    final link = video.link;
                                    return YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId: link,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                          mute: false,
                                          hideThumbnail: true,
                                          disableDragSeek: true,
                                        ),
                                      ),
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: mainColor,
                                    );
                                  },
                                  options: CarouselOptions(
                                    scrollPhysics:
                                        const ClampingScrollPhysics(),
                                    padEnds: true,
                                    pageSnapping: true,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onScrolled: (value) {
                                      if (value == 10) {
                                        // _startOffset += 10;
                                        // videosViewModel.fetchVideos();
                                        _setOffsetToTen();
                                      }
                                    },
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        controllers[currentIndex]
                                            .pause(); // Pause the previous video
                                        currentIndex = index;
                                      });
                                    },
                                  ),
                                  //     );
                                  //   }
                                  // },
                                );
                              });
                            }
                          }),

                      const SizedBox(height: 5),

                      FutureBuilder(
                        future: currentNewsViewModel.fetchCurrentNews(
                          languageProvider.selectedLanguage,
                          value.toString(),
                          startDate: _startDate?.toIso8601String() ?? '',
                          endDate: _endDate?.toIso8601String() ?? '',
                        ),
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
                          } else if (snapshot.data!.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No data available'),
                            );
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
                                        // print(news);
                                        // dynamic image = base64Decode(news.image);
                                        DateTime date =
                                            DateTime.parse(news.date);
                                        // print(news.image);
                                        // print(date);
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
                                if (currentNewsViewModel.loading)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                            color: mainColor,
                                            strokeAlign:
                                                CircularProgressIndicator
                                                    .strokeAlignCenter)),
                                  ),
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
                                    // height: 48,
                                    width: 30.w,
                                    // width: 48,
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
                                          // _startOffsetVN.value += 10;
                                          currentNewsViewModel.fetchCurrentNews(
                                            languageProvider.selectedLanguage,
                                            _startOffsetVN.value.toString(),
                                            startDate:
                                                _startDate?.toIso8601String() ??
                                                    '',
                                            endDate:
                                                _endDate?.toIso8601String() ??
                                                    '',
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
