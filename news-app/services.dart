import 'dart:convert';

import 'package:news_app_demo/models/article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> fetchArticles(Map<String, String> pram) async {
  final response = await http.get(
    Uri.https('newsapi.org', '/v1/articles', pram),
  );

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body)["articles"].cast<dynamic>();
    var formattedResult =
        result.map<Article>((json) => Article.fromJson(json)).toList();
    return formattedResult;
  } else {
    throw Exception('Failed to load articles');
  }
}
