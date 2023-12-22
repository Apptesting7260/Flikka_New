
// To parse this JSON data, do
//
//     final seekerGetAllSkillsModel = seekerGetAllSkillsModelFromJson(jsonString);

import 'dart:convert';

SeekerGetAllSkillsModel seekerGetAllSkillsModelFromJson(String str) => SeekerGetAllSkillsModel.fromJson(json.decode(str));

String seekerGetAllSkillsModelToJson(SeekerGetAllSkillsModel data) => json.encode(data.toJson());

class SeekerGetAllSkillsModel {
  bool? status;
  List<SeekerSkillsAvailability>? softSkill;
  List<SeekerSkillsAvailability>? passion;
  List<SeekerSkillsAvailability>? industry;
  List<SeekerSkillsAvailability>? strengths;
  List<SeekerSkillsAvailability>? salaryExpectation;
  List<SeekerSkillsAvailability>? startWork;
  List<SeekerSkillsAvailability>? availabity;
  String? message;

  SeekerGetAllSkillsModel({
    this.status,
    this.softSkill,
    this.passion,
    this.industry,
    this.strengths,
    this.salaryExpectation,
    this.startWork,
    this.availabity,
    this.message,
  });

  factory SeekerGetAllSkillsModel.fromJson(Map<String, dynamic> json) => SeekerGetAllSkillsModel(
    status: json["status"],
    softSkill: json["soft_skill"] == null ? json["soft_skill"] : List<SeekerSkillsAvailability>.from(json["soft_skill"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    passion: json["passion"] == null ? json["passion"] : List<SeekerSkillsAvailability>.from(json["passion"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    industry: json["industry"] == null ? json["industry"] : List<SeekerSkillsAvailability>.from(json["industry"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    strengths: json["strengths"] == null ? json["strengths"] : List<SeekerSkillsAvailability>.from(json["strengths"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    salaryExpectation: json["salary_expectation"] == null ? json["salary_expectation"] : List<SeekerSkillsAvailability>.from(json["salary_expectation"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    startWork: json["start_work"] == null ? json["start_work"] : List<SeekerSkillsAvailability>.from(json["start_work"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    availabity: json["availabity"] == null ? json["availabity"] : List<SeekerSkillsAvailability>.from(json["availabity"].map((x) => SeekerSkillsAvailability.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "soft_skill": List<dynamic>.from(softSkill!.map((x) => x.toJson())),
    "passion": List<dynamic>.from(passion!.map((x) => x.toJson())),
    "industry": List<dynamic>.from(industry!.map((x) => x.toJson())),
    "strengths": List<dynamic>.from(strengths!.map((x) => x.toJson())),
    "salary_expectation": List<dynamic>.from(salaryExpectation!.map((x) => x.toJson())),
    "start_work": List<dynamic>.from(startWork!.map((x) => x.toJson())),
    "availabity": List<dynamic>.from(availabity!.map((x) => x.toJson())),
    "message": message,
  };
}

class SeekerSkillsAvailability {
  var id;
  String? availabity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? industryPreferences;
  String? passion;
  dynamic salaryExpectation;
  String? skills;
  String? startWork;
  String? strengths;

  SeekerSkillsAvailability({
    this.id,
    this.availabity,
    this.createdAt,
    this.updatedAt,
    this.industryPreferences,
    this.passion,
    this.salaryExpectation,
    this.skills,
    this.startWork,
    this.strengths,
  });

  factory SeekerSkillsAvailability.fromJson(Map<String, dynamic> json) => SeekerSkillsAvailability(
    id: json["id"],
    availabity: json["availabity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    industryPreferences: json["industry_preferences"],
    passion: json["passion"],
    salaryExpectation: json["salary_expectation"],
    skills: json["skills"],
    startWork: json["start_work"],
    strengths: json["strengths"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "availabity": availabity,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "industry_preferences": industryPreferences,
    "passion": passion,
    "salary_expectation": salaryExpectation,
    "skills": skills,
    "start_work": startWork,
    "strengths": strengths,
  };
}
