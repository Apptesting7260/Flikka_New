import 'dart:convert';

import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';

SeekerViewInterviewModel scheduledInterviewListModelFromJson(String str) => SeekerViewInterviewModel.fromJson(json.decode(str));

String scheduledInterviewListModelToJson(SeekerViewInterviewModel data) => json.encode(data.toJson());

// class SeekerViewInterviewModel {
//   SeekerViewInterviewModel({
//      this.status,
//      this.unSeenPendingInterview,
//      this.message,
//      this.interviewSchedule,
//   });
//    bool ?status;
//    dynamic unSeenPendingInterview;
//    String ?message;
//    List<Seeker> ?interviewSchedule;
//
//   SeekerViewInterviewModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     unSeenPendingInterview = json['unseen_pending_interview'];
//     message = json['message'];
//     interviewSchedule = json['interview_schedule'] == null ? json['interview_schedule'] : List.from(json['interview_schedule']).map((e)=>Seeker.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['message'] = message;
//     _data['interview_schedule'] = interviewSchedule!.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class InterviewSchedule {
//   InterviewSchedule({
//      this.id,
//      this.seekerId,
//      this.jobId,
//      this.status,
//      this.interviewScheduleTime,
//      this.interviewStatus,
//      this.interviewLink,
//      this.requestType,
//      this.isNewInterview,
//      this.createdAt,
//      this.updatedAt,
//   });
//    dynamic id;
//    dynamic seekerId;
//    dynamic jobId;
//    String ?status;
//    DateTime? interviewScheduleTime;
//    String ?interviewStatus;
//    String ?interviewLink;
//    String ?requestType;
//    bool? isNewInterview;
//    dynamic createdAt;
//    dynamic updatedAt;
//
//   InterviewSchedule.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     seekerId = json['seeker_id'];
//     jobId = json['job_id'];
//     status = json['status'];
//     interviewScheduleTime = json['interview_schedule_time'];
//     interviewStatus = json['interview_status'];
//     interviewLink = json['interview_link'];
//     requestType = json['request_type'];
//     isNewInterview = json['is_new_interview'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['seeker_id'] = seekerId;
//     _data['job_id'] = jobId;
//     _data['status'] = status;
//     _data['interview_schedule_time'] = interviewScheduleTime;
//     _data['interview_status'] = interviewStatus;
//     _data['interview_link'] = interviewLink;
//     _data['request_type'] = requestType;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

class SeekerViewInterviewModel {
  SeekerViewInterviewModel({
    this.status,
     this.unseenPendingInterview,
     this.message,
     this.interviewSchedule,
  });
   bool? status;
  dynamic unseenPendingInterview;
   String? message;
   List<InterviewSchedule>? interviewSchedule;

  SeekerViewInterviewModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    unseenPendingInterview = json['unseen_pending_interview'];
    message = json['message'];
    interviewSchedule = json['interview_schedule'] == null ? json['interview_schedule'] : List.from(json['interview_schedule']).map((e)=>InterviewSchedule.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['unseen_pending_interview'] = unseenPendingInterview;
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
    this.referralByJob,
     this.interviewLink,
     this.requestType,
    this.recruiterOngoing,
    this.seekerOngoing,
    this.interviewDoneByRecruiter,
    this.interviewDoneBySeeker,
    this.interviewDeclineReasonByRecruiter,
    this.interviewDeclineReasonBySeeker,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
     this.ongoing,
     this.isNewInterview,
     this.seekerlist,
     this.jobDetails,
  });
   dynamic id;
  dynamic seekerId;
  dynamic jobId;
   String? status;
  dynamic interviewScheduleTime;
   String? interviewStatus;
   dynamic referralByJob;
   String? interviewLink;
   String? requestType;
   dynamic recruiterOngoing;
  dynamic seekerOngoing;
  dynamic interviewDoneByRecruiter;
  dynamic interviewDoneBySeeker;
  dynamic interviewDeclineReasonByRecruiter;
  dynamic interviewDeclineReasonBySeeker;
   String? createdAt;
   String? updatedAt;
  dynamic deletedAt;
   bool? ongoing;
   bool? isNewInterview;
   Seekerlist? seekerlist;
   JobDetails? jobDetails;

  InterviewSchedule.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    jobId = json['job_id'];
    status = json['status'];
    interviewScheduleTime = json['interview_schedule_time'] == null ? json['interview_schedule_time'] : DateTime.parse(json['interview_schedule_time']);
    interviewStatus = json['interview_status'];
    interviewLink = json['interview_link'];
    requestType = json['request_type'];
    recruiterOngoing = json['recruiter_ongoing'] ;
    seekerOngoing = json['seeker_ongoing'] ;
    interviewDoneByRecruiter = json['interview_done_by_recruiter'] ;
    interviewDoneBySeeker = json['interview_done_by_seeker'] ;
    interviewDeclineReasonByRecruiter = json['interview_decline_reason_by_recruiter'] ;
    interviewDeclineReasonBySeeker = json['interview_decline_reason_by_seeker'] ;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ongoing = json['ongoing'];
    isNewInterview = json['is_new_interview'];
    seekerlist = json['seekerlist'] == null ? json['seekerlist'] : Seekerlist.fromJson(json['seekerlist']);
    jobDetails = json['job_details'] == null ? json['job_details'] : JobDetails.fromJson(json['job_details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['job_id'] = jobId;
    _data['status'] = status;
    _data['interview_schedule_time'] = interviewScheduleTime;
    _data['interview_status'] = interviewStatus;
    _data['referral_by_job'] = referralByJob;
    _data['interview_link'] = interviewLink;
    _data['request_type'] = requestType;
    _data['recruiter_ongoing'] = recruiterOngoing;
    _data['seeker_ongoing'] = seekerOngoing;
    _data['interview_done_by_recruiter'] = interviewDoneByRecruiter;
    _data['interview_done_by_seeker'] = interviewDoneBySeeker;
    _data['interview_decline_reason_by_recruiter'] = interviewDeclineReasonByRecruiter;
    _data['interview_decline_reason_by_seeker'] = interviewDeclineReasonBySeeker;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    _data['ongoing'] = ongoing;
    _data['is_new_interview'] = isNewInterview;
    _data['seekerlist'] = seekerlist!.toJson();
    _data['job_details'] = jobDetails!.toJson();
    return _data;
  }
}

class Seekerlist {
  Seekerlist({
     this.id,
     this.profileImg,
     this.shortVideo,
     this.fullname,
     this.email,
     this.password,
    this.countryCode,
     this.mobile,
     this.location,
     this.aboutMe,
     this.documentType,
     this.documentImg,
     this.resume,
    this.totalExperience,
     this.referralCode,
     this.referralBy,
     this.appReferalAmount,
     this.subscriptionAmount,
     this.employmentAmount,
     this.currentAmount,
     this.walletMessageSeenUnseen,
     this.status,
     this.staupType,
    this.resetPassOtp,
    this.resetPassOtpTime,
    this.googleId,
    this.deviceToken,
     this.createdAt,
     this.updatedAt,
  });
  dynamic id;
   String? profileImg;
   String? shortVideo;
   String? fullname;
   String? email;
   String? password;
  dynamic countryCode;
   String? mobile;
   String? location;
   String? aboutMe;
   String? documentType;
   String? documentImg;
   String? resume;
  dynamic totalExperience;
   String? referralCode;
   String? referralBy;
   int? appReferalAmount;
   int? subscriptionAmount;
   int? employmentAmount;
   int? currentAmount;
   int? walletMessageSeenUnseen;
   String? status;
   int? staupType;
  dynamic resetPassOtp;
  dynamic resetPassOtpTime;
  dynamic googleId;
  dynamic deviceToken;
   String? createdAt;
   String? updatedAt;

  Seekerlist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    profileImg = json['profile_img'];
    shortVideo = json['short_video'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    countryCode =json['country_code'];
    mobile = json['mobile'];
    location = json['location'];
    aboutMe = json['about_me'];
    documentType = json['document_type'];
    documentImg = json['document_img'];
    resume = json['resume'];
    referralCode = json['referral_code'];
    referralBy = json['referral_by'];
    appReferalAmount = json['app_referal_amount'];
    subscriptionAmount = json['subscription_amount'];
    employmentAmount = json['employment_amount'];
    currentAmount = json['current_amount'];
    walletMessageSeenUnseen = json['wallet_message_seen_unseen'];
    status = json['status'];
    staupType = json['staup_type'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['profile_img'] = profileImg;
    _data['short_video'] = shortVideo;
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['password'] = password;
    _data['country_code'] = countryCode;
    _data['mobile'] = mobile;
    _data['location'] = location;
    _data['about_me'] = aboutMe;
    _data['document_type'] = documentType;
    _data['document_img'] = documentImg;
    _data['resume'] = resume;
    _data['total_experience'] = totalExperience;
    _data['referral_code'] = referralCode;
    _data['referral_by'] = referralBy;
    _data['app_referal_amount'] = appReferalAmount;
    _data['subscription_amount'] = subscriptionAmount;
    _data['employment_amount'] = employmentAmount;
    _data['current_amount'] = currentAmount;
    _data['wallet_message_seen_unseen'] = walletMessageSeenUnseen;
    _data['status'] = status;
    _data['staup_type'] = staupType;
    _data['reset_pass_otp'] = resetPassOtp;
    _data['reset_pass_otp_time'] = resetPassOtpTime;
    _data['google_id'] = googleId;
    _data['device_token'] = deviceToken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class JobDetails {
  JobDetails({
     this.id,
     this.recruiterId,
     this.featureImg,
    this.shortVideo,
     this.jobTitle,
     this.jobPosition,
     this.specialization,
     this.jobLocation,
     this.description,
     this.requirements,
     this.employmentType,
     this.typeOfWorkplace,
     this.workExperience,
     this.preferredWorkExperience,
     this.education,
     this.language,
    this.deletedAt,
     this.createdAt,
     this.updatedAt,
     this.jobPositions,
     this.languageName,
     this.jobsDetail,
  });
  dynamic id;
  dynamic recruiterId;
   String? featureImg;
   String? shortVideo;
   String? jobTitle;
   String? jobPosition;
   String? specialization;
   String? jobLocation;
   String? description;
   String? requirements;
   String? employmentType;
   String? typeOfWorkplace;
   String? workExperience;
   String? preferredWorkExperience;
   String? education;
   String? language;
  dynamic deletedAt;
   String? createdAt;
   String? updatedAt;
   String? jobPositions;
   List<LanguageName>? languageName;
   JobsDetail? jobsDetail;

  JobDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    recruiterId = json['recruiter_id'];
    featureImg = json['feature_img'];
    shortVideo = null;
    jobTitle = json['job_title'];
    jobPosition = json['job_position'];
    specialization = json['specialization'];
    jobLocation = json['job_location'];
    description = json['description'];
    requirements = json['requirements'];
    employmentType = json['employment_type'];
    typeOfWorkplace = json['type_of_workplace'];
    workExperience = json['work_experience'];
    preferredWorkExperience = json['preferred_work_experience'];
    education = json['education'];
    language = json['language'];
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobPositions = json['job_positions'];
    languageName = json['language_name'] == null ? json['language_name'] : List.from(json['language_name']).map((e)=>LanguageName.fromJson(e)).toList();
    jobsDetail = json['jobs_detail'] == null ? json['jobs_detail'] : JobsDetail.fromJson(json['jobs_detail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['recruiter_id'] = recruiterId;
    _data['feature_img'] = featureImg;
    _data['short_video'] = shortVideo;
    _data['job_title'] = jobTitle;
    _data['job_position'] = jobPosition;
    _data['specialization'] = specialization;
    _data['job_location'] = jobLocation;
    _data['description'] = description;
    _data['requirements'] = requirements;
    _data['employment_type'] = employmentType;
    _data['type_of_workplace'] = typeOfWorkplace;
    _data['work_experience'] = workExperience;
    _data['preferred_work_experience'] = preferredWorkExperience;
    _data['education'] = education;
    _data['language'] = language;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['job_positions'] = jobPositions;
    _data['language_name'] = languageName!.map((e)=>e.toJson()).toList();
    _data['jobs_detail'] = jobsDetail!.toJson();
    return _data;
  }
}

class LanguageName {
  LanguageName({
     this.id,
     this.languages,
  });
  dynamic id;
   String? languages;

  LanguageName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    languages = json['languages'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['languages'] = languages;
    return _data;
  }
}

class JobsDetail {
  JobsDetail({
     this.id,
     this.jobId,
     this.recruiterId,
     this.minSalaryExpectation,
     this.maxSalaryExpectation,
     this.createdAt,
     this.updatedAt,
    this.deletedAt,
     this.skillName,
     this.passionName,
     this.industryPreferenceName,
     this.strengthsName,
     this.startWorkName,
     this.availabityName,
  });
  dynamic id;
  dynamic jobId;
  dynamic recruiterId;
   int? minSalaryExpectation;
   int? maxSalaryExpectation;
   String? createdAt;
   String? updatedAt;
  dynamic deletedAt;
   List<SkillName>? skillName;
   List<PassionName>? passionName;
   List<IndustryPreferenceName>? industryPreferenceName;
   List<StrengthsName>? strengthsName;
   List<StartWorkName>? startWorkName;
   List<AvailabityName>? availabityName;

  JobsDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    jobId = json['job_id'];
    recruiterId = json['recruiter_id'];
    minSalaryExpectation = json['min_salary_expectation'];
    maxSalaryExpectation = json['max_salary_expectation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
    skillName = json['skill_name'] == null ? json['skill_name'] : List.from(json['skill_name']).map((e)=>SkillName.fromJson(e)).toList();
    passionName = json['passion_name'] == null ? json['passion_name'] : List.from(json['passion_name']).map((e)=>PassionName.fromJson(e)).toList();
    industryPreferenceName = json['industry_preference_name'] == null ? json['industry_preference_name'] : List.from(json['industry_preference_name']).map((e)=>IndustryPreferenceName.fromJson(e)).toList();
    strengthsName = json['strengths_name'] == null ? json['strengths_name'] : List.from(json['strengths_name']).map((e)=>StrengthsName.fromJson(e)).toList();
    startWorkName = json['start_work_name'] == null ? json['start_work_name'] : List.from(json['start_work_name']).map((e)=>StartWorkName.fromJson(e)).toList();
    availabityName = json['availabity_name'] == null ? json['availabity_name'] : List.from(json['availabity_name']).map((e)=>AvailabityName.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['job_id'] = jobId;
    _data['recruiter_id'] = recruiterId;
    _data['min_salary_expectation'] = minSalaryExpectation;
    _data['max_salary_expectation'] = maxSalaryExpectation;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    _data['skill_name'] = skillName!.map((e)=>e.toJson()).toList();
    _data['passion_name'] = passionName!.map((e)=>e.toJson()).toList();
    _data['industry_preference_name'] = industryPreferenceName!.map((e)=>e.toJson()).toList();
    _data['strengths_name'] = strengthsName!.map((e)=>e.toJson()).toList();
    _data['start_work_name'] = startWorkName!.map((e)=>e.toJson()).toList();
    _data['availabity_name'] = availabityName!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SkillName {
  SkillName({
     this.id,
     this.skills,
  });
  dynamic id;
   String? skills;

  SkillName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    skills = json['skills'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['skills'] = skills;
    return _data;
  }
}

class PassionName {
  PassionName({
     this.id,
     this.passion,
  });
  dynamic id;
   String? passion;

  PassionName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    passion = json['passion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['passion'] = passion;
    return _data;
  }
}

class IndustryPreferenceName {
  IndustryPreferenceName({
     this.id,
     this.industryPreferences,
  });
  dynamic id;
   String? industryPreferences;

  IndustryPreferenceName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    industryPreferences = json['industry_preferences'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['industry_preferences'] = industryPreferences;
    return _data;
  }
}

class StrengthsName {
  StrengthsName({
     this.id,
     this.strengths,
  });
  dynamic id;
   String? strengths;

  StrengthsName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    strengths = json['strengths'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['strengths'] = strengths;
    return _data;
  }
}

class StartWorkName {
  StartWorkName({
     this.id,
     this.startWork,
  });
  dynamic id;
   String? startWork;

  StartWorkName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    startWork = json['start_work'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['start_work'] = startWork;
    return _data;
  }
}

class AvailabityName {
  AvailabityName({
     this.id,
     this.availabity,
  });
  dynamic id;
   String? availabity;

  AvailabityName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    availabity = json['availabity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['availabity'] = availabity;
    return _data;
  }
}