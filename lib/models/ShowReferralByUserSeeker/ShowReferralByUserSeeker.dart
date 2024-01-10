class ShowReferralByUserModel {
  ShowReferralByUserModel({
     this.status,
     this.referralCode,
     this.appReferralAmount,
     this.employmentReferralAmount,
     this.subscriptionReferralAmount,
     this.totalAmount,
     this.bankAccount,
     this.appReferrrals,
     this.employmentReferrals,
  });
   bool?  status;
   String? referralCode;
   dynamic appReferralAmount;
   dynamic employmentReferralAmount;
   dynamic subscriptionReferralAmount;
   dynamic totalAmount;
   bool? bankAccount;
   AppReferrrals? appReferrrals;
   List<EmploymentReferrals>? employmentReferrals;

  ShowReferralByUserModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    referralCode = json['referral_code'];
    appReferralAmount = json['app_referral_amount'];
    employmentReferralAmount = json['employment_referral_amount'];
    subscriptionReferralAmount = json['subscription_referral_amount'];
    totalAmount = json['total_amount'];
    bankAccount = json['bank_account'];
    appReferrrals = json['app_referrrals'] == null ? json['app_referrrals'] : AppReferrrals.fromJson(json['app_referrrals']);
    employmentReferrals = json['employment_referrals'] == null ? json['employment_referrals'] : List.from(json['employment_referrals']).map((e)=>EmploymentReferrals.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['referral_code'] = referralCode;
    _data['total_amount'] = totalAmount;
    _data['bank_account'] = bankAccount;
    _data['app_referrrals'] = appReferrrals!.toJson();
    _data['employment_referrals'] = employmentReferrals!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AppReferrrals {
  AppReferrrals({
     this.seekerReferrals,
     this.recruiterReferrals,
  });
    List<SeekerReferrals>? seekerReferrals;
    List<RecruiterReferrals>? recruiterReferrals;

  AppReferrrals.fromJson(Map<String, dynamic> json){
    seekerReferrals = json['seeker_referrals'] == null ? json['seeker_referrals'] : List.from(json['seeker_referrals']).map((e)=>SeekerReferrals.fromJson(e)).toList();
    recruiterReferrals = json['recruiter_referrals'] == null ? json['recruiter_referrals'] : List.from(json['recruiter_referrals']).map((e)=>RecruiterReferrals.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['seeker_referrals'] = seekerReferrals!.map((e)=>e.toJson()).toList();
    _data['recruiter_referrals'] = recruiterReferrals!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SeekerReferrals {
  SeekerReferrals({
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
     this.currentAmount,
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
   String? countryCode;
   String? mobile;
   String? location;
   String? aboutMe;
   String? documentType;
   String? documentImg;
   String? resume;
   String? totalExperience;
   String? referralCode;
   String? referralBy;
   String? currentAmount;
   String? status;
   dynamic staupType;
   String? resetPassOtp;
   String? resetPassOtpTime;
   String? googleId;
   String? deviceToken;
   String? createdAt;
   String? updatedAt;

  SeekerReferrals.fromJson(Map<String, dynamic> json){
    id = json['id'];
    profileImg = json['profile_img'];
    shortVideo = null;
    fullname = json['fullname'];
    email = json['email'];
    password = null;
    countryCode = null;
    mobile = null;
    location = null;
    aboutMe = null;
    documentType = null;
    documentImg = null;
    resume = null;
    totalExperience = null;
    referralCode = json['referral_code'];
    referralBy = json['referral_by'];
    currentAmount = null;
    status = json['status'];
    staupType = json['staup_type'];
    resetPassOtp = null;
    resetPassOtpTime = null;
    googleId = null;
    deviceToken = null;
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
    _data['current_amount'] = currentAmount;
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

class RecruiterReferrals {
  RecruiterReferrals({
     this.id,
     this.fullname,
     this.email,
     this.password,
    this.mobile,
     this.referralBy,
     this.status,
     this.resumeStep,
    this.resetPassOtp,
    this.resetPassOtpTime,
    this.googleId,
    this.companyEmail,
    this.companyVerifyOtp,
    this.deviceToken,
     this.createdAt,
     this.updatedAt,
    this.recruiterdetails,
    this.companyName,
  });
   dynamic id;
   String? fullname;
   String? email;
   String? password;
   String? mobile;
   String? referralBy;
   String? status;
   dynamic resumeStep;
   String? resetPassOtp;
   String? resetPassOtpTime;
   String? googleId;
   String? companyEmail;
   String? companyVerifyOtp;
   String? deviceToken;
   String? createdAt;
   String? updatedAt;
   String? recruiterdetails;
   String? companyName;

  RecruiterReferrals.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    mobile = null;
    referralBy = json['referral_by'];
    status = json['status'];
    resumeStep = json['resume_step'];
    resetPassOtp = null;
    resetPassOtpTime = null;
    googleId = null;
    companyEmail = null;
    companyVerifyOtp = null;
    deviceToken = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    recruiterdetails = null;
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['password'] = password;
    _data['mobile'] = mobile;
    _data['referral_by'] = referralBy;
    _data['status'] = status;
    _data['resume_step'] = resumeStep;
    _data['reset_pass_otp'] = resetPassOtp;
    _data['reset_pass_otp_time'] = resetPassOtpTime;
    _data['google_id'] = googleId;
    _data['company_email'] = companyEmail;
    _data['company_verify_otp'] = companyVerifyOtp;
    _data['device_token'] = deviceToken;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['recruiterdetails'] = recruiterdetails;
    return _data;
  }
}

class EmploymentReferrals {
  EmploymentReferrals({
     this.id,
     this.seekerId,
     this.jobId,
     this.status,
     this.fullName,
     this.interviewScheduleTime,
     this.interviewStatus,
     this.referralByJob,
    this.referralAmount,
    this.interviewLink,
     this.requestType,
    this.recruiterOngoing,
    this.seekerOngoing,
    this.interviewDoneByRecruiter,
    this.interviewDoneBySeeker,
    this.interviewDeclineReasonByRecruiter,
    this.interviewDeclineReasonBySeeker,
     this.createdAt,
     this.updatedAt,
    this.deletedAt,
  });
   dynamic id;
   dynamic seekerId;
   dynamic jobId;
   String? status;
   String? fullName;
   String? interviewScheduleTime;
   String? interviewStatus;
   String? referralByJob;
   String? referralAmount;
   String? interviewLink;
   String? requestType;
   String? recruiterOngoing;
   String? seekerOngoing;
   String? interviewDoneByRecruiter;
   String? interviewDoneBySeeker;
   String? interviewDeclineReasonByRecruiter;
   String? interviewDeclineReasonBySeeker;
   String? createdAt;
   String? updatedAt;
   String? deletedAt;

  EmploymentReferrals.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    jobId = json['job_id'];
    status = json['status'];
    fullName = json['fullname'];
    interviewScheduleTime = json['interview_schedule_time'];
    interviewStatus = json['interview_status'];
    referralByJob = json['referral_by_job'];
    referralAmount = null;
    interviewLink = null;
    requestType = json['request_type'];
    recruiterOngoing = null;
    seekerOngoing = null;
    interviewDoneByRecruiter = null;
    interviewDoneBySeeker = null;
    interviewDeclineReasonByRecruiter = null;
    interviewDeclineReasonBySeeker = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
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
    _data['referral_amount'] = referralAmount;
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
    return _data;
  }
}