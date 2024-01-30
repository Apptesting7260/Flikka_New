// To parse this JSON data, do
//
//     final jobAlertWiseJobListingModel = jobAlertWiseJobListingModelFromJson(jsonString);

import 'dart:convert';

JobAlertWiseJobListingModel jobAlertWiseJobListingModelFromJson(String str) => JobAlertWiseJobListingModel.fromJson(json.decode(str));

String jobAlertWiseJobListingModelToJson(JobAlertWiseJobListingModel data) => json.encode(data.toJson());

class JobAlertWiseJobListingModel {
  bool? status;
  List<JobList>? jobList;

  JobAlertWiseJobListingModel({
     this.status,
     this.jobList,
  });

  factory JobAlertWiseJobListingModel.fromJson(Map<String, dynamic> json) => JobAlertWiseJobListingModel(
    status: json["status"],
    jobList: json["job_list"] == null ? json["job_list"] : List<JobList>.from(json["job_list"].map((x) => JobList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "job_list": List<dynamic>.from(jobList!.map((x) => x.toJson())),
  };
}

class JobList {
  dynamic id;
  dynamic recruiterId;
  String? featureImg;
  dynamic shortVideo;
  String? jobTitle;
  String? jobPosition;
  dynamic specialization;
  String? jobLocation;
  dynamic description;
  dynamic requirements;
  String? employmentType;
  dynamic typeOfWorkplace;
  String? workExperience;
  dynamic preferredWorkExperience;
  dynamic education;
  String? language;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? jobPositions;
  List<LanguageName>? languageName;
  JobsDetail? jobsDetail;
  Recruiter? recruiter;
  RecruiterDetails? recruiterDetails;

  JobList({
     this.id,
     this.recruiterId,
     this.featureImg,
     this.shortVideo,
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
     this.deletedAt,
     this.createdAt,
     this.updatedAt,
     this.jobPositions,
     this.languageName,
     this.jobsDetail,
     this.recruiter,
     this.recruiterDetails,
  });

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    featureImg: json["feature_img"],
    shortVideo: json["short_video"],
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
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageName>.from(json["language_name"].map((x) => LanguageName.fromJson(x))),
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : JobsDetail.fromJson(json["jobs_detail"]),
    recruiter: json["recruiter"] == null ? json["recruiter"] : Recruiter.fromJson(json["recruiter"]),
    recruiterDetails: json["recruiter_details"] == null ? json["recruiter_details"] : RecruiterDetails.fromJson(json["recruiter_details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "feature_img": featureImg,
    "short_video": shortVideo,
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
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_positions": jobPositions,
    "language_name": List<dynamic>.from(languageName!.map((x) => x.toJson())),
    "jobs_detail": jobsDetail!.toJson(),
    "recruiter": recruiter!.toJson(),
    "recruiter_details": recruiterDetails!.toJson(),
  };
}

class JobsDetail {
  dynamic id;
  dynamic jobId;
  dynamic recruiterId;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  JobsDetail({
     this.id,
     this.jobId,
     this.recruiterId,
     this.minSalaryExpectation,
     this.maxSalaryExpectation,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
     this.skillName,
     this.passionName,
     this.industryPreferenceName,
     this.strengthsName,
     this.startWorkName,
     this.availabityName,
  });

  factory JobsDetail.fromJson(Map<String, dynamic> json) => JobsDetail(
    id: json["id"],
    jobId: json["job_id"],
    recruiterId: json["recruiter_id"],
    minSalaryExpectation: json["min_salary_expectation"],
    maxSalaryExpectation: json["max_salary_expectation"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "recruiter_id": recruiterId,
    "min_salary_expectation": minSalaryExpectation,
    "max_salary_expectation": maxSalaryExpectation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class AvailabityName {
  dynamic id;
  String? availabity;

  AvailabityName({
     this.id,
     this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    id: json["id"],
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "availabity": availabity,
  };
}

class IndustryPreferenceName {
  dynamic id;
  String? industryPreferences;

  IndustryPreferenceName({
     this.id,
     this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    id: json["id"],
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "industry_preferences": industryPreferences,
  };
}

class PassionName {
  dynamic id;
  String? passion;

  PassionName({
     this.id,
     this.passion,
  });

  factory PassionName.fromJson(Map<String, dynamic> json) => PassionName(
    id: json["id"],
    passion: json["passion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "passion": passion,
  };
}

class SkillName {
  dynamic id;
  String? skills;

  SkillName({
     this.id,
     this.skills,
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    id: json["id"],
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "skills": skills,
  };
}

class StartWorkName {
  dynamic id;
  String? startWork;

  StartWorkName({
     this.id,
     this.startWork,
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    id: json["id"],
    startWork: json["start_work"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_work": startWork,
  };
}

class StrengthsName {
  dynamic id;
  String? strengths;

  StrengthsName({
     this.id,
     this.strengths,
  });

  factory StrengthsName.fromJson(Map<String, dynamic> json) => StrengthsName(
    id: json["id"],
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "strengths": strengths,
  };
}

class LanguageName {
  dynamic id;
  String? languages;

  LanguageName({
     this.id,
     this.languages,
  });

  factory LanguageName.fromJson(Map<String, dynamic> json) => LanguageName(
    id: json["id"],
    languages: json["languages"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "languages": languages,
  };
}

class Recruiter {
  dynamic id;
  String? fullname;
  String? email;
  String? password;
  dynamic mobile;
  String? referralBy;
  String? status;
  int? resumeStep;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  String? googleId;
  dynamic companyEmail;
  dynamic companyVerifyOtp;
  dynamic deviceToken;
  int? online;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? companyReviews;

  Recruiter({
     this.id,
     this.fullname,
     this.email,
     this.password,
     this.mobile,
     this.referralBy,
     this.status,
     this.resumeStep,
     this.resetPassOtp,
     this.resetPassOtpTime,
     this.googleId,
     this.companyEmail,
     this.companyVerifyOtp,
     this.deviceToken,
     this.online,
     this.createdAt,
     this.updatedAt,
     this.companyReviews,
  });

  factory Recruiter.fromJson(Map<String, dynamic> json) => Recruiter(
    id: json["id"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    referralBy: json["referral_by"],
    status: json["status"],
    resumeStep: json["resume_step"],
    resetPassOtp: json["reset_pass_otp"],
    resetPassOtpTime: json["reset_pass_otp_time"],
    googleId: json["google_id"],
    companyEmail: json["company_email"],
    companyVerifyOtp: json["company_verify_otp"],
    deviceToken: json["device_token"],
    online: json["online"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    companyReviews: json["company_reviews"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "password": password,
    "mobile": mobile,
    "referral_by": referralBy,
    "status": status,
    "resume_step": resumeStep,
    "reset_pass_otp": resetPassOtp,
    "reset_pass_otp_time": resetPassOtpTime,
    "google_id": googleId,
    "company_email": companyEmail,
    "company_verify_otp": companyVerifyOtp,
    "device_token": deviceToken,
    "online": online,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "company_reviews": companyReviews,
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
  DateTime? founded;
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
     this.founded,
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
    founded: json["founded"] == null ? json["founded"] : DateTime.parse(json["founded"]),
    specialties: json["specialties"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "founded": "${founded?.year.toString().padLeft(4, '0')}-${founded?.month.toString().padLeft(2, '0')}-${founded?.day.toString().padLeft(2, '0')}",
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industris": industris,
  };
}
