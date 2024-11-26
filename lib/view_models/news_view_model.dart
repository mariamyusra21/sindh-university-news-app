import 'dart:io';

import 'package:flutter/material.dart';
import 'package:usindh_news/APIs/app_exceptions.dart';
import 'package:usindh_news/APIs/categories_api_call.dart';
import 'package:usindh_news/models/news_model.dart';

class NewsViewModel extends ChangeNotifier {
  List<News> news = [];
  bool _loading = false;
  int _startOffset = 0;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<List<News>> fetchCurrentNews(
      String selectedLanguage, String startOffset,
      {bool isRefresh = false, String? startDate, String? endDate}) async {
    if (isRefresh) {
      news.clear();
    }
    _loading = true;
    notifyListeners();
    try {
      List<dynamic> newsData = await CategoriesApiCall().getCurrentDateWise(
          startOffset,
          selectedLanguage,
          startDate.toString(),
          endDate.toString());
      print(newsData);
      news = newsData.map((item) => News.fromJson(item)).toList();

      // print(news);

      // Append new news to the existing list
      // news.addAll(newNews);

      // Update startOffset
      // _startOffset += 10;

      _loading = false;
      notifyListeners();
      // print(news);
      return news;
    } on SocketException {
      setLoading(false);
      throw FetchDataException('No INTERNET Connection.');
    } on Exception catch (e) {
      setLoading(false);
      throw e;
    }
  }

  Future<List<News>> fetchCategoryWiseNews(
      String id, String selectedLanguage, String startOffset,
      {bool isRefresh = false}) async {
    if (isRefresh) {
      news.clear();
    }
    _loading = true;
    notifyListeners();
    try {
      List<dynamic> newsData = await CategoriesApiCall()
          .generalNewsLazyLoad(id, selectedLanguage, startOffset);
      news = newsData.map((item) => News.fromJson(item)).toList();

      // Append new news to the existing list
      // news.addAll(newNews);

      // Update startOffset
      // _startOffset += 10;

      _loading = false;
      notifyListeners();
      print(news);
      return news;
    } on SocketException {
      setLoading(false);
      throw FetchDataException('No INTERNET Connection.');
    } on Exception catch (e) {
      setLoading(false);
      throw e;
    }
  }
}
