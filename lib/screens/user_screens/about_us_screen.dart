import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //       icon: IconButton(
      //         icon: Icon(
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
      //         icon: Icon(
      //           FontAwesomeIcons.searchengin,
      //           // color: mainColor
      //         ),
      //       ),
      //       label: 'Search'),
      //   BottomNavigationBarItem(
      //       icon: IconButton(
      //         onPressed: () => Navigator.pushNamed(context, 'SavedNews'),
      //         icon: Icon(
      //           FontAwesomeIcons.bookBookmark,
      //           // color: mainColor
      //         ),
      //       ),
      //       label: 'Saved'),
      // ]),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'About the University',
                    style: headingTextStyle,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 2.h,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
              child: Text(
                'The University of Sindh, the oldest University of the country, was constituted under the University of Sindh Act. No. XVII of 1947 passed by the Legislative Assembly of Sindh. The Act was subsequently revised and modified in 1961 and later. The Act of 1972 under which the University is presently functioning provided for greater autonomy and representation of teachers .',
                style: postDescTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
              child: Text(
                'From 1947 to 1951 the University functioned solely as an examining body. However, after its relocation in Hyderabad in 1951, it started functioning as a teaching university in pursuit of fulfillment of its charter and mission to disseminate knowledge; the first teaching department, namely, Department of Education, raised to the status of Faculty of Education later, was started in view of the great dearth of trained teachers in the country. The departments of basic Science disciplines as well as other departments on humanities side were added by mid fifties.',
                style: postDescTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
              child: Text(
                'The development of the present Campus at Jamshoro, about 15 kilometer from Hyderabad on the right bank of River Indus now designated as Allama I.I. Kazi Campus, was started in late fifties. Most of the teaching departments under the Faculty of Science were shifted to the new campus in 1961, with departments under Arts & Humanities following suite in 1970.',
                style: postDescTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
              child: Text(
                'The academic march forward continued with the gradual addition of other teaching departments and now there are 43 full-fledged teaching institutes/centres/departments functioning under various academic Faculties. Institute of Biotechnology & Genetic Engineering and Centre for Environmental Sciences are the latest addition.',
                style: postDescTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
              child: Text(
                'There are presently 4 Law Colleges and 74 Degree and Post Graduate Colleges (including 16 Private Colleges) affiliated to the University.',
                style: postDescTextStyle,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        // child: Stack(
        //   children: [
        //     InAppWebView(
        //       initialUrlRequest:
        //           URLRequest(url: Uri.parse('https://usindh.edu.pk/page/59')),
        //       onWebViewCreated: (controller) =>
        //           inAppWebViewController = controller,
        //       onProgressChanged: (controller, progress) {
        //         _progress = progress / 100;
        //       },
        //     ),
        //     _progress < 1
        //         ? Container(
        //             child: CircularProgressIndicator(
        //               value: _progress,
        //             ),
        //           )
        //         : SizedBox()
        //   ],
        // ),
      ),

      //  Center(
      //   child: Text(
      //     'About Us',
      //     style: appBarTextStyle,
      //   ),
      // ),
    );
  }
}
