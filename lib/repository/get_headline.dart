import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/model/category_news_model.dart';
import 'package:news_app/model/news_model.dart';

class GetHeadlineApi {
  Future<NewsModel> getHeadline(String channelName) async {
    String headlineUrl =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=e86c18ae5c54483aa37342f4e5972d24';
    final Response response = await http.get(Uri.parse(headlineUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      debugPrint('THE RESPONSE COME ARE:');
      debugPrint(response.body);
      return NewsModel.fromJson(body);
    }
    throw Exception('Error occure within getHeadlineMethod');
  }

  Future<CategoryNewsModel> getCategory(String category) async {
    String categoryUrl =
        'https://newsapi.org/v2/everything?q=$category&from=2023-07-14&sortBy=publishedAt&apiKey=e86c18ae5c54483aa37342f4e5972d24';
    final Response response = await http.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      debugPrint('API GET ARE:: ${response.body}');
      final body = jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    }
    throw Exception('Error occure within getCategory method');
  }
}
