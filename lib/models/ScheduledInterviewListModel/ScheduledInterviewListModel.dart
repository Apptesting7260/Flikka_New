// To parse this JSON data, do
//
//     final scheduledInterviewlListModel = scheduledInterviewlListModelFromJson(jsonString);

import 'dart:convert';

ScheduledInterviewListModel scheduledInterviewListModelFromJson(String str) => ScheduledInterviewListModel.fromJson(json.decode(str));

String scheduledInterviewListModelToJson(ScheduledInterviewListModel data) => json.encode(data.toJson());

class ScheduledInterviewListModel {
  bool? status;
  List<Seeker>? seeker;

  ScheduledInterviewListModel({
    this.status,
    this.seeker,
  });

  factory ScheduledInterviewListModel.fromJson(Map<String, dynamic> json) => ScheduledInterviewListModel(
    status: json["status"],
    seeker: json["seeker"] == null ? json["seeker"] : List<Seeker>.from(json["seeker"].map((x) => Seeker.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "seeker": List<dynamic>.from(seeker!.map((x) => x.toJson())),
  };
}

class Seeker {
  dynamic id;
  dynamic seekerId;
  dynamic jobId;
  String? status;
  String? interviewLink;
  dynamic interviewScheduleTime;
  String? interviewStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerData? seekerData;
  Details? details ;

  Seeker({
    this.id,
    this.seekerId,
    this.jobId,
    this.status,
    this.interviewLink ,
    this.interviewScheduleTime,
    this.interviewStatus,
    this.createdAt,
    this.updatedAt,
    this.seekerData,
    this.details
  });

  factory Seeker.fromJson(Map<String, dynamic> json) => Seeker(
    id: json["id"],
    seekerId: json["seeker_id"],
    jobId: json["job_id"],
    status: json["status"],
    interviewLink: json["interview_link"],
    interviewScheduleTime: json["interview_schedule_time"]
        == null ? json["interview_schedule_time"] : DateTime.parse(json["interview_schedule_time"]),
    interviewStatus: json["interview_status"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerData: json["seekerlist"] == null ? json["seekerlist"] : SeekerData.fromJson(json["seekerlist"]),
    details: json["job_details"] == null ? json["job_details"] : Details.fromJson(json["job_details"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "job_id": jobId,
    "status": status,
    "interview_schedule_time": interviewScheduleTime,
    "interview_status": interviewStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seekerlist": seekerData?.toJson(),
  };
}

class SeekerData {
  dynamic id;
  String? profileImg;
  String? fullname;
  String? email;
  String? password;
  String? location;
  String? aboutMe;
  String? documentType;
  String? documentImg;
  String? resume;
  dynamic totalExperience;
  String? referralCode;
  String? referralBy;
  String? currentAmount;
  String? status;
  dynamic staupType;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SeekerData({
    this.id,
    this.profileImg,
    this.fullname,
    this.email,
    this.password,
    this.location,
    this.aboutMe,
    this.documentType,
    this.documentImg,
    this.resume,
    this.totalExperience,
    this.referralCode,
    this.referralBy,
    this.currentAmount,
    this.status,
    this.staupType,
    this.resetPassOtp,
    this.resetPassOtpTime,
    this.googleId,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerData.fromJson(Map<String, dynamic> json) => SeekerData(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    location: json["location"],
    aboutMe: json["about_me"],
    documentType: json["document_type"],
    documentImg: json["document_img"],
    resume: json["resume"],
    totalExperience: json["total_experience"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    currentAmount: json["current_amount"],
    status: json["status"],
    staupType: json["staup_type"],
    resetPassOtp: json["reset_pass_otp"],
    resetPassOtpTime: json["reset_pass_otp_time"],
    googleId: json["google_id"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "email": email,
    "password": password,
    "location": location,
    "about_me": aboutMe,
    "document_type": documentType,
    "document_img": documentImg,
    "resume": resume,
    "total_experience": totalExperience,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "current_amount": currentAmount,
    "status": status,
    "staup_type": staupType,
    "reset_pass_otp": resetPassOtp,
    "reset_pass_otp_time": resetPassOtpTime,
    "google_id": googleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Details {
  String? jobTitle ;

  Details({
    this.jobTitle
});

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    jobTitle: json["job_title"]
  ) ;
}
