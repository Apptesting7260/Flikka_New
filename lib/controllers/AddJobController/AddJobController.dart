import 'dart:convert';
import 'package:flikka/Job%20Recruiter/RecruiterRequiredSkills/required_skills.dart';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class AddJobController extends GetxController {


  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  var featureImageError = ''.obs ;
  var jobPositionErrorMessage = ''.obs ;
  var jobTypeErrorMessage = ''.obs ;
  var typeOfWorkPlaceErrorMessage = ''.obs ;
  var qualificationErrorMessage = '' .obs ;
  var languageErrorMessage = '' .obs ;

  addJobApi (
      String? videoPath ,
      String? profilePath ,
      var  position ,
      var  jobTitle ,
      var  specialization ,
      var  location ,
      var  description ,
      var  requirements ,
      var  jobType ,
      var  workplace ,
      String?  yearExperience ,
      String?  monthExperience ,
      var  preferredExperience ,
      var  qualification ,
      var  language ,

   { var jobId,
  RecruiterJobsData? recruiterJobsData
  }) async {
    try {
      debugPrint(jobType.toString());
      debugPrint("this is profile path =================$profilePath");
      loading(true) ;
      var url = Uri.parse(AppUrl.addUpdateJob) ;
      debugPrint(url.toString()) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      var formData = {} ;
      formData.addIf(jobTitle != null && jobTitle.toString().length != 0, "job_title", jobTitle) ;
      formData.addIf(position != null && position.toString().length != 0, "job_position", position) ;
      formData.addIf(specialization != null && specialization.toString().length != 0, "specialization", specialization) ;
      formData.addIf(location != null && location.toString().length != 0, "job_location", location) ;
      formData.addIf(description != null && description.toString().length != 0, "description", description) ;
      formData.addIf(jobType != null && jobType.toString().length != 0, "employment_type", jobType) ;
      formData.addIf(workplace != null && workplace.toString().length != 0, "type_of_workplace", workplace) ;
      formData.addIf(requirements != null && requirements.toString().length != 0, "requirements", requirements) ;
      formData.addIf(yearExperience != null && yearExperience.length != 0, "year_experience", yearExperience) ;
      formData.addIf(monthExperience != null && monthExperience.length != 0, "month_experience", monthExperience) ;
      formData.addIf(preferredExperience != null && preferredExperience.toString().length != 0, "preferred_work_experience", preferredExperience) ;
      formData.addIf(qualification != null && qualification.toString().length != 0, "education", qualification) ;
      formData.addIf(language != null && language.toString().length != 0, "language", jsonEncode(language)) ;
      formData.addIf(jobId != null && jobId.toString().length != 0, "job_id", jobId) ;

      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      if(profilePath != null && profilePath?.length != 0 ) {
        debugPrint("inside multipart") ;
      request.files.add(await http.MultipartFile.fromPath("feature_img" , profilePath)) ; }
      if(videoPath != null && videoPath?.length != 0) {
        debugPrint("inside multipart") ;
      request.files.add(await http.MultipartFile.fromPath("short_video" , videoPath)) ;
      }
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      debugPrint(response.statusCode.toString()) ;
      debugPrint(request.files.toString()) ;
      debugPrint(request.fields.toString()) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        debugPrint(responseData.toString()) ;
        submitted(true) ;
        if(recruiterJobsData != null) {
          print("called function 1") ;
          Get.to( () => RequiredSkills(recruiterJobsData: recruiterJobsData,) , arguments: {"job_id" : responseData["job_id"] });
        } else if (recruiterJobsData == null) {
        Get.to( () => const RequiredSkills() , arguments: {"job_id" : responseData["job_id"] }); }
      }
      if(response.statusCode == 401) {
        sp.clear() ;
        Get.offAll( () => const Login()) ;
      }
      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      debugPrint(e.toString()) ;
      debugPrint(stackTrace.toString()) ;
    }
  }

}