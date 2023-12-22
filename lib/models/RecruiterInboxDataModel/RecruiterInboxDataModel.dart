class RecruiterInboxDataModel {
  RecruiterInboxDataModel({
     this.status,
     this.message,
     this.recruiterInboxData,
  });
   bool ?status;
   String ?message;
   List<RecruiterInboxData> ?recruiterInboxData;

  RecruiterInboxDataModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    recruiterInboxData = List.from(json['recruiter_inbox_data']).map((e)=>RecruiterInboxData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['recruiter_inbox_data'] = recruiterInboxData!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class RecruiterInboxData {
  RecruiterInboxData({
     this.id,
     this.seekerId,
     this.recruiterId,
     this.jobId,
     this.description,
     this.type,
     this.createdAt,
     this.updatedAt,
     this.seekerProfile,
     this.comDet,
  });
   int ?id;
   int ?seekerId;
   int ?recruiterId;
   int ?jobId;
   String ?description;
   int ?type;
   String ?createdAt;
   String ?updatedAt;
   SeekerProfile ?seekerProfile;
   ComDet ?comDet;

  RecruiterInboxData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    recruiterId = json['recruiter_id'];
    jobId = json['job_id'];
    description = json['description'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    seekerProfile = SeekerProfile.fromJson(json['seeker_profile']);
    // comDet = ComDet.fromJson(json['com_det']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['recruiter_id'] = recruiterId;
    _data['job_id'] = jobId;
    _data['description'] = description;
    _data['type'] = type;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['seeker_profile'] = seekerProfile!.toJson();
    _data['com_det'] = comDet!.toJson();
    return _data;
  }
}

class SeekerProfile {
  SeekerProfile({
     this.id,
     this.profileImg,
     this.shortVideo,
     this.fullname,
     this.email,
     this.password,
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
     this.createdAt,
     this.updatedAt,
  });
   int ?id;
   String ?profileImg;
   String ?shortVideo;
   String ?fullname;
   String ?email;
   String ?password;
   String ?mobile;
   String ?location;
   String ?aboutMe;
   String ?documentType;
  late final String? documentImg;
  String ?resume;
  late final Null totalExperience;
  String ?referralCode;
  late final String? referralBy;
  late final String? currentAmount;
   String ?status;
   int ?staupType;
  late final int? resetPassOtp;
  late final String? resetPassOtpTime;
  late final Null googleId;
   String ?createdAt;
   String ?updatedAt;

  SeekerProfile.fromJson(Map<String, dynamic> json){
    id = json['id'];
    profileImg = json['profile_img'];
    shortVideo = json['short_video'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    location = json['location'];
    aboutMe = json['about_me'];
    documentType = json['document_type'];
    documentImg = null;
    resume = json['resume'];
    totalExperience = null;
    referralCode = json['referral_code'];
    referralBy = null;
    currentAmount = null;
    status = json['status'];
    staupType = json['staup_type'];
    resetPassOtp = null;
    resetPassOtpTime = null;
    googleId = null;
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
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class ComDet {
  ComDet({
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
     this.createdAt,
     this.updatedAt,
  });
   int ?id;
   String ?fullname;
   String ?email;
   String ?password;
  late final Null mobile;
   String ?referralBy;
   String ?status;
   int ?resumeStep;
  late final Null resetPassOtp;
  late final Null resetPassOtpTime;
  late final Null googleId;
  late final Null companyEmail;
  late final Null companyVerifyOtp;
  String ?createdAt;
   String ?updatedAt;

  ComDet.fromJson(Map<String, dynamic> json){
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}