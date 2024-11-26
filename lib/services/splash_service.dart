import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usindh_news/screens/user_screens/dashboard.dart';
import 'package:usindh_news/view_models/language_notifier.dart';


class SplashService {
  // DateTime currentDate = DateTime.now();
  // String formatCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);

  void isLogin(BuildContext context, String date) {
    // scheduleBackgroundTask(date);
    // NotificationService().displayNotification(title, desc, 'payload');
    final languageProvider =
        Provider.of<LanguageNotifier>(context, listen: false);
    Future.delayed(Duration(seconds: 5), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(
                    selectedLanguage: languageProvider.selectedLanguage,
                  )));
    });
  }
}
