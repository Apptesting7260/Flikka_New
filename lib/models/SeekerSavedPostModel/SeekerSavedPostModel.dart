// To parse this JSON data, do
//
//     final seekerSavedJobsListModel = seekerSavedJobsListModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

SeekerSavedJobsListModel seekerSavedJobsListModelFromJson(String str) => SeekerSavedJobsListModel.fromJson(json.decode(str));

String seekerSavedJobsListModelToJson(SeekerSavedJobsListModel data) => json.encode(data.toJson());

class SeekerSavedJobsListModel {
  bool? status;
  List<SeekerSavedJobsDatum>? data;

  SeekerSavedJobsListModel({
    this.status,
    this.data,
  });

  factory SeekerSavedJobsListModel.fromJson(Map<String, dynamic> json) => SeekerSavedJobsListModel(
    status: json["status"],
    data: json["data"] == null ? json["data"] : List<SeekerSavedJobsDatum>.from(json["data"].map((x) => SeekerSavedJobsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SeekerSavedJobsDatum {
  dynamic id;
  dynamic seekerId;
  dynamic jobId;
  dynamic type;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerSavedJobsData? jobData;

  SeekerSavedJobsDatum({
    this.id,
    this.seekerId,
    this.jobId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.jobData,
  });

  factory SeekerSavedJobsDatum.fromJson(Map<String, dynamic> json) => SeekerSavedJobsDatum(
    id: json["id"],
    seekerId: json["seeker_id"],
    jobId: json["job_id"],
    type: json["type"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobData: json["job_data"] == null ? json["job_data"] : SeekerSavedJobsData.fromJson(json["job_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "job_id": jobId,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_data": jobData?.toJson(),
  };
}

class SeekerSavedJobsRecruiterDetails {
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
  // dynamic founded;
  String? specialties;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? industris;
  List<SeekerSavedJobsData>? recDetails;

  SeekerSavedJobsRecruiterDetails({
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
    this.recDetails,
  });

  factory SeekerSavedJobsRecruiterDetails.fromJson(Map<String, dynamic> json) => SeekerSavedJobsRecruiterDetails(
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
    // founded: json["founded"] == null ? json["founded"] : DateFormat('yyyy-MM-dd').format(DateTime.parse(json["founded"])),
    specialties: json["specialties"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    industris: json["industris"],
    recDetails: json["rec_details"] == null ? json["rec_details"] : List<SeekerSavedJobsData>.from(json["rec_details"].map((x) => SeekerSavedJobsData.fromJson(x))),
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
    // "founded": "${founded?.year.toString().padLeft(4, '0')}-${founded?.month.toString().padLeft(2, '0')}-${founded?.day.toString().padLeft(2, '0')}",
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industris": industris,
    "rec_details": List<dynamic>.from(recDetails!.map((x) => x.toJson())),
  };
}

class SeekerSavedJobsData {
  dynamic id;
  dynamic recruiterId;
  String? featureImg;
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
  List<SeekerSavedJobsLanguageName>? languageName;
  SeekerSavedJobsDetail? jobsDetail;
  SeekerSavedJobsRecruiterDetails? recruiterDetails;

  SeekerSavedJobsData({
    this.id,
    this.recruiterId,
    this.featureImg,
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
  });

  factory SeekerSavedJobsData.fromJson(Map<String, dynamic> json) => SeekerSavedJobsData(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    featureImg: json["feature_img"],
    jobTitle: json["job_title"],
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
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<SeekerSavedJobsLanguageName>.from(json["language_name"].map((x) => SeekerSavedJobsLanguageName.fromJson(x))),
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : SeekerSavedJobsDetail.fromJson(json["jobs_detail"]),
    recruiterDetails: json["recruiter_details"] == null ? json["recruiter_details"] : SeekerSavedJobsRecruiterDetails.fromJson(json["recruiter_details"]),
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
    "language_name": List<dynamic>.from(languageName!.map((x) => x.toJson())),
    "jobs_detail": jobsDetail?.toJson(),
    "recruiter_details": recruiterDetails?.toJson(),
  };
}

class SeekerSavedJobsDetail {
  dynamic id;
  dynamic jobId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SeekerSavedJobsSkillName>? skillName;
  List<SeekerSavedJobsPassionName>? passionName;
  List<SeekerSavedJobsIndustryPreferenceName>? industryPreferenceName;
  List<SeekerSavedJobsStrengthsName>? strengthsName;
  String? salaryExpectationName;
  List<SeekerSavedJobsStartWorkName>? startWorkName;
  List<SeekerSavedJobsAvailabityName>? availabityName;

  SeekerSavedJobsDetail({
    this.id,
    this.jobId,
    this.createdAt,
    this.updatedAt,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
  });

  factory SeekerSavedJobsDetail.fromJson(Map<String, dynamic> json) => SeekerSavedJobsDetail(
    id: json["id"],
    jobId: json["job_id"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SeekerSavedJobsSkillName>.from(json["skill_name"].map((x) => SeekerSavedJobsSkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<SeekerSavedJobsPassionName>.from(json["passion_name"].map((x) => SeekerSavedJobsPassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<SeekerSavedJobsIndustryPreferenceName>.from(json["industry_preference_name"].map((x) => SeekerSavedJobsIndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<SeekerSavedJobsStrengthsName>.from(json["strengths_name"].map((x) => SeekerSavedJobsStrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<SeekerSavedJobsStartWorkName>.from(json["start_work_name"].map((x) => SeekerSavedJobsStartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<SeekerSavedJobsAvailabityName>.from(json["availabity_name"].map((x) => SeekerSavedJobsAvailabityName.fromJson(x))),
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

class SeekerSavedJobsAvailabityName {
  String? availabity;

  SeekerSavedJobsAvailabityName({
    this.availabity,
  });

  factory SeekerSavedJobsAvailabityName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsAvailabityName(
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "availabity": availabity,
  };
}

class SeekerSavedJobsIndustryPreferenceName {
  String? industryPreferences;

  SeekerSavedJobsIndustryPreferenceName({
    this.industryPreferences,
  });

  factory SeekerSavedJobsIndustryPreferenceName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsIndustryPreferenceName(
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "industry_preferences": industryPreferences,
  };
}

class SeekerSavedJobsPassionName {
  String? passion;

  SeekerSavedJobsPassionName({
    this.passion,
  });

  factory SeekerSavedJobsPassionName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsPassionName(
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "passion": passion,
  };
}

class SeekerSavedJobsSkillName {
  String? skills;

  SeekerSavedJobsSkillName({
    this.skills,
  });

  factory SeekerSavedJobsSkillName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsSkillName(
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
  };
}

class SeekerSavedJobsStartWorkName {
  String? startWork;

  SeekerSavedJobsStartWorkName({
    this.startWork,
  });

  factory SeekerSavedJobsStartWorkName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsStartWorkName(
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "start_work": startWork,
  };
}

class SeekerSavedJobsStrengthsName {
  String? strengths;

  SeekerSavedJobsStrengthsName({
    this.strengths,
  });

  factory SeekerSavedJobsStrengthsName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsStrengthsName(
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "strengths": strengths,
  };
}

class SeekerSavedJobsLanguageName {
  dynamic id;
  String? languages;

  SeekerSavedJobsLanguageName({
    this.id,
    this.languages,
  });

  factory SeekerSavedJobsLanguageName.fromJson(Map<String, dynamic> json) => SeekerSavedJobsLanguageName(
    id: json["id"],
    languages: json["languages"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "languages": languages,
  };
}
