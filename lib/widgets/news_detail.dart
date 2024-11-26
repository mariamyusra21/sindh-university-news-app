import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:usindh_news/widgets/preview_image.dart';

import '../constants.dart';

class NewsDetail extends StatefulWidget {
  final dynamic url;
  final String title;
  final String dateString;
  final String details;
  // final Function onPress;
  // final Widget widget;
  NewsDetail({
    super.key,
    required this.url,
    required this.title,
    required this.dateString,
    required this.details,
    // required this.onPress,
    // required this.widget
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(widget.dateString);
    String formattedDate = DateFormat('EEEE d MMMM yyyy').format(date!);
    // Uint8List? image = base64Decode(widget.url);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Padding(padding: EdgeInsets.all(10)),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Hero(
              tag: widget.url,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImagePreviewScreen(url: widget.url)),
                ),
                child: Container(
                  height: 250,
                  width: 300,
                  // decoration: BoxDecoration(
                  //     image: image.isNotEmpty
                  //         ? DecorationImage(
                  //             image:
                  //                 AssetImage('assets/images/usindh image.png'),
                  //             fit: BoxFit.fitHeight,
                  //           )
                  //         : DecorationImage(
                  //             image: MemoryImage(image),
                  //             fit: BoxFit.fitHeight,
                  //           )),
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image:
                              // AssetImage('assets/images/usindh image.png'),
                              NetworkImage(widget.url),
                          fit: BoxFit.fitHeight)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
          ),
          Text(
            // date.toString(),
            formattedDate,
            style: postDateTextStyle,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: postTitleTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _parseHtmlString(widget.details),
              style: postDescTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
