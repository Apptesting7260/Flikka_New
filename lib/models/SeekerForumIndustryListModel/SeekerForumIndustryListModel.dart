// To parse this JSON data, do
//
//     final forumIndustryListModel = forumIndustryListModelFromJson(jsonString);

import 'dart:convert';

ForumIndustryListModel forumIndustryListModelFromJson(String str) => ForumIndustryListModel.fromJson(json.decode(str));

String forumIndustryListModelToJson(ForumIndustryListModel data) => json.encode(data.toJson());

class ForumIndustryListModel {
  bool? status;
  String? message;
  List<IndustryList>? industryList;

  ForumIndustryListModel({
    this.status,
    this.message,
    this.industryList,
  });

  factory ForumIndustryListModel.fromJson(Map<String, dynamic> json) => ForumIndustryListModel(
    status: json["status"],
    message: json["message"],
    industryList: json["industry_list"] == null ? json["industry_list"] : List<IndustryList>.from(json["industry_list"].map((x) => IndustryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "industry_list": List<dynamic>.from(industryList!.map((x) => x.toJson())),
  };
}

class IndustryList {
  dynamic id;
  String? industryPreferences;
  String? industryImg;
  DateTime? createdAt;
  DateTime? updatedAt;

  IndustryList({
    this.id,
    this.industryPreferences,
    this.industryImg,
    this.createdAt,
    this.updatedAt,
  });

  factory IndustryList.fromJson(Map<String, dynamic> json) => IndustryList(
    id: json["id"],
    industryPreferences: json["industry_preferences"],
    industryImg: json["industry_img"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "industry_preferences": industryPreferences,
    "industry_img": industryImg,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
