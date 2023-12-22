// To parse this JSON data, do
//
//     final selectIndustryModel = selectIndustryModelFromJson(jsonString);

import 'dart:convert';

SelectIndustryModel selectIndustryModelFromJson(String str) => SelectIndustryModel.fromJson(json.decode(str));

String selectIndustryModelToJson(SelectIndustryModel data) => json.encode(data.toJson());

class SelectIndustryModel {
  bool? status;
  List<Industries>? industries;

  SelectIndustryModel({
    this.status,
    this.industries,
  });

  factory SelectIndustryModel.fromJson(Map<String, dynamic> json) => SelectIndustryModel(
    status: json["status"],
    industries: json["industris"] == null ? json["industris"] : List<Industries>.from(json["industris"].map((x) => Industries.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "industris": List<dynamic>.from(industries!.map((x) => x.toJson())),
  };
}

class Industries {
  dynamic id;
  String? industryPreferences;
  DateTime? createdAt;
  DateTime? updatedAt;

  Industries({
    this.id,
    this.industryPreferences,
    this.createdAt,
    this.updatedAt,
  });

  factory Industries.fromJson(Map<String, dynamic> json) => Industries(
    id: json["id"],
    industryPreferences: json["industry_preferences"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "industry_preferences": industryPreferences,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
