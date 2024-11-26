import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:usindh_news/constants.dart';
import 'package:usindh_news/screens/user_screens/about_us_screen.dart';
import 'package:usindh_news/screens/user_screens/all_news_screen.dart';
import 'package:usindh_news/screens/user_screens/saved_news.dart';
import 'package:usindh_news/screens/user_screens/search_screen.dart';
import 'package:usindh_news/screens/user_screens/splash_screen.dart';
import 'package:usindh_news/services/notification_Service.dart';
import 'package:usindh_news/view_models/fetch_category_view_model.dart';
import 'package:usindh_news/view_models/language_notifier.dart';
import 'package:usindh_news/view_models/news_view_model.dart';
import 'package:usindh_news/view_models/notification_view_model.dart';
import 'package:usindh_news/view_models/video_view_model.dart';
import 'package:workmanager/workmanager.dart';

import 'screens/user_screens/dashboard.dart';

String selectedLanguage =
    ''; // Define a variable to store the selected language

Future<void> getSelectedLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  selectedLanguage = prefs.getString('selectedLanguage') ??
      'ENGG'; // Default language is 'ENGG'
}

Future<void> saveSelectedLanguage(String language) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedLanguage', language);
}

void scheduleNotification() async {
  await Workmanager().registerOneOffTask(
    "1",
    "simpleTask",
    initialDelay: Duration(seconds: 10),
  );
}

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    await NotificationViewModel().checkForUpdates();
    // showNotification(1, title, desc);
    scheduleNotification();

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await NotificationService().initializeNotifications();
  await Firebase.initializeApp();
  await getSelectedLanguage();

  // automatically catch all errors that are thrown within the Flutter framework
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageNotifier()),
        ChangeNotifierProvider(create: (_) => FetchCategoryViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
      ],
      child: Builder(builder: (context) {
        return ResponsiveSizer(
          builder: (context, orientation, deviceType) => MaterialApp(
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'TimesNewRoman',
                scaffoldBackgroundColor: appBgColor,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: mainColor))),
            routes: {
              'Home': (context) =>
                  DashboardScreen(selectedLanguage: selectedLanguage),
              'Search': (context) => const SearchScreen(),
              'SavedNews': (context) => const SavedNewsScreen(),
              'News': (context) => GeneralNewsScreen(
                    title: 'General News',
                    id: '1',
                    language: selectedLanguage,
                  ),
              'Announcement': (context) => GeneralNewsScreen(
                    title: 'Announcement And Notices',
                    id: '2',
                    language: selectedLanguage,
                  ),
              'Events': (context) => GeneralNewsScreen(
                    title: 'Events',
                    id: '3',
                    language: selectedLanguage,
                  ),
              'Job Opportunities': (context) => GeneralNewsScreen(
                    title: 'Job Opportunity',
                    id: '8',
                    language: selectedLanguage,
                  ),
              'STAGS': (context) => GeneralNewsScreen(
                    title: 'STAGS Events',
                    id: '13',
                    language: selectedLanguage,
                  ),
              'About Us': (context) => AboutUsScreen()
            },
          ),
        );
      }),
    );
  }
}
