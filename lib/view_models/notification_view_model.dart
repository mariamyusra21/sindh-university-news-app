import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:usindh_news/APIs/app_exceptions.dart';
import 'package:usindh_news/APIs/categories_api_call.dart';
import 'package:usindh_news/APIs/notification_db.dart';
import 'package:usindh_news/models/news_model.dart';

class NotificationViewModel with ChangeNotifier {
  final _client = http.Client();
  bool _loading = false;
  List<News> updatedNews = [];

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> checkForUpdates() async {
    try {
      tz.initializeTimeZones();
      DateTime currentDate = DateTime.now();
      String formateDate = DateFormat('yyyy-MM-dd').format(currentDate);
      List<dynamic> newsData = await CategoriesApiCall()
          .getCurrentDateWise("0", '', formateDate, formateDate);

      updatedNews = newsData.map((item) => News.fromJson(item)).toList();
      int? currentID = int.tryParse(newsData.last["NOTIFICATION_ID"]);

      // Local Database
      NotificationDatabase notificationDatabase = NotificationDatabase();
      await notificationDatabase.openMyDatabase();

      for (var news in updatedNews) {
        String id = newsData[updatedNews.indexOf(news)]["NOTIFICATION_ID"];
        bool isIDPresent =
            await notificationDatabase.isNotificationIDPresent(id);

        if (!isIDPresent) {
          await showNotification(currentID!, news);
          await notificationDatabase.insertNotification(
              id, news.title, news.desc, currentDate.toString());
          // print('Notification with ID $id inserted into the database.');
          print('Notification is sent');
        } else {
          // print('Notification with ID $id is already present in the database.');
          print('Notification already existed.');
        }
      }

      setLoading(false);
    } on SocketException {
      throw FetchDataException('No INTERNET Connection.');
    } on Exception catch (e) {
      print(e.toString());
      setLoading(false);
    }
  }

  Future<void> showNotification(int id, News news) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'local_notification',
      'usindh_news_notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id,
      _parseHtmlString(news.title),
      _parseHtmlString(news.desc),
      platformChannelSpecifics,
      payload: news.image,
    );
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }
}
