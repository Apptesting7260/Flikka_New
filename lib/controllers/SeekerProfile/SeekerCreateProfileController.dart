
import 'dart:convert';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class SeekerCreateProfileController extends GetxController {


  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  var errorMessage = ''.obs ;
  var imageErrorMessage = ''.obs ;
  var cvErrorMessage = ''.obs ;
  var documentErrorMessage = ''.obs ;
  var languageErrorMessage = ''.obs ;
  var selectStartDateExperienceErrorMessage = ''.obs ;
  var selectStartDateEducationErrorMessage = ''.obs ;
  var phoneNumberErrorMessage = ''.obs ;

  createProfileApi (
      String? videoPath ,
      String? profilePath ,
      String? resumePath ,
      String? documentPath,
      var  name ,
      var  location ,
      var phone ,
      var  aboutMe ,
      List?  workExperience ,
      List?  education ,
      List?  language ,
      List?  appreciation ,
      var documentType,
      var fresher

      ) async {
    try {
      print(profilePath) ;
      print(workExperience);
      loading(true) ;
      var url = Uri.parse(AppUrl.seekerCreateProfile) ;
      print(url) ;
      var sp = await SharedPreferences.getInstance() ;
      var request = http.MultipartRequest('POST' , url ) ;

      final formData = {} ;
      formData.addIf(name != null , "name" , name) ;
      formData.addIf(location != null , "location" , location) ;
      formData.addIf(aboutMe != null && aboutMe.toString().isNotEmpty, 'about_me', aboutMe) ;
      formData.addIf(workExperience != null && workExperience.length != 0, 'work_exp_job', jsonEncode(workExperience)) ;
      formData.addIf(education != null && education.length != 0, 'education_level', jsonEncode(education)) ;
      formData.addIf(language != null && language.length != 0, 'language', jsonEncode(language)) ;
      formData.addIf(appreciation != null && appreciation.length != 0, 'appreciation', jsonEncode(appreciation)) ;
      formData.addIf(documentType != null && documentPath != null && documentPath.length != 0  && documentType.toString().isNotEmpty, 'document_type', jsonEncode(documentType)) ;
      formData.addIf(fresher != null && fresher.toString().isNotEmpty, 'fresher', jsonEncode(fresher)) ;
      formData.addIf(phone != null && phone.toString().isNotEmpty, 'mobile', phone) ;

      debugPrint("this is formdata ======== $formData") ;
      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      if( profilePath != null && profilePath.isNotEmpty) { request.files.add(await http.MultipartFile.fromPath("profile_img" , profilePath )) ; }
      if( videoPath != null && videoPath.isNotEmpty) { request.files.add(await http.MultipartFile.fromPath("short_video" , videoPath )) ; }
      if( resumePath != null && resumePath.isNotEmpty) {  request.files.add(await http.MultipartFile.fromPath("resume" , resumePath )) ; }
      if( documentPath != null && documentPath.isNotEmpty) { request.files.add(await http.MultipartFile.fromPath("document_img" , documentPath )) ; }
      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}" ;
      var response = await request.send() ;
      print(response.statusCode) ;
      print(request.files) ;
      print(request.fields) ;
      var responded = await http.Response.fromStream(response) ;
      print(response.statusCode) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        if (kDebugMode) {
          print(responseData) ;
        }
        sp.setString("loggedIn", "seeker") ;
        sp.setInt("step", 4) ;
        Get.offAll(const TabScreen(index: 4));
      }
     if(response.statusCode == 401) {
       sp.clear() ;
       Get.offAll( () => const Login()) ;
      }
      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      if (kDebugMode) {
        print(e.toString()) ;
        print(stackTrace) ;
      }
    }
  }

}