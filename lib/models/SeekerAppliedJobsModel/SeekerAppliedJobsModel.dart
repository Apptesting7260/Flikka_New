// To parse this JSON data, do
//
//     final seekerAppliedJobsModel = seekerAppliedJobsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';

SeekerAppliedJobsModel seekerAppliedJobsModelFromJson(String str) => SeekerAppliedJobsModel.fromJson(json.decode(str));

String seekerAppliedJobsModelToJson(SeekerAppliedJobsModel data) => json.encode(data.toJson());

class SeekerAppliedJobsModel {
  bool? status;
  dynamic lat ;
  dynamic long ;
  List<AppliedJobsList>? job;

  SeekerAppliedJobsModel({
    this.status,
    this.long ,
    this.lat ,
    this.job,
  });

  factory SeekerAppliedJobsModel.fromJson(Map<String, dynamic> json) => SeekerAppliedJobsModel(
    status: json["status"],
    lat: json["lat"],
    long: json["long"],
    job: json["job"] == null ? json["job"] : List<AppliedJobsList>.from(json["job"].map((x) => AppliedJobsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "job": List<dynamic>.from(job!.map((x) => x.toJson())),
  };
}

class AppliedJobsList {
  dynamic id;
  dynamic recruiterId;
  String? featureImg;
  String? video ;
  dynamic postSaved ;
  dynamic postApplied ;
  String? jobTitle;
  String? jobPosition;
  String? specialization;
  String? jobLocation;
  String? description;
  String? requirements;
  String? employmentType;
  String? typeOfWorkplace;
  String? workExperience;
  String? preferredWorkExperience;
  String? education;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? jobPositions;
  dynamic requestedStatus;
  dynamic applicantStatus;
  dynamic lat ;
  dynamic long ;
  List<LanguageModel>? languageName;
  AppliedJobsDetail? jobsDetail;
  RecruiterDetails? recruiterDetails;

  AppliedJobsList({
    this.id,
    this.recruiterId,
    this.featureImg,
    this.video,
    this.postSaved,
    this.postApplied,
    this.jobTitle,
    this.jobPosition,
    this.specialization,
    this.jobLocation,
    this.description,
    this.requirements,
    this.employmentType,
    this.typeOfWorkplace,
    this.workExperience,
    this.preferredWorkExperience,
    this.education,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.jobPositions,
    this.languageName,
    this.jobsDetail,
    this.recruiterDetails,
    this.lat ,
    this.long ,
    this.requestedStatus,
    this.applicantStatus,
  });

  factory AppliedJobsList.fromJson(Map<String, dynamic> json) => AppliedJobsList(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    featureImg: json["feature_img"],
    jobTitle: json["job_title"],
    video: json["short_video"],
    postSaved: json["post_saved"],
    postApplied: json["post_applied"],
    jobPosition: json["job_position"],
    specialization: json["specialization"],
    jobLocation: json["job_location"],
    description: json["description"],
    requirements: json["requirements"],
    employmentType: json["employment_type"],
    typeOfWorkplace: json["type_of_workplace"],
    workExperience: json["work_experience"],
    preferredWorkExperience: json["preferred_work_experience"],
    education: json["education"],
    language: json["language"],
    lat: json["lat"],
    long: json["long"],
    requestedStatus: json["requested_status"],
    applicantStatus: json["applicant_status"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => LanguageModel.fromJson(x))),
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : AppliedJobsDetail.fromJson(json["jobs_detail"]),
    recruiterDetails: json["recruiter_details"] == null ? json["recruiter_details"] : RecruiterDetails.fromJson(json["recruiter_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "feature_img": featureImg,
    "job_title": jobTitle,
    "job_position": jobPosition,
    "specialization": specialization,
    "job_location": jobLocation,
    "description": description,
    "requirements": requirements,
    "employment_type": employmentType,
    "type_of_workplace": typeOfWorkplace,
    "work_experience": workExperience,
    "preferred_work_experience": preferredWorkExperience,
    "education": education,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_positions": jobPositions,
    // "language_name": List<LanguageModel>.from(languageName!.map((x) => x)),
    "jobs_detail": jobsDetail?.toJson(),
    "recruiter_details": recruiterDetails?.toJson(),
  };
}

class AppliedJobsDetail {
  dynamic id;
  dynamic jobId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  String? salaryExpectationName;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  AppliedJobsDetail({
    this.id,
    this.jobId,
    this.createdAt,
    this.updatedAt,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.maxSalaryExpectation,
    this.minSalaryExpectation,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
  });

  factory AppliedJobsDetail.fromJson(Map<String, dynamic> json) => AppliedJobsDetail(
    id: json["id"],
    jobId: json["job_id"],
    maxSalaryExpectation: json["max_salary_expectation"],
    minSalaryExpectation: json["min_salary_expectation"],
    createdAt: json["created_at"] == null ? json["created_at"]  : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class AvailabityName {
  String? availabity;

  AvailabityName({
    this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "availabity": availabity,
  };
}

class IndustryPreferenceName {
  String? industryPreferences;

  IndustryPreferenceName({
    this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "industry_preferences": industryPreferences,
  };
}

class PassionName {
  String? passion;

  PassionName({
    this.passion,
  });

  factory PassionName.fromJson(Map<String, dynamic> json) => PassionName(
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "passion": passion,
  };
}

class SkillName {
  String? skills;

  SkillName({
    this.skills,
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
  };
}

class StartWorkName {
  String? startWork;

  StartWorkName({
    this.startWork,
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "start_work": startWork,
  };
}

class StrengthsName {
  String? strengths;

  StrengthsName({
    this.strengths,
  });

  factory StrengthsName.fromJson(Map<String, dynamic> json) => StrengthsName(
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "strengths": strengths,
  };
}

class RecruiterDetails {
  dynamic id;
  dynamic recruiterId;
  String? profileImg;
  String? coverImg;
  String? companyName;
  String? companyLocation;
  String? addBio;
  dynamic homeTitle;
  dynamic homeDescription;
  String? websiteLink;
  dynamic aboutTitle;
  String? aboutDescription;
  String? industry;
  String? companySize;
  // DateTime founded;
  String? specialties;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? industris;

  RecruiterDetails({
    this.id,
    this.recruiterId,
    this.profileImg,
    this.coverImg,
    this.companyName,
    this.companyLocation,
    this.addBio,
    this.homeTitle,
    this.homeDescription,
    this.websiteLink,
    this.aboutTitle,
    this.aboutDescription,
    this.industry,
    this.companySize,
    // this.founded,
    this.specialties,
    this.createdAt,
    this.updatedAt,
    this.industris,
  });

  factory RecruiterDetails.fromJson(Map<String, dynamic> json) => RecruiterDetails(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    profileImg: json["profile_img"],
    coverImg: json["cover_img"],
    companyName: json["company_name"],
    companyLocation: json["company_location"],
    addBio: json["add_bio"],
    homeTitle: json["home_title"],
    homeDescription: json["home_description"],
    websiteLink: json["website_link"],
    aboutTitle: json["about_title"],
    aboutDescription: json["about_description"],
    industry: json["industry"],
    companySize: json["company_size"],
    // founded: DateTime.parse(json["founded"]),
    specialties: json["specialties"],
    createdAt:json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    industris: json["industris"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "profile_img": profileImg,
    "cover_img": coverImg,
    "company_name": companyName,
    "company_location": companyLocation,
    "add_bio": addBio,
    "home_title": homeTitle,
    "home_description": homeDescription,
    "website_link": websiteLink,
    "about_title": aboutTitle,
    "about_description": aboutDescription,
    "industry": industry,
    "company_size": companySize,
    // "founded": "${founded.year.toString().padLeft(4, '0')}-${founded.month.toString().padLeft(2, '0')}-${founded.day.toString().padLeft(2, '0')}",
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industris": industris,
  };
}
