import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:usindh_news/constants.dart';

class ImagePreviewScreen extends StatelessWidget {
  final dynamic url;

  ImagePreviewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
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
      //  AppBar(
      //   title: Text('Preview of News Image'),
      // ),
      body: Center(
        child: Container(
          // color: appBgColor,
          // height: 100,
          // width: 340,
          child: PhotoView(
            backgroundDecoration: BoxDecoration(),
            // imageProvider: MemoryImage(url),
            imageProvider: NetworkImage(url),
            // initialScale: 70,
            minScale: PhotoViewComputedScale.contained,
            maxScale: 3.0,
          ),
        ),
        // child: Hero(
        //   tag: url,
        //   child: Image.network(
        //     url,
        //     fit: BoxFit.contain,
        //   ),
        // ),
      ),
    );
  }
}
