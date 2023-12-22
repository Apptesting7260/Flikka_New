class ViewJobFromNotification {
  ViewJobFromNotification({
     this.status,
     this.job,
    this.lat,
    this.long,
    this.isApplied,
  });
   bool? status;
   Job? job;
   bool? isApplied ;
   dynamic lat ;
   dynamic long ;

  ViewJobFromNotification.fromJson(Map<String, dynamic> json){
    status = json['status'];
    job = json['job'] == null ? json['job'] : Job.fromJson(json['job']);
    lat = json['lat'] ;
    long = json['long'] ;
    isApplied = json['is_applied'] ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['job'] = job!.toJson();
    return _data;
  }
}

class Job {
  Job({
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
   String? createdAt;
   String? updatedAt;
   String? jobPositions;
   List<LanguageName>? languageName;
   JobsDetail? jobsDetail;

  Job.fromJson(Map<String, dynamic> json){
    id = json['id'];
    recruiterId = json['recruiter_id'];
    featureImg = json['feature_img'];
    shortVideo = json["short_video"];
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
   dynamic minSalaryExpectation;
   dynamic maxSalaryExpectation;
   String ?createdAt;
   String ?updatedAt;
   List<SkillName> ?skillName;
   List<PassionName> ?passionName;
   List<IndustryPreferenceName> ?industryPreferenceName;
   List<StrengthsName> ?strengthsName;
   List<StartWorkName> ?startWorkName;
   List<AvailabityName> ?availabityName;

  JobsDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    jobId = json['job_id'];
    recruiterId = json['recruiter_id'];
    minSalaryExpectation = json['min_salary_expectation'];
    maxSalaryExpectation = json['max_salary_expectation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
   String ?skills;

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
   String ?passion;

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
   String ?industryPreferences;

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
   String ?strengths;

  StrengthsName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    strengths = json['strengths'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['strengths'] = strengths;
    return data;
  }
}

class StartWorkName {
  StartWorkName({
     this.id,
     this.startWork,
  });
   dynamic id;
   String ?startWork;

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
   String ?availabity;

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