// To parse this JSON data, do
//
//     final forumCommentsModel = forumCommentsModelFromJson(jsonString);

import 'dart:convert';

ForumCommentsModel forumCommentsModelFromJson(String str) => ForumCommentsModel.fromJson(json.decode(str));

String forumCommentsModelToJson(ForumCommentsModel data) => json.encode(data.toJson());

class ForumCommentsModel {
  bool? status;
  String? message;
  List<SeekerComment>? seekerComment;

  ForumCommentsModel({
    this.status,
    this.message,
    this.seekerComment,
  });

  factory ForumCommentsModel.fromJson(Map<String, dynamic> json) => ForumCommentsModel(
    status: json["status"],
    message: json["message"],
    seekerComment: json["seeker_comment"] == null ? json["seeker_comment"] : List<SeekerComment>.from(json["seeker_comment"].map((x) => SeekerComment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "seeker_comment": List<dynamic>.from(seekerComment!.map((x) => x.toJson())),
  };
}

class SeekerComment {
  dynamic id;
  dynamic forumId;
  dynamic seekerId;
  String? name ;
  String? img ;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  SeekerComment({
    this.id,
    this.forumId,
    this.seekerId,
    this.comment,
    this.name,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerComment.fromJson(Map<String, dynamic> json) => SeekerComment(
    id: json["id"],
    forumId: json["forum_id"],
    seekerId: json["seeker_id"],
    comment: json["comment"],
    name: json["seeker_name"],
    img: json["seeker_img"],
    createdAt: json["created_at"] == null ? json["created_at"] : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? json["updated_at"] : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "forum_id": forumId,
    "seeker_id": seekerId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
