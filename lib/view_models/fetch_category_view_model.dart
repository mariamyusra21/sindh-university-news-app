import 'dart:io';

import 'package:flutter/material.dart';
import 'package:usindh_news/APIs/app_exceptions.dart';
import 'package:usindh_news/APIs/categories_api_call.dart';
import 'package:usindh_news/models/categories_model.dart';


class FetchCategoryViewModel with ChangeNotifier {
  List<CategoriesModel> categories = [];
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<List<CategoriesModel>> fetchCategories(String selectedLanguage) async {
    setLoading(true);
    try {
      List<dynamic> newsData =
          await CategoriesApiCall().fetchAllCategories(selectedLanguage);

      categories =
          newsData.map((item) => CategoriesModel.fromJson(item)).toList();
      setLoading(false);
      notifyListeners();
      return categories;
    } on SocketException {
      setLoading(false);
      throw FetchDataException('No INTERNET Connection.');
    } on Exception catch (e) {
      setLoading(false);
      throw e;
    }
  }
}
