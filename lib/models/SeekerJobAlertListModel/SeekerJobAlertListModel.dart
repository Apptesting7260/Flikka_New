class SeekerJobAlertListModel {
  SeekerJobAlertListModel({
     this.status,
     this.jobAlertList,
  });
   bool? status;
   List<JobAlertList>? jobAlertList;

  SeekerJobAlertListModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    jobAlertList = json['job_alert_list'] == null ? json['job_alert_list'] : List.from(json['job_alert_list']).map((e)=>JobAlertList.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['job_alert_list'] = jobAlertList!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class JobAlertList {
  JobAlertList({
     this.id,
     this.seekerId,
     this.positionId,
    this.companyId,
     this.createdAt,
     this.updatedAt,
    this.companeName,
    this.companyImage,
    this.companyLocation,
     this.positions,
  });
   dynamic id;
   dynamic seekerId;
   List<String>? positionId;
   dynamic companyId;
   String? createdAt;
   String? updatedAt;
   String? companeName;
   String? companyImage;
   String? companyLocation;
   List<String>? positions;

  JobAlertList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    positionId = List.castFrom<dynamic, String>(json['position_id']);
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companeName = json['compane_name'];
    companyImage = json['compane_img'];
    companyLocation = json['company_location'];
    positions = List.castFrom<dynamic, String>(json['positions']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['position_id'] = positionId;
    _data['company_id'] = companyId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['compane_name'] = companeName;
    _data['positions'] = positions;
    return _data;
  }
}