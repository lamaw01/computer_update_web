// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/computer_detail_model.dart';
import '../model/update_model.dart';

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

  Future<List<ComputerDetailModel>> getAllComputerDetail() async {
    Response response = await _dio.get('/get_computer_detail.php');
    // debugPrint(response.data.toString());
    return computerDetailModelFromJson(json.encode(response.data));
  }

  Future<List<UpdateModel>> getUpdate() async {
    Response response = await _dio.get('/get_update.php');
    // debugPrint(response.data.toString());
    return updateModelFromJson(json.encode(response.data));
  }

  Future<void> updateStatus({
    required int id,
    required int status,
    required int updateCode,
  }) async {
    Response response = await _dio.post(
      '/update_status_table.php',
      data: {"id": id, "status": status, "update_code": updateCode},
    );
    debugPrint(response.data.toString());
  }

  Future<void> addUpdateStatus({
    required int status,
    required int updateCode,
  }) async {
    Response response = await _dio.post(
      '/add_update_status_table.php',
      data: {"status": status, "update_code": updateCode},
    );
    debugPrint(response.data.toString());
  }
}
