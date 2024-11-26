import 'package:flutter/material.dart';
import 'package:usindh_news/APIs/categories_api_call.dart';
import 'package:usindh_news/services/utilities.dart';


class CategoryNewsViewModel extends ChangeNotifier {
  List<dynamic> _newsList = [];
  bool _loading = false;
  int _startOffset = 0;

  List<dynamic> get newsList => _newsList;
  bool get loading => _loading;

  Future<void> fetchData(String id, String language) async {
    // if (_loading) return;

    _loading = true;
    notifyListeners();

    try {
      List<dynamic> news = await CategoriesApiCall()
          .generalNewsLazyLoad(id, language, _startOffset.toString());
      if (news != null) {
        // Utilities().toastMessage('No news are available.');
        _newsList.addAll(news);
        _startOffset += 10;
        notifyListeners();
      }
    } catch (error) {
      print('Error loading news: $error');
      Utilities().toastMessage('Loading... Please check your Internet.');
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refreshData(String id, String language) async {
    _newsList.clear();
    _startOffset = 0;
    await fetchData(id, language);
  }
}
