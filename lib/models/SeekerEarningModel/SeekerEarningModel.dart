
import 'dart:convert';

SeekerEarningModel seekerEarningModelFromJson(String str) => SeekerEarningModel.fromJson(json.decode(str));

String seekerEarningModelToJson(SeekerEarningModel data) => json.encode(data.toJson());

class SeekerEarningModel {
  bool? status;
  String? referralCode;
  String? totalAmount;
  dynamic bankAccount;
  List<Seeker>? seeker;
  List<Recruiter>? recruiter;

  SeekerEarningModel({
    this.status,
    this.referralCode,
    this.totalAmount,
    this.bankAccount,
    this.seeker,
    this.recruiter,
  });

  factory SeekerEarningModel.fromJson(Map<String, dynamic> json) => SeekerEarningModel(
    status: json["status"],
    referralCode: json["referral_code"],
    totalAmount: json["total_amount"],
    bankAccount: json["bank_account"],
    seeker: json["seeker"] == null ? json["seeker"] : List<Seeker>.from(json["seeker"].map((x) => Seeker.fromJson(x))),
    recruiter: json["recruiter"] == null ? json["recruiter"] : List<Recruiter>.from(json["recruiter"].map((x) => Recruiter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "referral_code": referralCode,
    "total_amount": totalAmount,
    "bank_account" : bankAccount ,
    "seeker": List<dynamic>.from(seeker!.map((x) => x.toJson())),
    "recruiter": List<dynamic>.from(recruiter!.map((x) => x.toJson())),
  };
}

class Recruiter {
  dynamic id;
  String? fullname;
  String? email;
  String? password;
  String? referralBy;
  String? status;
  dynamic resumeStep;
  dynamic resetPassOtp;
  DateTime? createdAt;
  DateTime? updatedAt;
  Recruiterdetails? recruiterdetails;

  Recruiter({
    this.id,
    this.fullname,
    this.email,
    this.password,
    this.referralBy,
    this.status,
    this.resumeStep,
    this.resetPassOtp,
    this.createdAt,
    this.updatedAt,
    this.recruiterdetails,
  });

  factory Recruiter.fromJson(Map<String, dynamic> json) => Recruiter(
    id: json["id"],
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    referralBy: json["referral_by"],
    status: json["status"],
    resumeStep: json["resume_step"],
    resetPassOtp: json["reset_pass_otp"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    recruiterdetails: json["recruiterdetails"] == null ? json["recruiterdetails"] : Recruiterdetails.fromJson(json["recruiterdetails"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "password": password,
    "referral_by": referralBy,
    "status": status,
    "resume_step": resumeStep,
    "reset_pass_otp": resetPassOtp,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "recruiterdetails": recruiterdetails?.toJson(),
  };
}

class Recruiterdetails {
  dynamic id;
  dynamic recruiterId;
  String? profileImg;
  String? coverImg;
  String? companyName;
  String? companyLocation;
  String? addBio;
  String? homeTitle;
  String? homeDescription;
  String? websiteLink;
  String? aboutTitle;
  String? aboutDescription;
  String? industry;
  String? companySize;
  // DateTime? founded;
  String? specialties;
  DateTime? createdAt;
  DateTime? updatedAt;

  Recruiterdetails({
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
  });

  factory Recruiterdetails.fromJson(Map<String, dynamic> json) => Recruiterdetails(
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
    // founded: json["founded"] == null ? json["founded"] : DateFormat('yyyy/MM/dd').parse(json["founded"]),
    specialties: json["specialties"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
  };
}

class Seeker {
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
  String? totalExperience;
  String? referralCode;
  String? referralBy;
  String? currentAmount;
  String? status;
  dynamic staupType;
  dynamic resetPassOtp;
  DateTime? createdAt;
  DateTime? updatedAt;

  Seeker({
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
    this.createdAt,
    this.updatedAt,
  });

  factory Seeker.fromJson(Map<String, dynamic> json) => Seeker(
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
