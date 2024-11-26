import 'dart:io';

import 'package:flutter/material.dart';
import 'package:usindh_news/APIs/app_exceptions.dart';
import 'package:usindh_news/APIs/categories_api_call.dart';
import 'package:usindh_news/models/videos_model.dart';

class VideoViewModel with ChangeNotifier {
  List<VideoModel> videos = [];
  bool _loading = false;
  int _startOffset = 0;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<List<VideoModel>> fetchVideos(String startOffset,
      {bool isRefresh = false}) async {
    // setLoading(true);
    if (isRefresh) {
      // _startOffset = 0; // Reset the start offset
      videos.clear(); // Clear the current news list
    }
    _loading = true;
    notifyListeners();
    try {
      List<dynamic> newsData = await CategoriesApiCall().getVideos(startOffset);
      videos = newsData.map((item) => VideoModel.fromJson(item)).toList();

      // Append new news to the existing list
      // news.addAll(newNews);

      // Update startOffset
      // _startOffset += 10;

      // setLoading(false);
      _loading = false;
      notifyListeners();
      return videos;
    } on SocketException {
      setLoading(false);
      throw FetchDataException('No INTERNET Connection.');
    } on Exception catch (e) {
      setLoading(false);
      throw e;
    }
  }
}
