
import 'dart:convert';

GetJobsListingModel getJobsListingFromJson(String str) => GetJobsListingModel.fromJson(json.decode(str));

String getJobsListingToJson(GetJobsListingModel data) => json.encode(data.toJson());

class GetJobsListingModel {
  bool? status;
  List<SeekerJobsData>? jobs;
  // String? message;

  GetJobsListingModel({
    this.status,
    this.jobs,
    // this.message,
  });

  factory GetJobsListingModel.fromJson(Map<String, dynamic> json) => GetJobsListingModel(
    status: json["status"],
    jobs: json["Jobs"] == null ? json["Jobs"] : List<SeekerJobsData>.from(json["Jobs"].map((x) => SeekerJobsData.fromJson(x))),
    // message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Jobs": List<dynamic>.from(jobs!.map((x) => x.toJson())),
    // "message": message,
  };
}

class SeekerJobsData {
  var id;
  var recruiterId;
  String? featureImg;
  String? jobTitle;
  String? video ;
  dynamic postSaved ;
  dynamic postApplied ;
  String? specialization;
  String? jobLocation;
  String? description;
  String? requirements;
  String? employmentType;
  String? typeOfWorkplace;
  String? workExperience;
  String? preferredWorkExperience;
  String? education;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? jobPositions;
  String? countryCode ;
  dynamic lat ;
  dynamic long ;
  dynamic jobMatchPercentage ;
  List<LanguageModel>? languageName ;
  RecruiterDetails? recruiterDetails;
  JobsDetail? jobsDetail;

  SeekerJobsData({
    this.id,
    this.recruiterId,
    this.featureImg,
    this.jobTitle,
    this.video,
    this.postSaved,
    this.postApplied,
    this.specialization,
    this.jobLocation,
    this.description,
    this.requirements,
    this.employmentType,
    this.typeOfWorkplace,
    this.workExperience,
    this.preferredWorkExperience,
    this.education,
    this.createdAt,
    this.updatedAt,
    this.languageName ,
    this.jobPositions,
    this.recruiterDetails,
    this.jobsDetail,
    this.jobMatchPercentage ,
    this.lat ,
    this.long ,
    this.countryCode
  });

  factory SeekerJobsData.fromJson(Map<String, dynamic> json) => SeekerJobsData(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    featureImg: json["feature_img"],
    jobTitle: json["job_title"],
    video: json["short_video"],
    postSaved: json["post_saved"],
    postApplied: json["post_applied"],
    specialization: json["specialization"],
    jobLocation: json["job_location"],
    description: json["description"],
    requirements: json["requirements"],
    employmentType: json["employment_type"],
    typeOfWorkplace: json["type_of_workplace"],
    workExperience: json["work_experience"],
    countryCode: json["country_code"],
    preferredWorkExperience: json["preferred_work_experience"],
    education: json["education"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    languageName: json["language_name"] == null ? json["language_name"] : List<LanguageModel>.from(json["language_name"].map((x) => LanguageModel.fromJson(x))),
    jobPositions: json["job_positions"],
    recruiterDetails: json["recruiter_details"] == null ? json["recruiter_details"] : RecruiterDetails.fromJson(json["recruiter_details"]),
    jobsDetail: json["jobs_detail"] == null ? json["jobs_detail"] : JobsDetail.fromJson(json["jobs_detail"]),
    jobMatchPercentage: json["job_match_percentage"],
      lat: json["lat"],
      long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "feature_img": featureImg,
    "job_title": jobTitle,
    "specialization": specialization,
    "job_location": jobLocation,
    "description": description,
    "requirements": requirements,
    "employment_type": employmentType,
    "type_of_workplace": typeOfWorkplace,
    "work_experience": workExperience,
    "preferred_work_experience": preferredWorkExperience,
    "education": education,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_positions": jobPositions,
    "recruiter_details": recruiterDetails?.toJson(),
    "jobs_detail": jobsDetail?.toJson(),
    "job_match_percentage":jobMatchPercentage ,
  };
}

class JobsDetail {
  dynamic id;
  dynamic jobId;
  dynamic recruiterId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  JobsDetail({
    this.id,
    this.jobId,
    this.recruiterId ,
    this.createdAt,
    this.updatedAt,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.startWorkName,
    this.availabityName,
  });

  factory JobsDetail.fromJson(Map<String, dynamic> json) => JobsDetail(
    id: json["id"],
    jobId: json["job_id"],
    recruiterId: json["recruiter_id"],
    maxSalaryExpectation: json["max_salary_expectation"],
    minSalaryExpectation: json["min_salary_expectation"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "min_salary_expectation": minSalaryExpectation,
    "max_salary_expectation": maxSalaryExpectation,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class AvailabityName {
  dynamic id ;
  String? availabity;

  AvailabityName({
    this.id ,
    this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    availabity:  json["availabity"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "availabity": availabity,
  };
}

class IndustryPreferenceName {
  dynamic id ;
  String? industryPreferences;

  IndustryPreferenceName({
    this.id ,
    this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    industryPreferences: json["industry_preferences"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "industry_preferences": industryPreferences,
  };
}

class PassionName {
  dynamic id ;
  String? passion;

  PassionName({
    this.id ,
    this.passion,
  });

  factory PassionName.fromJson(Map<String, dynamic> json) => PassionName(
    passion: json["passion"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "passion": passion,
  };
}

class SkillName {
  dynamic id ;
  String? skills;

  SkillName({
    this.skills,
    this.id
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    skills: json["skills"],
    id: json["id"]

  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
  };
}

class StartWorkName {
  dynamic id ;
  String? startWork;

  StartWorkName({
    this.startWork,
    this.id
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    startWork: json["start_work"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "start_work": startWork,
  };
}

class StrengthsName {
  dynamic id ;
  String? strengths;

  StrengthsName({
    this.strengths,
    this.id
  });

  factory StrengthsName.fromJson(Map<String, dynamic> json) => StrengthsName(
    strengths: json["strengths"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "strengths": strengths,
  };
}

class RecruiterDetails {
  var id;
  var recruiterId;
  dynamic profileImg;
  dynamic coverImg;
  String? companyName;
  dynamic companyLocation;
  dynamic addBio;
  dynamic homeDescription;
  dynamic websiteLink;
  dynamic aboutDescription;
  dynamic industry;
  dynamic companySize;
  dynamic founded;
  dynamic specialties;
  DateTime? createdAt;
  DateTime? updatedAt;

  RecruiterDetails({
    this.id,
    this.recruiterId,
    this.profileImg,
    this.coverImg,
    this.companyName,
    this.companyLocation,
    this.addBio,
    this.homeDescription,
    this.websiteLink,
    this.aboutDescription,
    this.industry,
    this.companySize,
    this.founded,
    this.specialties,
    this.createdAt,
    this.updatedAt,
  });

  factory RecruiterDetails.fromJson(Map<String, dynamic> json) => RecruiterDetails(
    id: json["id"],
    recruiterId: json["recruiter_id"],
    profileImg: json["profile_img"],
    coverImg: json["cover_img"],
    companyName: json["company_name"],
    companyLocation: json["company_location"],
    addBio: json["add_bio"],
    homeDescription: json["home_description"],
    websiteLink: json["website_link"],
    aboutDescription: json["about_description"],
    industry: json["industris"],
    companySize: json["company_size"],
    founded: json["founded"],
    specialties: json["specialties"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recruiter_id": recruiterId,
    "profile_img": profileImg,
    "cover_img": coverImg,
    "company_name": companyName,
    "company_location": companyLocation,
    "add_bio": addBio,
    "home_description": homeDescription,
    "website_link": websiteLink,
    "about_description": aboutDescription,
    "industris": industry,
    "company_size": companySize,
    "founded": founded,
    "specialties": specialties,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class LanguageModel {
  dynamic id;
  String? languages;

  LanguageModel({
    this.id,
    this.languages,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    id: json["id"],
    languages: json["languages"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "languages": languages,
  };
}
