// To parse this JSON data, do
//
//     final recruiterReportModel = recruiterReportModelFromJson(jsonString);

import 'dart:convert';

RecruiterReportModel recruiterReportModelFromJson(String str) => RecruiterReportModel.fromJson(json.decode(str));

String recruiterReportModelToJson(RecruiterReportModel data) => json.encode(data.toJson());

class RecruiterReportModel {
  bool? status;
  String? message;
  ReportData? percentData;
  ReportData? totalCountData;

  RecruiterReportModel({
    this.status,
    this.message,
    this.percentData,
    this.totalCountData,
  });

  factory RecruiterReportModel.fromJson(Map<String, dynamic> json) => RecruiterReportModel(
    status: json["status"],
    message: json["message"],
    percentData: json["percent_data"] == null ? json["percent_data"] : ReportData.fromJson(json["percent_data"]),
    totalCountData: json["total_count_data"] == null ? json["total_count_data"] : ReportData.fromJson(json["total_count_data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "percent_data": percentData?.toJson(),
    "total_count_data": totalCountData?.toJson(),
  };
}

class ReportData {
  dynamic applicantApplied;
  dynamic hired;
  dynamic rejected;
  dynamic matchProfile;
  dynamic interviewSchedule;

  ReportData({
    this.applicantApplied,
    this.hired,
    this.rejected,
    this.matchProfile,
    this.interviewSchedule,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
    applicantApplied: json["Applicant_Applied"],
    hired: json["Hired"],
    rejected: json["Rejected"],
    matchProfile: json["Match_Profil"],
    interviewSchedule: json["Interview_Schedule"],
  );

  Map<String, dynamic> toJson() => {
    "Applicant_Applied": applicantApplied,
    "Hired": hired,
    "Rejected": rejected,
    "Match_Profil": matchProfile,
    "Interview_Schedule": interviewSchedule,
  };
}
