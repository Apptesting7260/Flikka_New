
import 'dart:convert';
import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Job Seeker/Authentication/login.dart';
import '../../res/app_url.dart';
import 'package:http/http.dart' as http;

class CreateUpdateRecruiterProfileController extends GetxController {

  RxBool loading = false.obs;
  var errorMessage = ''.obs ;
  var profileImageError = ''.obs ;
  var coverImageError = ''.obs ;
  var industryError = ''.obs ;
  var companySizeError = ''.obs ;
  var foundedError = ''.obs ;

  createUpdateRecruiterProfileApi ({
    String? profilePath,
    String? coverPath,
    var companyName,
    var companyLocation,
    var addBio,
     // var homeDescription,
    var websiteLink,
    var aboutDescription,
    var industry,
    var companySize,
    var founded,
    var specialties,
    var contactPerson,
  } ) async {
    try {
      if (kDebugMode) {
        print("This is founded ======= $founded") ;
      }
      loading(true) ;
      var url = Uri.parse(AppUrl.CreateUpdateRecruiterProfileUrl) ;
      var request = http.MultipartRequest('POST' , url ) ;
      request.fields.addIf(companyName != null && companyName.toString().length != 0, "company_name", companyName) ;
      request.fields.addIf(companyLocation != null && companyLocation.toString().length != 0,  "company_location", companyLocation) ;
      request.fields.addIf(addBio != null && addBio.toString().length != 0,   "add_bio", addBio) ;
      request.fields.addIf(websiteLink != null && websiteLink.toString().length != 0,   "website_link", websiteLink) ;
      request.fields.addIf(aboutDescription != null && aboutDescription.toString().length != 0,   "about_description", aboutDescription) ;
      request.fields.addIf(industry != null && industry.toString().length != 0,   "industry", industry.toString()) ;
      request.fields.addIf(companySize != null && companySize.toString().length != 0,   "company_size", companySize.toString()) ;
      request.fields.addIf(founded != null && founded.toString().length != 0,   "founded", founded.toString()) ;
      request.fields.addIf(specialties != null && specialties.toString().length != 0,   "specialties", specialties) ;
      request.fields.addIf(contactPerson != null && contactPerson.toString().length != 0,   "contact_person", contactPerson) ;
      if (kDebugMode) {
        print("This is field data==================\n${request.fields}") ;
      }
      if(profilePath != null && profilePath.length != 0) {
        request.files.add(await http.MultipartFile.fromPath("profile_img" , profilePath)) ;
      }
      if(coverPath != null && coverPath.length != 0) {
        request.files.add(await http.MultipartFile.fromPath("cover_img" , coverPath )) ;
      }
      SharedPreferences sp = await SharedPreferences.getInstance();
      request.headers["Authorization"] =" Bearer ${sp.getString("BarrierToken")}";
      var response = await request.send() ;
      print(response.statusCode) ;
      print(request.files) ;
      print(request.fields) ;
      var responded = await http.Response.fromStream(response) ;
      var responseData = jsonDecode(responded.body) ;
      if(response.statusCode == 200) {
        print(responseData) ;
        sp.setString("loggedIn", "recruiter") ;
        sp.setInt("step", 2) ;
        Get.offAll(TabScreenEmployer(index: 4,));
      } if(response.statusCode == 401) {
        sp.clear() ;
        Get.offAll( () => const Login());
      }
      else {
          errorMessage.value = responseData["message"] ;
      }

      loading(false) ;
    } catch ( e, stackTrace) {
      loading(false) ;
      print(e.toString()) ;
      print(stackTrace) ;
    }
  }

}


