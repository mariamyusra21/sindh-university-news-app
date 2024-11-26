import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.url,
    required this.title,
    this.date,
    // required this.widget,
    //  required this.button,
    // required this.onTap,
  });

  final String url;
  final String title;
  final String? date;
  // final Widget widget;

  @override
  Widget build(BuildContext context) {
    // dynamic image;
    // Uint8List? image = base64Decode(url);
    return Card(
      // shadowColor: Colors.black,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        // side: BorderSide(color: Colors.grey)
      ),
      // shape: Border.all(color: Colors.grey),
      surfaceTintColor: Colors.grey,
      margin: EdgeInsets.only(left: 10, top: 5, right: 7, bottom: 5),
      child: Container(
        height: 25.h,
        width: 90.w,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 15.h,
                  width: 70.w,
                  // child: Image.network(url),
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
                              NetworkImage(url),
                          fit: BoxFit.fitHeight)),
                ),
              ),
              Expanded(
                flex: 0,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: postTextStyle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // SizedBox(height: 8),
              Text(
                date!,
                textAlign: TextAlign.start,
                softWrap: true,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
