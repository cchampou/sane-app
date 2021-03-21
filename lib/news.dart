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
  final response = await http.get(Uri.http('192.168.1.19:8000', 'news'));

  developer.log(response.statusCode.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    developer.log(response.body.toString());
    // return NewsModel.fromJson(jsonDecode(response.body));
    return List.from(jsonDecode(response.body).map((e) => NewsModel.fromJson(e)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}