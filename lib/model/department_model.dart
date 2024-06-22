// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> departmentModelFromJson(String str) =>
    List<DepartmentModel>.from(
        json.decode(str).map((x) => DepartmentModel.fromJson(x)));

DepartmentModel soloDepartmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String departmentModelToJson(List<DepartmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
  int id;
  String department;
  bool selected;

  DepartmentModel({
    required this.id,
    required this.department,
    this.selected = false,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      DepartmentModel(
        id: json["id"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department": department,
      };
}
