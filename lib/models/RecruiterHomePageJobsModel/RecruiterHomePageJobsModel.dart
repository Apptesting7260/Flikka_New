// To parse this JSON data, do
//
//     final recruiterHomePageJobsModel = recruiterHomePageJobsModelFromJson(jsonString);

import 'dart:convert';

RecruiterHomePageJobsModel recruiterHomePageJobsModelFromJson(String str) => RecruiterHomePageJobsModel.fromJson(json.decode(str));

String recruiterHomePageJobsModelToJson(RecruiterHomePageJobsModel data) => json.encode(data.toJson());

class RecruiterHomePageJobsModel {
  bool? status;
  List<JobPositionList>? jobPositionList;

  RecruiterHomePageJobsModel({
    this.status,
    this.jobPositionList,
  });

  factory RecruiterHomePageJobsModel.fromJson(Map<String, dynamic> json) => RecruiterHomePageJobsModel(
    status: json["status"],
    jobPositionList: json["job_position_list"] == null ? json["job_position_list"] : List<JobPositionList>.from(json["job_position_list"].map((x) => JobPositionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "job_position_list": List<dynamic>.from(jobPositionList!.map((x) => x.toJson())),
  };
}

class JobPositionList {
  dynamic id;
  String? positions;

  JobPositionList({
    this.id,
    this.positions,
  });

  factory JobPositionList.fromJson(Map<String, dynamic> json) => JobPositionList(
    id: json["id"],
    positions: json["positions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "positions": positions,
  };
}
