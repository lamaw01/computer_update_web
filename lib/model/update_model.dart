// To parse this JSON data, do
//
//     final updateModel = updateModelFromJson(jsonString);

import 'dart:convert';

List<UpdateModel> updateModelFromJson(String str) => List<UpdateModel>.from(
    json.decode(str).map((x) => UpdateModel.fromJson(x)));

String updateModelToJson(List<UpdateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateModel {
  int id;
  int status;
  int updateCode;
  int updateOnce;
  DateTime timeStamp;

  UpdateModel({
    required this.id,
    required this.status,
    required this.updateCode,
    required this.updateOnce,
    required this.timeStamp,
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
        id: json["id"],
        status: json["status"],
        updateCode: json["update_code"],
        updateOnce: json["update_once"],
        timeStamp: DateTime.parse(json["time_stamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "update_code": updateCode,
        "update_once": updateOnce,
        "time_stamp": timeStamp.toIso8601String(),
      };
}
