// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  int id;
  String note;
  String uuid;
  DateTime timeStamp;
  String updateId;

  NoteModel({
    required this.id,
    required this.note,
    required this.uuid,
    required this.timeStamp,
    required this.updateId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        note: json["note"],
        uuid: json["uuid"],
        timeStamp: DateTime.parse(json["time_stamp"]),
        updateId: json["update_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "uuid": uuid,
        "time_stamp": timeStamp.toIso8601String(),
        "update_id": updateId,
      };
}
