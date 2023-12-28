import 'dart:convert';

import 'package:bloc_learn/model/news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/users_model.dart';

class UserRepository {
  String loginUrl = 'https://hsi-proteksi.com/api/login';
  String newsUrl = 'https://api-berita-indonesia.vercel.app/cnn/ekonomi/';

  Future<List<News>> getNews() async {
    Response response = await get(Uri.parse(newsUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data']['posts'];

      return result.map((e) => News.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<UserModel> login(
      String username, String password, String deviceId) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    Map body = {
      'username': username,
      'password': password,
      'device_id': deviceId,
    };

    http.Response response = await http.post(Uri.parse(loginUrl),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['data']['user_detail'];

      if (kDebugMode) {
        print('desde repository');
      }
      if (kDebugMode) {
        print(result);
      }
      return UserModel.fromJson(result);
    } else {
      if (kDebugMode) {
        print('error_repository ${response.statusCode}');
      }
      throw Exception(response.reasonPhrase);
    }
  }
}
