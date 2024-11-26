import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usindh_news/constants.dart';



class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.filter,
                color: mainColor,
                size: 20,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: mainColor,
                size: 20,
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                FontAwesomeIcons.noteSticky,
                // color: mainColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'News');
              },
            ),
            label: 'News Feed'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => Navigator.pushNamed(context, 'Search'),
              icon: Icon(
                FontAwesomeIcons.searchengin,
                // color: mainColor
              ),
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => Navigator.pushNamed(context, 'SavedNews'),
              icon: Icon(
                FontAwesomeIcons.bookBookmark,
                // color: mainColor
              ),
            ),
            label: 'Saved'),
      ]),
      body: Center(
        child: Text(
          'Saved News',
          style: appBarTextStyle,
        ),
      ),
    );
  }
}
