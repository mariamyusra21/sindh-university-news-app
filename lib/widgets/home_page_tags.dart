import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';

class HomePageTags extends StatelessWidget {
  const HomePageTags({
    super.key,
    required this.categories,
  });

  final List? categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width, // Set the desired height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, categories![index]),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: mainColor,
                child: Container(
                  height: 15,
                  width: 130,
                  child: Center(
                    child: Text(
                      categories![index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
