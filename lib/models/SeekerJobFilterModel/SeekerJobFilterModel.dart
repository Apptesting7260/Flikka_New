// To parse this JSON data, do
//
//     final seekerJobFilterModel = seekerJobFilterModelFromJson(jsonString);

import 'dart:convert';

SeekerJobFilterModel seekerJobFilterModelFromJson(String str) => SeekerJobFilterModel.fromJson(json.decode(str));

String seekerJobFilterModelToJson(SeekerJobFilterModel data) => json.encode(data.toJson());

class SeekerJobFilterModel {
  bool? status;
  List<SeekerFilteredJobsList>? jobs;

  SeekerJobFilterModel({
    this.status,
    this.jobs,
  });

  factory SeekerJobFilterModel.fromJson(Map<String, dynamic> json) => SeekerJobFilterModel(
    status: json["status"],
    jobs: json["jobs"] == null ? json["jobs"] : List<SeekerFilteredJobsList>.from(json["jobs"].map((x) => SeekerFilteredJobsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
  };
}

class SeekerFilteredJobsList {
  dynamic id;
  dynamic recruiterId;
  dynamic featureImg;
  String? video ;
  dynamic postSaved ;
  dynamic postApplied ;
  dynamic jobTitle;
  dynamic jobPosition;
  dynamic specialization;
  dynamic jobLocation;
  dynamic description;
  dynamic requirements;
  dynamic employmentType;
  dynamic typeOfWorkplace;
  dynamic workExperience;
  dynamic preferredWorkExperience;
  dynamic education;
  dynamic language;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic jobMatchPercentage;
  dynamic jobPositions;
  List<LanguageName>? languageName;
  JobsDetail? jobsDetail;
  RecruiterDetails? recruiterDetails;
  dynamic lat ;
  dynamic long ;

  SeekerFilteredJobsList({
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
    this.jobMatchPercentage,
    this.jobPositions,
    this.languageName,
    this.jobsDetail,
    this.recruiterDetails,
    this.lat,
    this.long,
  });

  factory SeekerFilteredJobsList.fromJson(Map<String, dynamic> json) => SeekerFilteredJobsList(
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
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobMatchPercentage: json["job_match_percentage"],
    jobPositions: json["job_positions"],
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageName>.from(json["language_name"].map((x) => LanguageName.fromJson(x))),
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : JobsDetail.fromJson(json["jobs_detail"]),
    recruiterDetails: json["recruiter_details"] == null ? json["recruiter_details"] : RecruiterDetails.fromJson(json["recruiter_details"]),
    lat: json["lat"],
    long: json["long"],
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
    "preferred_work_experience":preferredWorkExperience,
    "education": education,
    "language": language,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_match_percentage": jobMatchPercentage,
    "job_positions": jobPositions,
    "language_name": List<dynamic>.from(languageName!.map((x) => x.toJson())),
    "jobs_detail": jobsDetail?.toJson(),
    "recruiter_details": recruiterDetails?.toJson(),
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
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    skillName: json["skill_name"] == null ? json["skill_name"] :List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
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
  dynamic passion;

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
  dynamic startWork;

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
  dynamic strengths;

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
  dynamic languages;

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

class RecruiterDetails {
  dynamic id;
  dynamic recruiterId;
  dynamic profileImg;
  dynamic coverImg;
  dynamic companyName;
  dynamic companyLocation;
  dynamic addBio;
  dynamic homeTitle;
  dynamic homeDescription;
  dynamic websiteLink;
  dynamic aboutTitle;
  dynamic aboutDescription;
  dynamic industry;
  dynamic companySize;
  dynamic founded;
  dynamic specialties;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic industris;

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
    founded: json["founded"] ,
    specialties: json["specialties"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
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
    "founded": "${founded?.year.toString().padLeft(4, '0')}-${founded?.month.toString().padLeft(2, '0')}-${founded?.day.toString().padLeft(2, '0')}",
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industris": industris,
  };
}
