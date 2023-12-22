import 'dart:convert';

import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';

SeekerViewInterviewModel scheduledInterviewListModelFromJson(String str) => SeekerViewInterviewModel.fromJson(json.decode(str));

String scheduledInterviewListModelToJson(SeekerViewInterviewModel data) => json.encode(data.toJson());

class SeekerViewInterviewModel {
  SeekerViewInterviewModel({
     this.status,
     this.message,
     this.interviewSchedule,
  });
   bool ?status;
   String ?message;
   List<Seeker> ?interviewSchedule;

  SeekerViewInterviewModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    interviewSchedule = json['interview_schedule'] == null ? json['interview_schedule'] : List.from(json['interview_schedule']).map((e)=>Seeker.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['interview_schedule'] = interviewSchedule!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class InterviewSchedule {
  InterviewSchedule({
     this.id,
     this.seekerId,
     this.jobId,
     this.status,
     this.interviewScheduleTime,
     this.interviewStatus,
     this.interviewLink,
     this.requestType,
     this.createdAt,
     this.updatedAt,
  });
   dynamic id;
   dynamic seekerId;
   dynamic jobId;
   String ?status;
   DateTime? interviewScheduleTime;
   String ?interviewStatus;
   String ?interviewLink;
   String ?requestType;
   dynamic createdAt;
   dynamic updatedAt;

  InterviewSchedule.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    jobId = json['job_id'];
    status = json['status'];
    interviewScheduleTime = json['interview_schedule_time'];
    interviewStatus = json['interview_status'];
    interviewLink = json['interview_link'];
    requestType = json['request_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['job_id'] = jobId;
    _data['status'] = status;
    _data['interview_schedule_time'] = interviewScheduleTime;
    _data['interview_status'] = interviewStatus;
    _data['interview_link'] = interviewLink;
    _data['request_type'] = requestType;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}