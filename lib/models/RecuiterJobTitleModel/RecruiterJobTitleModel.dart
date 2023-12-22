// To parse this JSON data, do
//
//     final recruiterJobTitleModel = recruiterJobTitleModelFromJson(jsonString);

import 'dart:convert';

RecruiterJobTitleModel recruiterJobTitleModelFromJson(String str) => RecruiterJobTitleModel.fromJson(json.decode(str));

String recruiterJobTitleModelToJson(RecruiterJobTitleModel data) => json.encode(data.toJson());

class RecruiterJobTitleModel {
  bool? status;
  List<RecruiterJobTitleList>? jobTitleList;

  RecruiterJobTitleModel({
    this.status,
    this.jobTitleList,
  });

  factory RecruiterJobTitleModel.fromJson(Map<String, dynamic> json) => RecruiterJobTitleModel(
    status: json["status"],
    jobTitleList: json["job_title_list"] == null ? json["job_title_list"] : List<RecruiterJobTitleList>.from(json["job_title_list"].map((x) => RecruiterJobTitleList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "job_title_list": List<dynamic>.from(jobTitleList!.map((x) => x.toJson())),
  };
}

class RecruiterJobTitleList {
  dynamic id;
  String? jobTitle;

  RecruiterJobTitleList({
    this.id,
    this.jobTitle,
  });

  factory RecruiterJobTitleList.fromJson(Map<String, dynamic> json) => RecruiterJobTitleList(
    id: json["id"],
    jobTitle: json["job_title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_title": jobTitle,
  };
}
