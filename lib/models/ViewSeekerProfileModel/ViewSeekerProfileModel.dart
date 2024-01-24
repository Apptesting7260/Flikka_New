import 'dart:convert';
import 'package:intl/intl.dart';

ViewSeekerProfileModel viewSeekerProfileModelFromJson(String str) => ViewSeekerProfileModel.fromJson(json.decode(str));

String viewSeekerProfileModelToJson(ViewSeekerProfileModel data) => json.encode(data.toJson());

class ViewSeekerProfileModel {
  bool? status;
  var completeProfile;
  SeekerInfo? seekerInfo;
  SeekerDetails? seekerDetails;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  var message;

  ViewSeekerProfileModel({
    this.status,
    this.completeProfile,
    this.seekerInfo,
    this.seekerDetails,
    this.workExpJob ,
    this.educationLevel,
    this.message,
  });

  factory ViewSeekerProfileModel.fromJson(Map<String, dynamic> json) => ViewSeekerProfileModel(
    status: json["status"],
    completeProfile: json["Complite_Profile"],
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    seekerInfo: json["Seeker_info"] == null ? json["Seeker_info"] : SeekerInfo.fromJson(json["Seeker_info"]),
    seekerDetails: json["seeker_dtls"] == null ? json["seeker_dtls"] :  SeekerDetails.fromJson(json["seeker_dtls"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "Complite_Profile": completeProfile,
    "work_exp_job": List<dynamic>.from(workExpJob!.map((x) => x.toJson())),
    "education_level": List<dynamic>.from(educationLevel!.map((x) => x.toJson())),
    "Seeker_info": seekerInfo?.toJson(),
    "seeker_dtls": seekerDetails?.toJson(),
    "message": message,
  };
}

class SeekerDetails {
  dynamic id;
  dynamic seekerId;
  dynamic position ;
  List<SeekerLanguages>? language;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  // String? salaryExpectationName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;
  dynamic minSalary ;
  dynamic maxSalary ;

  SeekerDetails({
    this.id,
    this.seekerId,
    this.position ,
    this.language,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    // this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
    this.minSalary ,
    this.maxSalary ,
  });

  factory SeekerDetails.fromJson(Map<String, dynamic> json) => SeekerDetails(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    language:  json["language"] == null ? json["language"] : List<SeekerLanguages>.from(json["language"].map((x) => SeekerLanguages.fromJson(x))),
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    positions: json["positions"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    // salaryExpectationName: json["salary_expectation"] ,
    minSalary: json["min_salary_expectation"],
    maxSalary: json["max_salary_expectation"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "position" : position ,
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    // "salary_expectation": salaryExpectationName,
    "min_salary_expectation": minSalary ,
    "max_salary_expectation": maxSalary ,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
  };
}

class Appreciation {
  var awardName;
  var achievement;

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
  dynamic id ;
  String? availabity;

  AvailabityName({
    this.id ,
    this.availabity,
  });

  factory AvailabityName.fromJson(Map<String, dynamic> json) => AvailabityName(
    id: json["id"],
    availabity: json["availabity"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id ,
    "availabity": availabity,
  };
}

class EducationLevel {
  var educationLevel;
  var institutionName;
  var fieldOfStudy;
  dynamic educationStartDate;
  dynamic educationEndDate;
  bool? present ;

  EducationLevel({
    this.educationLevel,
    this.institutionName,
    this.fieldOfStudy,
    this.educationStartDate,
    this.educationEndDate,
    this.present
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
    educationLevel: json["education_level"],
    institutionName: json["institution_name"],
    fieldOfStudy: json["field_of_study"],
    educationStartDate: json["education_start_date"] == null ? json["education_start_date"] : DateTime.tryParse(json["education_start_date"]),
    educationEndDate: json["education_end_date"] == null || json["education_end_date"].toString() == "present" ? json["education_end_date"] : DateTime.tryParse(json["education_end_date"]),
    present : json["present"]
  );

  Map<String, dynamic> toJson() => {
    "education_level": educationLevel,
    "institution_name": institutionName,
    "field_of_study": fieldOfStudy,
    "education_start_date": "$educationStartDate" ,
        // ?.year.toString().padLeft(4, '0')}-${educationStartDate?.month.toString().padLeft(2, '0')}-${educationStartDate?.day.toString().padLeft(2, '0')}",
    "education_end_date": "$educationEndDate" ,
      // .year.toString().padLeft(4, '0')}-${educationEndDate?.month.toString().padLeft(2, '0')}-${educationEndDate?.day.toString().padLeft(2, '0')}",
  };
}

class SeekerLanguages {
  dynamic id ;
  String? languages ;

  SeekerLanguages({
   this.id ,
   this.languages
});
  factory SeekerLanguages.fromJson(Map<String , dynamic> json) => SeekerLanguages(
    id: json["id"] ,
    languages: json["languages"]
  );
  Map<String , dynamic> toJson() => {
    "id" : id ,
    "languages" : languages
  } ;
}

class IndustryPreferenceName {
  dynamic id ;
  String? industryPreferences;

  IndustryPreferenceName({
    this.id ,
    this.industryPreferences,
  });

  factory IndustryPreferenceName.fromJson(Map<String, dynamic> json) => IndustryPreferenceName(
    id: json["id"],
    industryPreferences: json["industry_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id ,
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
    "id" : id
  };
}

class SkillName {
  dynamic id ;
  String? skills;

  SkillName({
    this.id ,
    this.skills,
  });

  factory SkillName.fromJson(Map<String, dynamic> json) => SkillName(
    skills: json["skills"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id ,
    "skills": skills,
  };
}

class StartWorkName {
  String? startWork;
  dynamic id ;

  StartWorkName({
    this.startWork,
    this.id
  });

  factory StartWorkName.fromJson(Map<String, dynamic> json) => StartWorkName(
    startWork: json["start_work"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id ,
    "start_work": startWork,
  };
}

class StrengthsName {
  String? strengths;
  dynamic id ;

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
    "id" : id
  };
}

class WorkExpJob {
  String? workExpJob;
  String? companyName;
  dynamic jobStartDate;
  dynamic jobEndDate;
  bool? present ;

  WorkExpJob({
    this.workExpJob,
    this.companyName,
    this.jobStartDate,
    this.jobEndDate,
    this.present
  });

  factory WorkExpJob.fromJson(Map<String, dynamic> json) => WorkExpJob(
    workExpJob: json["work_exp_job"],
    companyName: json["company_name"],
    jobStartDate: json["job_start_date"] ,
    jobEndDate: json["job_end_date"],
    present: json["present"]
  );

  Map<String, dynamic> toJson() => {
    "work_exp_job": workExpJob,
    "company_name": companyName,
    "job_start_date": "$jobStartDate" ,
        // ?.year.toString().padLeft(4, '0')}-${jobStartDate?.month.toString().padLeft(2, '0')}-${jobStartDate?.day.toString().padLeft(2, '0')}",
    "job_end_date": "$jobEndDate" ,
    // ?.year.toString().padLeft(4, '0')}-${jobEndDate?.month.toString().padLeft(2, '0')}-${jobEndDate?.day.toString().padLeft(2, '0')}",
  };
}

class SeekerInfo {
  var id;
  var profileImg;
  var fullname;
  var email;
  var password;
  var location;
  String? countryCode;
  String? phone;
  String? video;
  String? aboutMe;
  var resume;
  dynamic totalExperience;
  var referralCode;
  dynamic referralBy;
  var status;
  String? documentType ;
  String? documentImg ;
  dynamic staupType;
  dynamic resetPassOtp;
  dynamic signupOtp;
  dynamic otpTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? documentLink ;
  String? resumeLink ;

  SeekerInfo({
    this.id,
    this.profileImg,
    this.fullname,
    this.email,
    this.password,
    this.location,
    this.phone,
    this.countryCode,
    this.video,
    this.aboutMe,
    this.resume,
    this.totalExperience,
    this.referralCode,
    this.referralBy,
    this.status,
    this.documentType ,
    this.documentImg ,
    this.staupType,
    this.resetPassOtp,
    this.signupOtp,
    this.otpTime,
    this.createdAt,
    this.updatedAt,
    this.documentLink ,
    this.resumeLink
  });

  factory SeekerInfo.fromJson(Map<String, dynamic> json) => SeekerInfo(
    id: json["id"],
    profileImg: json["profile_img"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    location: json["location"],
    countryCode: json["country_code"],
    phone: json["mobile"],
    video: json["short_video"],
    aboutMe: json["about_me"],
    resume: json["resume"],
    totalExperience: json["total_experience"],
    referralCode: json["referral_code"],
    referralBy: json["referral_by"],
    status: json["status"],
    staupType: json["staup_type"],
    resetPassOtp: json["reset_pass_otp"],
    signupOtp: json["signup_otp"],
    otpTime: json["otp_time"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    documentType: json["document_type"] ,
    documentImg: json["document_img"] ,
    documentLink: json["document_link"] ,
    resumeLink: json["resume_link"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_img": profileImg,
    "fullname": fullname,
    "email": email,
    "password": password,
    "location": location,
    "about_me": aboutMe,
    "resume": resume,
    "total_experience": totalExperience,
    "referral_code": referralCode,
    "referral_by": referralBy,
    "status": status,
    "staup_type": staupType,
    "reset_pass_otp": resetPassOtp,
    "signup_otp": signupOtp,
    "otp_time": otpTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "resume_link": resumeLink ,
    "document_link" : documentLink
  };
}
