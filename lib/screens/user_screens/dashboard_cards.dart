import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';



class DashboardCards extends StatefulWidget {
  final dynamic title;
  const DashboardCards({
    Key? key,
    required this.title,
    // required this.category,
  }) : super(key: key);

  @override
  State<DashboardCards> createState() => _DashboardCardsState();
}

class _DashboardCardsState extends State<DashboardCards> {
  //  String title = widget.category['NAME'];

  // // Adjust title based on selected language
  // switch (selectedLanguage) {
  //   case 'ENGG':
  //     title = category['NAME'];
  //     break;
  //   case 'SIND':
  //     title = category['SINDHI'];
  //     break;
  //   case 'URDU':
  //     title = category['URDU'];
  //     break;
  //   default:
  //     title =
  //         category['NAME']; // Default to English if language not recognized
  //     break;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: appBgColor,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: 25,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.title.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 6,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '  ${widget.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: mainColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
