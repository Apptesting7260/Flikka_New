// To parse this JSON data, do
//
//     final jobAlertSeenUnseen = jobAlertSeenUnseenFromJson(jsonString);

import 'dart:convert';

JobAlertSeenUnseenModel jobAlertSeenUnseenFromJson(String str) => JobAlertSeenUnseenModel.fromJson(json.decode(str));

String jobAlertSeenUnseenToJson(JobAlertSeenUnseenModel data) => json.encode(data.toJson());

class JobAlertSeenUnseenModel {
  bool? status;
  String? message;

  JobAlertSeenUnseenModel({
     this.status,
     this.message,
  });

  factory JobAlertSeenUnseenModel.fromJson(Map<String, dynamic> json) => JobAlertSeenUnseenModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
