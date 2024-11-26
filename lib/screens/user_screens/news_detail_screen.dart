import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/widgets/news_detail.dart';

class NewsDetailScreen extends StatefulWidget {
  // final Document doc;
  final String url;
  final String title;
  final String date;
  final String details;
  NewsDetailScreen({
    Key? key,
    required this.url,
    required this.title,
    required this.date,
    required this.details,
  }) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: mainColor,
            )),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/usindh image.png',
              height: 50,
              // width: 50,
            ),
            Text('USINDH NEWS', style: appBarTextStyle),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         FontAwesomeIcons.filter,
        //         color: mainColor,
        //         size: 20,
        //       )),
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.more_vert,
        //         color: mainColor,
        //         size: 20,
        //       )),
        // ],
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //       icon: IconButton(
      //         icon: const Icon(
      //           FontAwesomeIcons.noteSticky,
      //           // color: mainColor,
      //         ),
      //         onPressed: () {
      //           Navigator.pushNamed(context, 'Dashboard');
      //         },
      //       ),
      //       label: 'News Feed'),
      //   BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () => Navigator.pushNamed(context, 'Search'),
      //         icon: const Icon(
      //           FontAwesomeIcons.searchengin,
      //           // color: mainColor
      //         ),
      //       ),
      //       label: 'Search'),
      //   BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () => Navigator.pushNamed(context, 'SavedNews'),
      //         icon: const Icon(
      //           FontAwesomeIcons.bookBookmark,
      //           // color: mainColor
      //         ),
      //       ),
      //       label: 'Saved'),
      // ]),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: appBgColor,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                ),
              ),
              Center(
                child: Text(
                  'News Details',
                  style: appBarTextStyle,
                ),
              ),
              SizedBox(height: 10),
              ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NewsDetail(
                      url: widget.url,
                      title: widget.title,
                      dateString: widget.date,
                      details: widget.details,
                    ),
                    SizedBox(
                      height: 180,
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
