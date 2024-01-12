
import 'dart:convert';

RecruiterHomePageModel recruiterHomePageModelFromJson(String str) => RecruiterHomePageModel.fromJson(json.decode(str));

String recruiterHomePageModelToJson(RecruiterHomePageModel data) => json.encode(data.toJson());

class RecruiterHomePageModel {
  bool? status;
  String? message;
  List<RecruiterHomePageSeekerDetail>? Seeker_Details;

  RecruiterHomePageModel({
    this.status,
    this.message,
    this.Seeker_Details,
  });

  factory RecruiterHomePageModel.fromJson(Map<String, dynamic> json) => RecruiterHomePageModel(
    status: json["status"],
    message: json["message"],
    Seeker_Details: json["Seeker_Details"] == null ? json["Seeker_Details"] : List<RecruiterHomePageSeekerDetail>.from(json["Seeker_Details"].map((x) => RecruiterHomePageSeekerDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Seeker_Details": List<dynamic>.from(Seeker_Details!.map((x) => x.toJson())),
  };
}

class RecruiterHomePageSeekerDetail {
  dynamic id;
  dynamic seekerId;
  dynamic position;
  dynamic minSalaryExpectation;
  dynamic maxSalaryExpectation;
  dynamic fresher;
  dynamic video ;
  bool? isApplied ;
  List<WorkExpJob>? workExpJob;
  List<EducationLevel>? educationLevel;
  List<LanguageModel>? language;
  List<Appreciation>? appreciation;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic jobMatchPercentage;
  String? positions;
  List<SkillName>? skillName;
  List<PassionName>? passionName;
  List<IndustryPreferenceName>? industryPreferenceName;
  List<StrengthsName>? strengthsName;
  dynamic salaryExpectationName;
  List<StartWorkName>? startWorkName;
  List<AvailabityName>? availabityName;
  RecruiterHomePageSeeker? seeker;

  RecruiterHomePageSeekerDetail({
    this.id,
    this.seekerId,
    this.position,
    this.video,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.fresher,
    this.workExpJob,
    this.isApplied ,
    this.educationLevel,
    this.language,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.jobMatchPercentage,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.salaryExpectationName,
    this.startWorkName,
    this.availabityName,
    this.seeker,
  });

  factory RecruiterHomePageSeekerDetail.fromJson(Map<String, dynamic> json) => RecruiterHomePageSeekerDetail(
    id: json["id"],
    seekerId: json["seeker_id"],
    position: json["position"],
    video: json["short_video"],
    isApplied: json["is_applied"],
    minSalaryExpectation: json["min_salary_expectation"],
    maxSalaryExpectation: json["max_salary_expectation"],
    fresher: json["fresher"],
    workExpJob: json["work_exp_job"] == null ? json["work_exp_job"] : List<WorkExpJob>.from(json["work_exp_job"].map((x) => WorkExpJob.fromJson(x))),
    educationLevel: json["education_level"] == null ? json["education_level"] : List<EducationLevel>.from(json["education_level"].map((x) => EducationLevel.fromJson(x))),
    language: json["language"] == null ? json["language"] : List<LanguageModel>.from(json["language"].map((x) => LanguageModel.fromJson(x))),
    appreciation: json["appreciation"] == null ? json["appreciation"] : List<Appreciation>.from(json["appreciation"].map((x) => Appreciation.fromJson(x))),
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
    jobMatchPercentage: json["job_match_percentage"],
    positions: json["positions"],
    skillName: json["skill_name"] == null ? json["skill_name"] : List<SkillName>.from(json["skill_name"].map((x) => SkillName.fromJson(x))),
    passionName: json["passion_name"] == null ? json["passion_name"] : List<PassionName>.from(json["passion_name"].map((x) => PassionName.fromJson(x))),
    industryPreferenceName: json["industry_preference_name"] == null ? json["industry_preference_name"] : List<IndustryPreferenceName>.from(json["industry_preference_name"].map((x) => IndustryPreferenceName.fromJson(x))),
    strengthsName: json["strengths_name"] == null ? json["strengths_name"] : List<StrengthsName>.from(json["strengths_name"].map((x) => StrengthsName.fromJson(x))),
    salaryExpectationName: json["salary_expectation_name"],
    startWorkName: json["start_work_name"] == null ? json["start_work_name"] : List<StartWorkName>.from(json["start_work_name"].map((x) => StartWorkName.fromJson(x))),
    availabityName: json["availabity_name"] == null ? json["availabity_name"] : List<AvailabityName>.from(json["availabity_name"].map((x) => AvailabityName.fromJson(x))),
    seeker: json["seeker"] == null ? json["seeker"] : RecruiterHomePageSeeker.fromJson(json["seeker"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seeker_id": seekerId,
    "position": position,
    "min_salary_expectation": minSalaryExpectation,
    "max_salary_expectation": maxSalaryExpectation,
    "fresher": fresher ,
    "is_applied": isApplied ,
    "work_exp_job": List<dynamic>.from(workExpJob!.map((x) => x.toJson())),
    "education_level": List<dynamic>.from(educationLevel!.map((x) => x.toJson())),
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "appreciation": List<dynamic>.from(appreciation!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_match_percentage": jobMatchPercentage,
    "positions": positions,
    "skill_name": List<dynamic>.from(skillName!.map((x) => x.toJson())),
    "passion_name": List<dynamic>.from(passionName!.map((x) => x.toJson())),
    "industry_preference_name": List<dynamic>.from(industryPreferenceName!.map((x) => x.toJson())),
    "strengths_name": List<dynamic>.from(strengthsName!.map((x) => x.toJson())),
    "salary_expectation_name": salaryExpectationName,
    "start_work_name": List<dynamic>.from(startWorkName!.map((x) => x.toJson())),
    "availabity_name": List<dynamic>.from(availabityName!.map((x) => x.toJson())),
    "seeker": seeker?.toJson(),
  };
}

class RecruiterHomePageSeeker {
  dynamic id;
  String? profileImg;
  String? video;
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
  dynamic currentAmount;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  dynamic googleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  RecruiterHomePageSeeker({
    this.id,
    this.profileImg,
    this.video,
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

  factory RecruiterHomePageSeeker.fromJson(Map<String, dynamic> json) => RecruiterHomePageSeeker(
    id: json["id"],
    profileImg: json["profile_img"],
    video: json["short_video"],
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
    "short_video": video,
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

