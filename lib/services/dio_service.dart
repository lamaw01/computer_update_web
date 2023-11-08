import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/computer_detail_model.dart';

class DioService {
  static const String _serverUrl = 'http://103.62.153.74:53000';

  final _dio = Dio(
    BaseOptions(
      baseUrl: '$_serverUrl/computer_detail',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );

  Future<List<ComputerDetailModel>> getComputerDetail() async {
    Response response = await _dio.get('/get_computer_detail.php');
    debugPrint(response.data.toString());
    return computerDetailModelFromJson(json.encode(response.data));
  }
}
