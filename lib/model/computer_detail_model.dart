// To parse this JSON data, do
//
//     final computerDetailModel = computerDetailModelFromJson(jsonString);

import 'dart:convert';

List<ComputerDetailModel> computerDetailModelFromJson(String str) =>
    List<ComputerDetailModel>.from(
        json.decode(str).map((x) => ComputerDetailModel.fromJson(x)));

String computerDetailModelToJson(List<ComputerDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComputerDetailModel {
  int id;
  String uuid;
  String hostname;
  String network;
  String os;
  String defender;
  String cpu;
  String motherboard;
  String ram;
  String storage;
  String user;
  String monitor;
  String browser;
  String msoffice;
  String updateId;
  DateTime timeStamp;

  ComputerDetailModel({
    required this.id,
    required this.uuid,
    required this.hostname,
    required this.os,
    required this.defender,
    required this.cpu,
    required this.motherboard,
    required this.ram,
    required this.storage,
    required this.user,
    required this.network,
    required this.monitor,
    required this.browser,
    required this.timeStamp,
    required this.msoffice,
    required this.updateId,
  });

  factory ComputerDetailModel.fromJson(Map<String, dynamic> json) =>
      ComputerDetailModel(
        id: json["id"],
        uuid: json["uuid"],
        hostname: json["hostname"],
        os: json["os"],
        defender: json["defender"],
        cpu: json["cpu"],
        motherboard: json["motherboard"],
        ram: json["ram"],
        storage: json["storage"],
        user: json["user"],
        network: json["network"],
        monitor: json["monitor"],
        browser: json["browser"],
        msoffice: json["msoffice"],
        updateId: json["update_id"],
        timeStamp: DateTime.parse(json["time_stamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "hostname": hostname,
        "os": os,
        "defender": defender,
        "cpu": cpu,
        "motherboard": motherboard,
        "ram": ram,
        "storage": storage,
        "user": user,
        "network": network,
        "monitor": monitor,
        "browser": browser,
        "msoffice": msoffice,
        "update_id": updateId,
        "time_stamp": timeStamp.toIso8601String(),
      };
}
