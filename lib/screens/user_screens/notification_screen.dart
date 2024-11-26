import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  String? payload;
  NotificationScreen(this.payload);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${widget.payload}'),
      ),
    );
    // NewsDetailScreen();
  }
}
