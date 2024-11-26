import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';

class NewsPostTile extends StatelessWidget {
  const NewsPostTile({
    super.key,
    required this.url,
    required this.title,
    required this.date,
    required this.widget,
    //  required this.button,
    // required this.onTap,
  });

  final String url;
  final String title;
  final String date;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadowColor: Colors.black,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        // side: BorderSide(color: Colors.grey)
      ),
      // shape: Border.all(color: Colors.grey),
      surfaceTintColor: Colors.grey,
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        height: 230,
        width: 340,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 50,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(url), fit: BoxFit.fill)),
              ),
              Column(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: postTextStyle,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  date,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ),
              SizedBox(width: 140),
              // TextButton(
              //     onPressed: onTap(),
              //     child: Text(
              //       'Read More',
              //       style: TextStyle(color: mainColor, fontSize: 11),
              //     ))
              widget
            ],
          ),
        ),
      ),
    );
  }
}
