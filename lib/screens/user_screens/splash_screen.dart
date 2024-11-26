import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/services/splash_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    String formatCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    splashService.isLogin(context, formatCurrentDate);
    // scheduleBackgroundTask();
    // splashService.getNotify(context);
    super.initState();
  }

  // void scheduleBackgroundTask() {
  //   Workmanager().registerPeriodicTask(
  //     "BackgroundNotification",
  //     "backgroundTask",
  //     frequency: Duration(minutes: 2), // Execute task every 2 minutes
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/usindh image.png',
                height: 300,
                width: 150,
              ),
              Text(
                'USINDH NEWS',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
            ],
          ),
        ));
  }
}
