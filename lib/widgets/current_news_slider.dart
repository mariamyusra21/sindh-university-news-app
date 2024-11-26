import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';



class NewsSlider extends StatelessWidget {
  const NewsSlider({
    super.key,
    required this.weeklyNews,
    required this.text,
  });

  final List weeklyNews;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: weeklyNews
            .map((e) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            e,
                            fit: BoxFit.fitWidth,
                            // width: double.infinity,
                            height: 200,
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 8,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                        padding: EdgeInsets.only(left: 5),
                        child: Text(text, style: postDescTextStyle),
                      ),
                    ),
                  ],
                ))
            .toList(),
        options: CarouselOptions(
          height: 180,
        ));
  }
}
