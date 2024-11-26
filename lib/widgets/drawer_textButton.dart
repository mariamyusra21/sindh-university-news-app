import 'package:flutter/material.dart';
import 'package:usindh_news/constants.dart';



class DrawerTextButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  // final int size;

  const DrawerTextButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.padding,
    required this.onPressed,
    // required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed!(),
      child: ListTile(
        title: Row(
          children: [
            icon,
            Padding(
              padding: padding,
              // const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(text, style: postTitleTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
