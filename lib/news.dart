import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class NewsModel {
  final int id;
  final String message;

  NewsModel({@required this.id, @required this.message});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      message: json['message'],
    );
  }
}

Future<List<NewsModel>> fetchNews() async {
  final response = await http.get(Uri.https('sane.cchampou.me', 'news'));

  developer.log(response.statusCode.toString());
  if (response.statusCode == 200) {
    return List.from(jsonDecode(response.body).map((e) => NewsModel.fromJson(e)));
  } else {
    throw Exception('Failed to load album');
  }
}