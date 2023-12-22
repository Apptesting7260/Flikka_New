
import 'dart:convert';

TalentPoolModel talentPoolModelFromJson(String str) => TalentPoolModel.fromJson(json.decode(str));

String talentPoolModelToJson(TalentPoolModel data) => json.encode(data.toJson());

class TalentPoolModel {
  bool? status;
  List<TalentPoolModelData>? data;

  TalentPoolModel({
    this.status,
    this.data,
  });

  factory TalentPoolModel.fromJson(Map<String, dynamic> json) => TalentPoolModel(
    status: json["status"],
    data: json["data"] == null ? json["data"] : List<TalentPoolModelData>.from(json["data"].map((x) => TalentPoolModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TalentPoolModelData {
  dynamic id;
  dynamic seekerId;
  dynamic recruiterId;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  SeekerData? seekerData;
  SeekerDetailsInfo? seekerDetailsInfo;

  TalentPoolModelData({
    this.id,
    this.seekerId,
    this.recruiterId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.seekerData,
    this.seekerDetailsInfo,
  });

  factory TalentPoolModelData.fromJson(Map<String, dynamic> json) => TalentPoolModelData(
    id: json["id"],
    seekerId: json["seeker_id"],
    recruiterId: json["recruiter_id"],
    description: json["discription"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    seekerData: json["seeker_data"] == null ? json["seeker_data"] : SeekerData.fromJson(json["seeker_data"]),
    seekerDetailsInfo: json["seeker_details_info"] == null ? json["seeker_details_info"] : SeekerDetailsInfo.fromJson(json["seeker_details_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "recruiter_id": recruiterId,
    "discription": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "seeker_data": seekerData?.toJson(),
    "seeker_details_info": seekerDetailsInfo?.toJson(),
  };
}

class SeekerData {
  dynamic id;
  String? profileImg;
  String? shortVideo;
  String? fullname;
  String? email;
  String? password;
  String? mobile;
  String? location;
  String? aboutMe;
  String? documentType;
  String? documentImg;
  String? resume;
  String? referralCode;
  String? referralBy;
  String? currentAmount;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SeekerData({
    this.id,
    this.profileImg,
    this.shortVideo,
    this.fullname,
    this.email,
    this.password,
    this.mobile,
    this.location,
    this.aboutMe,
    this.documentType,
    this.documentImg,
    this.resume,
    this.referralCode,
    this.referralBy,
    this.currentAmount,
    this.resetPassOtp,
    this.resetPassOtpTime,
    this.googleId,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerData.fromJson(Map<String, dynamic> json) => SeekerData(
    id: json["id"],
    profileImg: json["profile_img"],
    shortVideo: json["short_video"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    location: json["location"],
    aboutMe: json["about_me"],
    documentType: json["document_type"],
    documentImg: json["document_img"],
    resume: json["resume"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    currentAmount: json["current_amount"],
    resetPassOtp: json["reset_pass_otp"],
    resetPassOtpTime: json["reset_pass_otp_time"],
    googleId: json["google_id"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "short_video": shortVideo,
    "fullname": fullname,
    "email": email,
    "password": password,
    "mobile": mobile,
    "location": location,
    "about_me": aboutMe,
    "document_type": documentType,
    "document_img": documentImg,
    "resume": resume,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "current_amount": currentAmount,
    "reset_pass_otp": resetPassOtp,
    "reset_pass_otp_time": resetPassOtpTime,
    "google_id": googleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class SeekerDetailsInfo {
  dynamic id;
  dynamic seekerId;
  String? position;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  dynamic fresher;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  dynamic salaryExpectationName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;

  SeekerDetailsInfo({
    this.id,
    this.seekerId,
    this.position,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.fresher,
    this.workExpJob,
    this.educationLevel,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
  });

  factory SeekerDetailsInfo.fromJson(Map<String, dynamic> json) => SeekerDetailsInfo(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    minSalaryExpectation: json["min_salary_expectation"],
    maxSalaryExpectation: json["max_salary_expectation"],
    fresher: json["fresher"],
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    positions: json["positions"],
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
    "seeker_id": seekerId,
    "position": position,
    "min_salary_expectation": minSalaryExpectation,
    "max_salary_expectation": maxSalaryExpectation,
    "fresher": fresher,
    "work_exp_job": List<dynamic>.from(workExpJob!.map((x) => x.toJson())),
    "education_level": List<dynamic>.from(educationLevel!.map((x) => x.toJson())),
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class Appreciation {
  String? awardName;
  String? achievement;

  Appreciation({
    this.awardName,
    this.achievement,
  });

  factory Appreciation.fromJson(Map<String, dynamic> json) => Appreciation(
    awardName: json["award_name"],
    achievement: json["achievement"],
  );

  Map<String, dynamic> toJson() => {
    "award_name": awardName,
    "achievement": achievement,
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

class EducationLevel {
  String? educationLevel;
  String? institutionName;
  DateTime? educationStartDate;
  dynamic educationEndDate;

  EducationLevel({
    this.educationLevel,
    this.institutionName,
    this.educationStartDate,
    this.educationEndDate,
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
    educationLevel: json["education_level"],
    institutionName: json["institution_name"],
    educationStartDate: json["education_start_date"] == null ? json["education_start_date"] : DateTime.parse(json["education_start_date"]),
    educationEndDate: json["education_end_date"],
  );

  Map<String, dynamic> toJson() => {
    "education_level": educationLevel,
    "institution_name": institutionName,
    "education_start_date": "${educationStartDate?.year.toString().padLeft(4, '0')}-${educationStartDate?.month.toString().padLeft(2, '0')}-${educationStartDate?.day.toString().padLeft(2, '0')}",
    "education_end_date": educationEndDate,
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

class WorkExpJob {
  String? workExpJob;
  String? companyName;
  DateTime? jobStartDate;
  dynamic jobEndDate;

  WorkExpJob({
    this.workExpJob,
    this.companyName,
    this.jobStartDate,
    this.jobEndDate,
  });

  factory WorkExpJob.fromJson(Map<String, dynamic> json) => WorkExpJob(
    workExpJob: json["work_exp_job"],
    companyName: json["company_name"],
    jobStartDate: json["job_start_date"] == null ? json["job_start_date"] : DateTime.parse(json["job_start_date"]),
    jobEndDate: json["job_end_date"],
  );

  Map<String, dynamic> toJson() => {
    "work_exp_job": workExpJob,
    "company_name": companyName,
    "job_start_date": "${jobStartDate?.year.toString().padLeft(4, '0')}-${jobStartDate?.month.toString().padLeft(2, '0')}-${jobStartDate?.day.toString().padLeft(2, '0')}",
    "job_end_date": jobEndDate,
  };
}
