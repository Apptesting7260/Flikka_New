class OnboardingModel {
  OnboardingModel({
     this.status,
     this.appliedSeeker,
  });
   bool? status;
   List<AppliedSeeker>? appliedSeeker;

  OnboardingModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    appliedSeeker = List.from(json['applied_seeker']).map((e)=>AppliedSeeker.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['applied_seeker'] = appliedSeeker!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AppliedSeeker {
  AppliedSeeker({
     this.id,
     this.seekerId,
     this.jobId,
     this.status,
     this.interviewStatus,
     this.seekerlist,
     this.jobsData,
  });
    int? id;
    int? seekerId;
    int? jobId;
    String? status;
    String? interviewStatus;
    Seekerlist? seekerlist;
    JobsData? jobsData;

  AppliedSeeker.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    jobId = json['job_id'];
    status = json['status'];
    interviewStatus = json['interview_status'];
    seekerlist = Seekerlist.fromJson(json['seekerlist']);
    jobsData = JobsData.fromJson(json['jobs_data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['job_id'] = jobId;
    _data['status'] = status;
    _data['interview_status'] = interviewStatus;
    _data['seekerlist'] = seekerlist!.toJson();
    _data['jobs_data'] = jobsData!.toJson();
    return _data;
  }
}

class Seekerlist {
  Seekerlist({
     this.id,
     this.fullname,
     this.profileImg,
     this.location,
  });
   int? id;
   String? fullname;
   String? profileImg;
   String? location;

  Seekerlist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullname = json['fullname'];
    profileImg = json['profile_img'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullname'] = fullname;
    _data['profile_img'] = profileImg;
    _data['location'] = location;
    return _data;
  }
}

class JobsData {
  JobsData({
     this.id,
     this.jobTitle,
     this.jobPosition,
     this.jobPositions,
  });
   int? id;
   String? jobTitle;
   String? jobPosition;
   String? jobPositions;

  JobsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    jobTitle = json['job_title'];
    jobPosition = json['job_position'];
    jobPositions = json['job_positions'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['job_title'] = jobTitle;
    _data['job_position'] = jobPosition;
    _data['job_positions'] = jobPositions;
    return _data;
  }
}