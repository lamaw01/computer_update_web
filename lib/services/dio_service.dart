import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/computer_detail_model.dart';

class DioService {
  static const String _serverUrl = 'http://192.168.221.21/computer_details/';

  final _dio = Dio(
    BaseOptions(
      baseUrl: '$_serverUrl/api',
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

  // Future<List<EventLogModel>> getEventLog({required int eventId}) async {
  //   Response response =
  //       await _dio.post('/get_event_log.php', data: {"event_id": eventId});
  //   // debugPrint(response.data.toString());
  //   return eventLogModelFromJson(json.encode(response.data));
  // }
}
