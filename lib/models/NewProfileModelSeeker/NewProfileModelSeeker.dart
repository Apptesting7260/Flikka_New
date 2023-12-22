class ProfileModelSeeker {
  ProfileModelSeeker({
    this.status,
    this.CompliteProfile,
    this.seekerInfo,
    this.seekerDtls,
    this.workExpJob,
    this.educationLevel,
    this.message,
  });
  var status;
  var CompliteProfile;
  SeekerInfo? seekerInfo;
  SeekerDtls? seekerDtls;
  List<WorkExpJob> ?workExpJob;
  List<EducationLevel> ?educationLevel;
  var message;

  ProfileModelSeeker.fromJson(Map<String, dynamic> json){
    status = json['status'];
    CompliteProfile = json['Complite_Profile'];
    seekerInfo = json['Seeker_info'] == null ? json['Seeker_info'] : SeekerInfo.fromJson(json['Seeker_info']);
    seekerDtls = json['seeker_dtls'] == null ? json['seeker_dtls'] : SeekerDtls.fromJson(json['seeker_dtls']);
    workExpJob = json['work_exp_job'] == null ? json['work_exp_job'] : List.from(json['work_exp_job']).map((e)=>WorkExpJob.fromJson(e)).toList();
    educationLevel = json['education_level'] == null ? json['education_level'] : List.from(json['education_level']).map((e)=>EducationLevel.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['Complite_Profile'] = CompliteProfile;
    _data['Seeker_info'] = seekerInfo!.toJson();
    _data['seeker_dtls'] = seekerDtls!.toJson();
    _data['work_exp_job'] = workExpJob!.map((e)=>e.toJson()).toList();
    _data['education_level'] = educationLevel!.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class SeekerInfo {
  SeekerInfo({
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
    this.documentLink,
    this.resumeLink,
  });
  var id;
  var profileImg;
  var shortVideo;
  var fullname;
  var email;
  var password;
  var mobile;
  var location;
  var aboutMe;
  var documentType;
  var documentImg;
  var resume;
  var totalExperience;
  var referralCode;
  var referralBy;
  var currentAmount;
  var status;
  var staupType;
  var resetPassOtp;
  var resetPassOtpTime;
  var googleId;
  var createdAt;
  var updatedAt;
  var documentLink;
  var resumeLink;

  SeekerInfo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    profileImg = json['profile_img'];
    shortVideo = json['short_video'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    mobile = null;
    location = json['location'];
    aboutMe = json['about_me'];
    documentType = json['document_type'];
    documentImg = json['document_img'];
    resume = json['resume'];
    totalExperience = null;
    referralCode = json['referral_code'];
    referralBy = null;
    currentAmount = json['current_amount'];
    status = json['status'];
    staupType = json['staup_type'];
    resetPassOtp = null;
    resetPassOtpTime = null;
    googleId = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documentLink = json['document_link'];
    resumeLink = json['resume_link'];
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
    _data['document_link'] = documentLink;
    _data['resume_link'] = resumeLink;
    return _data;
  }
}

class SeekerDtls {
  SeekerDtls({
    this.id,
    this.seekerId,
    this.position,
    this.minSalaryExpectation,
    this.maxSalaryExpectation,
    this.fresher,
    this.language,
    this.appreciation,
    this.createdAt,
    this.updatedAt,
    this.positions,
    this.skillName,
    this.passionName,
    this.industryPreferenceName,
    this.strengthsName,
    this.startWorkName,
    this.availabityName,
  });
  var id;
  var seekerId;
  var position;
  var minSalaryExpectation;
  var maxSalaryExpectation;
  var fresher;
  List<Language> ?language;
  var appreciation;
  var createdAt;
  var updatedAt;
  var positions;
  List<dynamic> ?skillName;
  List<dynamic> ?passionName;
  List<dynamic> ?industryPreferenceName;
  List<dynamic> ?strengthsName;
  List<dynamic> ?startWorkName;
  List<dynamic>? availabityName;

  SeekerDtls.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    position = json['position'];
    minSalaryExpectation = null;
    maxSalaryExpectation = null;
    fresher = null;
    language = json['language'] == null ? json['language'] : List.from(json['language']).map((e)=>Language.fromJson(e)).toList();
    appreciation = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    positions = json['positions'];
    skillName = json['skill_name'] == null ? json['skill_name'] : List.castFrom<dynamic, dynamic>(json['skill_name']);
    passionName = json['passion_name'] == null ? json['passion_name'] : List.castFrom<dynamic, dynamic>(json['passion_name']);
    industryPreferenceName = json['industry_preference_name'] == null ? json['industry_preference_name'] : List.castFrom<dynamic, dynamic>(json['industry_preference_name']);
    strengthsName = json['strengths_name'] == null ? json['strengths_name'] : List.castFrom<dynamic, dynamic>(json['strengths_name']);
    startWorkName = json['start_work_name'] == null ? json['start_work_name'] : List.castFrom<dynamic, dynamic>(json['start_work_name']);
    availabityName = json['availabity_name'] == null ? json['availabity_name'] : List.castFrom<dynamic, dynamic>(json['availabity_name']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['position'] = position;
    _data['min_salary_expectation'] = minSalaryExpectation;
    _data['max_salary_expectation'] = maxSalaryExpectation;
    _data['fresher'] = fresher;
    _data['language'] = language!.map((e)=>e.toJson()).toList();
    _data['appreciation'] = appreciation;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['positions'] = positions;
    _data['skill_name'] = skillName;
    _data['passion_name'] = passionName;
    _data['industry_preference_name'] = industryPreferenceName;
    _data['strengths_name'] = strengthsName;
    _data['start_work_name'] = startWorkName;
    _data['availabity_name'] = availabityName;
    return _data;
  }
}

class Language {
  Language({
    this.id,
    this.languages,
  });
  var id;
  var languages;

  Language.fromJson(Map<String, dynamic> json){
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

class WorkExpJob {
  WorkExpJob({
    this.workExpJob,
    this.companyName,
    this.jobStartDate,
    this.jobEndDate,
    this.present,
  });
  var workExpJob;
  var companyName;
  var jobStartDate;
  var jobEndDate;
  var present;

  WorkExpJob.fromJson(Map<String, dynamic> json){
    workExpJob = json['work_exp_job'];
    companyName = json['company_name'];
    jobStartDate = json['job_start_date'];
    jobEndDate = json['job_end_date'];
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['work_exp_job'] = workExpJob;
    _data['company_name'] = companyName;
    _data['job_start_date'] = jobStartDate;
    _data['job_end_date'] = jobEndDate;
    _data['present'] = present;
    return _data;
  }
}

class EducationLevel {
  EducationLevel({
    this.educationLevel,
    this.institutionName,
    this.educationStartDate,
    this.educationEndDate,
    this.present,
  });
  var educationLevel;
  var institutionName;
  var educationStartDate;
  var educationEndDate;
  var present;

  EducationLevel.fromJson(Map<String, dynamic> json){
    educationLevel = json['education_level'];
    institutionName = json['institution_name'];
    educationStartDate = json['education_start_date'];
    educationEndDate = json['education_end_date'];
    present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['education_level'] = educationLevel;
    _data['institution_name'] = institutionName;
    _data['education_start_date'] = educationStartDate;
    _data['education_end_date'] = educationEndDate;
    _data['present'] = present;
    return _data;
  }
}