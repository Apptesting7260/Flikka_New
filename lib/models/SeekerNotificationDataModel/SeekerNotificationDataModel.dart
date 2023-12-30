class SeekerNotificationDataModel {
  SeekerNotificationDataModel({
     this.status,
     this.message,
     this.seekerNotification,
    this.unseenNotification,
  });
   bool ?status;
   String ?message;
   dynamic unseenNotification ;
   List<SeekerNotification> ?seekerNotification;

  SeekerNotificationDataModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    unseenNotification = json["unseen_notification"];
    seekerNotification = json['seeker_notification'] == null ? json['seeker_notification'] :  List.from(json['seeker_notification']).map((e)=>SeekerNotification.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['seeker_notification'] = seekerNotification!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SeekerNotification {
  SeekerNotification({
     this.id,
     this.seekerId,
     this.recruiterId,
     this.jobId,
     this.description,
     this.type,
     this.createdAt,
     this.updatedAt,
     this.chat,
     this.companyName,
     this.jobFeatureImg,
     this.jobTitle,
     this.jobPosition,
  });
   dynamic id;
  dynamic seekerId;
   dynamic recruiterId;
  dynamic jobId;
  dynamic description;
  dynamic type;
   String ?createdAt;
   String ?updatedAt;
    bool ?chat;
   String ?companyName;
   String ?jobFeatureImg;
  String ?jobTitle;
   String ?jobPosition;

  SeekerNotification.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    recruiterId = json['recruiter_id'];
    jobId = json['job_id'];
    description = json['description'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    chat = json['chat'];
    companyName = json['company_name'];
    jobFeatureImg = json['job_feature_img'];
    jobTitle = json['job_title'];
    jobPosition = json['job_position'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['seeker_id'] = seekerId;
    data['recruiter_id'] = recruiterId;
    data['job_id'] = jobId;
    data['description'] = description;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['chat'] = chat;
    data['company_name'] = companyName;
    data['job_feature_img'] = jobFeatureImg;
    data['job_title'] = jobTitle;
    data['job_position'] = jobPosition;
    return data;
  }
}