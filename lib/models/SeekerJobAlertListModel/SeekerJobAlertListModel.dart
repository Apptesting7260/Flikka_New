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
     this.positions,
     this.createdAt,
     this.updatedAt,
     this.newAlerts,
     this.location,
  });
  dynamic id;
   String? positions;
   String? createdAt;
   String? updatedAt;
   int? newAlerts;
   String? location;

  JobAlertList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    positions = json['positions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    newAlerts = json['new_alerts'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['positions'] = positions;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['new_alerts'] = newAlerts;
    _data['location'] = location;
    return _data;
  }
}