// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../model/computer_detail_model.dart';
import '../model/department_model.dart';
import '../model/note_model.dart';
import '../model/update_model.dart';

class DioService {
  static const String _serverUrl = 'https://192.168.221.21/computer_details/';

  final _dio = Dio(
    BaseOptions(
      baseUrl: '$_serverUrl/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: <String, String>{
        'Accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
    ),
  );

  Future<List<ComputerDetailModel>> getAllComputerDetail() async {
    final response = await _dio.get('/get_computer_detail.php');
    // final Response<dynamic> response =
    //     await _dio.get('/get_computer_detail.php');
    // debugPrint('response.data.toString()');
    return computerDetailModelFromJson(json.encode(response.data));
  }

  Future<List<UpdateModel>> getUpdate() async {
    final response = await _dio.get('/get_update.php');
    // debugPrint(response.data.toString());
    return updateModelFromJson(json.encode(response.data));
  }

  Future<void> updateStatus({
    required int id,
    required int status,
    required int updateCode,
    required int updateOnce,
  }) async {
    final response = await _dio.post(
      '/update_status_table.php',
      data: {
        "id": id,
        "status": status,
        "update_code": updateCode,
        "update_once": updateOnce,
      },
    );
    debugPrint(response.data.toString());
  }

  Future<void> addUpdateStatus({
    required int status,
    required int updateCode,
    required int updateOnce,
  }) async {
    final response = await _dio.post(
      '/add_update_status_table.php',
      data: {
        "status": status,
        "update_code": updateCode,
        "update_once": updateOnce
      },
    );
    debugPrint(response.data.toString());
  }

  Future<void> addNote({
    required String note,
    required String updateId,
    required String uuid,
  }) async {
    final response = await _dio.post(
      '/add_note.php',
      data: {
        "note": note,
        "update_id": updateId,
        "uuid": uuid,
      },
    );
    debugPrint(response.data.toString());
  }

  Future<void> updateNote({
    required int id,
    required String note,
    required String uuid,
  }) async {
    final response = await _dio.post(
      '/update_note.php',
      data: {
        "id": id,
        "note": note,
        "uuid": uuid,
      },
    );
    debugPrint(response.data.toString());
  }

  Future<NoteModel> getNote({
    required String uuid,
  }) async {
    final response = await _dio.post(
      '/get_note.php',
      data: {
        "uuid": uuid,
      },
    );
    // debugPrint(response.data.toString());
    return noteModelFromJson(json.encode(response.data));
  }

  Future<List<ComputerDetailModel>> getHistory(String uuid) async {
    final response = await _dio.post('/get_history.php', data: {
      "uuid": uuid,
    });
    // debugPrint(response.data.toString());
    return computerDetailModelFromJson(json.encode(response.data));
  }

  Future<List<ComputerDetailModel>> searchComputer(String search) async {
    final response = await _dio.post(
      '/search_computer.php',
      data: {"search": search},
    );
    // debugPrint(response.data.toString());
    return computerDetailModelFromJson(json.encode(response.data));
  }

  Future<void> addDepartment({
    required String department,
  }) async {
    final response = await _dio.post(
      '/add_department.php',
      data: {"department": department},
    );
    debugPrint(response.data.toString());
  }

  Future<List<DepartmentModel>> getDepartment() async {
    final response = await _dio.get('/get_department.php');
    // debugPrint(response.data.toString());
    return departmentModelFromJson(json.encode(response.data));
  }

  Future<DepartmentModel> getComputerDepartment(String uuid) async {
    final response =
        await _dio.post('/get_computer_department.php', data: {"uuid": uuid});
    debugPrint(response.data.toString());
    return soloDepartmentModelFromJson(json.encode(response.data));
  }

  Future<void> updateComputerDepartment(String uuid, int departmentID) async {
    final response = await _dio.post(
      '/update_computer_department.php',
      data: {"uuid": uuid, "department_id": departmentID},
    );
    debugPrint(response.data.toString());
  }

  Future<void> addComputerDepartment(String uuid, int departmentID) async {
    final response = await _dio.post(
      '/add_computer_department.php',
      data: {"uuid": uuid, "department_id": departmentID},
    );
    debugPrint(response.data.toString());
  }

  Future<List<ComputerDetailModel>> getDepartmentComputerDetail(
      int departmentID) async {
    final response = await _dio.post(
      '/get_department_computer_detail.php',
      data: {"department_id": departmentID},
    );
    // debugPrint(response.data.toString());
    return computerDetailModelFromJson(json.encode(response.data));
  }
}
