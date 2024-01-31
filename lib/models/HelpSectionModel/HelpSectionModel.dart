// To parse this JSON data, do
//
//     final helpSectionModel = helpSectionModelFromJson(jsonString);

import 'dart:convert';

HelpSectionModel helpSectionModelFromJson(String str) => HelpSectionModel.fromJson(json.decode(str));

String helpSectionModelToJson(HelpSectionModel data) => json.encode(data.toJson());

class HelpSectionModel {
  bool? status;
  String? message;

  HelpSectionModel({
     this.status,
     this.message,
  });

  factory HelpSectionModel.fromJson(Map<String, dynamic> json) => HelpSectionModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
