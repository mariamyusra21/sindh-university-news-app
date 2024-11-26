import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:usindh_news/services/utilities.dart';

class CategoriesApiCall {
  final _client = http.Client();

  Future<List> fetchAllCategories(String selectedLangauage) async {
    var category;
    Map<String, dynamic> requestData = {
      "authentication_code": authKey,
      "PREF_LANG": selectedLangauage
    };
    try {
      final response = await _client.post(
        Uri.parse(allCategoriesApi),
        headers: {
          'Content-Type':
              'application/json', // Adjust the content type based on your API requirements
        },
        body: jsonEncode(requestData),
        // )
        //     .timeout(
        //   const Duration(seconds: 2),
        //   onTimeout: () {
        //     // Time has run out, do what you wanted to do.
        //     return http.Response(
        //         'Error', 408); // Request Timeout response status code
        //   },
      );
      if (response.statusCode == 200) {
        category = jsonDecode(response.body) as List;
        // print(category);
      } else if (response.statusCode == 204) {
        return jsonDecode('Content Not found');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid authentication code');
      } else if (response.statusCode == 206) {
        return jsonDecode('Authentication code required');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid request method');
      }
      print('Response: ${response.body}');
    } catch (error) {
      // Exception occurred during the POST request
      print('Error making POST request.');
    }
    return category;
  }

  Future<List> searchNews(String id) async {
    var news;
    Map<String, dynamic> requestData = {
      "authentication_code": authKey,
      "notificationTypeID": "$id",
      "startOffset": "0",
      "endOffset": "5"
    };
    try {
      final response = await _client.post(Uri.parse(generalApi),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData));

      if (response.statusCode == 200) {
        news = jsonDecode(response.body) as List;
        // print(news);
      } else if (response.statusCode == 204) {
        return jsonDecode('Content Not found');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid authentication code');
      } else if (response.statusCode == 206) {
        return jsonDecode('Authentication code required');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid request method');
      }
      // print('Response: ${response.body}');
    } catch (error) {
      // Exception occurred during the POST request
      print('Error making POST request: $error');
      // Utilities().toastMessage('Error making POST request: ${error}');
    }

    return news;
  }

  Future<List> generalNewsLazyLoad(String id, String lang,
      [String? startOffset, String? endOffset]) async {
    var news;
    Map<String, dynamic> requestData = {
      "authentication_code": authKey,
      "notificationTypeID": "$id",
      "PREF_LANG": lang,
      "startOffset": startOffset,
      "endOffset": 10
    };
    try {
      final response = await _client.post(Uri.parse(generalApi),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData));

      if (response.statusCode == 200) {
        news = jsonDecode(response.body) as List;
        print(news);
      } else if (response.statusCode == 204) {
        return jsonDecode('Content Not found');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid authentication code');
      } else if (response.statusCode == 206) {
        return jsonDecode('Authentication code required');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid request method');
      }
      // print('Response: ${response.body}');
    } catch (error) {
      // Exception occurred during the POST request
      print('Error making POST request: $error');
      // Utilities().toastMessage('Error making POST request: ${error}');
    }

    return news;
  }

  Future<List> getVideos(String? startOffset) async {
    var vid;
    Map<String, dynamic> requestData = {
      "authentication_code": authKey,
      "startOffset": startOffset,
      "endOffset": "10"
    };
    try {
      final response = await _client.post(Uri.parse(CategoriesApiCall.videoApi),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData));

      if (response.statusCode == 200) {
        vid = jsonDecode(response.body) as List;
        // print(vid);
      } else if (response.statusCode == 204) {
        return jsonDecode('Content Not found');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid authentication code');
      } else if (response.statusCode == 206) {
        return jsonDecode('Authentication code required');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid request method');
      }
      // print('Response: ${response.body}');
    } catch (error) {
      // Exception occurred during the POST request
      print('Error making POST request: $error');
      // Utilities().toastMessage('Error making POST request: ${error}');
    }

    return vid;
  }

  Future<List> getCurrentDateWise(String? startOffset, String lang,
      [String? startDate, String? endDate]) async {
    var news;
    Map<String, dynamic> requestData = {
      "authentication_code": authKey,
      "startOffset": startOffset,
      "PREF_LANG": lang,
      "endOffset": 10,
      "startDate": startDate ?? "",
      "endDate": endDate ?? "",
    };
    try {
      final response = await _client.post(Uri.parse(currentDateApi),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData));

      if (response.statusCode == 200) {
        news = jsonDecode(response.body) as List;
        print(news);
        print(startDate);
        print(endDate);
        // print(news);
      } else if (response.statusCode == 204) {
        return jsonDecode('Content Not found');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid authentication code');
      } else if (response.statusCode == 206) {
        return jsonDecode('Authentication code required');
      } else if (response.statusCode == 206) {
        return jsonDecode('Invalid request method');
      }
      // print('Response: ${response.body}');
    } catch (error) {
      // Exception occurred during the POST request
      print('Error making POST request: $error');

      // Utilities().toastMessage('Error making POST request: ${error}');
    }

    return news;
  }
}
