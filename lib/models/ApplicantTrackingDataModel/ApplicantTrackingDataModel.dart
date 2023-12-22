
import 'dart:convert';

import '../ViewLanguageModel/VIewLanguageModel.dart';

ApplicantTrackingDataModel applicantTrackingDataModelFromJson(String str) => ApplicantTrackingDataModel.fromJson(json.decode(str));

String applicantTrackingDataModelToJson(ApplicantTrackingDataModel data) => json.encode(data.toJson());

class ApplicantTrackingDataModel {
  bool? status;
  List<ApplicantDatum>? applicantData;

  ApplicantTrackingDataModel({
    this.status,
    this.applicantData,
  });

  factory ApplicantTrackingDataModel.fromJson(Map<String, dynamic> json) => ApplicantTrackingDataModel(
    status: json["status"],
    applicantData: json["applicant_data"] == null ? json["applicant_data"] : List<ApplicantDatum>.from(json["applicant_data"].map((x) => ApplicantDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "applicant_data": List<dynamic>.from(applicantData!.map((x) => x.toJson())),
  };
}

class ApplicantDatum {
  dynamic id;
  String? jobTitle;
  String? jobPositions;
  List<LanguageModel>? languageName;
  List<AppliedJob>? appliedJob;

  ApplicantDatum({
    this.id,
    this.jobTitle,
    this.jobPositions,
    this.languageName,
    this.appliedJob,
  });

  factory ApplicantDatum.fromJson(Map<String, dynamic> json) => ApplicantDatum(
    id: json["id"],
    jobTitle: json["job_title"],
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => LanguageModel.fromJson(x))),
    appliedJob: json["applied_job"] == null ? json["applied_job"] : List<AppliedJob>.from(json["applied_job"].map((x) => AppliedJob.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_title": jobTitle,
    "job_positions": jobPositions,
    "language_name": List<dynamic>.from(languageName!.map((x) => x)),
    "applied_job": List<dynamic>.from(appliedJob!.map((x) => x.toJson())),
  };
}

class AppliedJob {
  dynamic id;
  dynamic seekerId;
  dynamic jobId;
  String? status;
  DateTime? interviewScheduleTime;
  String? interviewStatus;
  dynamic scheduleInterView;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerData? seekerData;

  AppliedJob({
    this.id,
    this.seekerId,
    this.jobId,
    this.status,
    this.interviewScheduleTime,
    this.interviewStatus,
    this.scheduleInterView,
    this.createdAt,
    this.updatedAt,
    this.seekerData,
  });

  factory AppliedJob.fromJson(Map<String, dynamic> json) => AppliedJob(
    id: json["id"],
    seekerId: json["seeker_id"],
    jobId: json["job_id"],
    status: json["status"],
    interviewScheduleTime: json["interview_schedule_time"] == null ? json["interview_schedule_time"] : DateTime.tryParse(json["interview_schedule_time"]),
    interviewStatus: json["interview_status"],
    scheduleInterView: json["scheduled_interview"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerData: json["seeker_data"] == null ? json["seeker_data"] : SeekerData.fromJson(json["seeker_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "job_id": jobId,
    "status": status,
    "interview_schedule_time": interviewScheduleTime?.toIso8601String(),
    "interview_status": interviewStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seeker_data": seekerData?.toJson(),
  };
}

class SeekerData {
  dynamic id;
  String? profileImg;
  String? fullname;
  String? location;

  SeekerData({
    this.id,
    this.profileImg,
    this.fullname,
    this.location,
  });

  factory SeekerData.fromJson(Map<String, dynamic> json) => SeekerData(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "location": location,
  };
}
