
import 'dart:convert';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import '../../utils/utils.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerProfileController extends GetxController {

  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxBool loadingImage = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
  RxString? positions  ;

  profileApi(
      String? profilePath ,
      String name ,
      String location ,
      var id ,
      BuildContext context
      ) async {
    try {
      if (kDebugMode) {
        print("called API");
      }
      loading.value = true;
      var sp = await SharedPreferences.getInstance();
      var url = profilePath == null ? Uri.parse(AppUrl.editSeekerProfile) : Uri
          .parse(AppUrl.editSeekerProfileImage);
      var request = http.MultipartRequest('POST', url);
      if (profilePath == null) {
        Map data = {
          'name': name,
          'location': location,
          'position_id': id,
        };
        print(data);
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }
      if (profilePath != null && profilePath.isNotEmpty) {
        print("inside image");
        loadingImage(true);
        request.files.add(
            await http.MultipartFile.fromPath("profile_img", profilePath));
      }

      request.headers["Authorization"] =
      "Bearer ${sp.getString("BarrierToken")}";
      var response = await request.send();
      var responded = await http.Response.fromStream(response);
      if (kDebugMode) {
        print(response.statusCode);
      }
      var responseData = jsonDecode(responded.body);
      if (response.statusCode == 200) {
        loading(false);
        loadingImage(false);
        seekerProfileController.viewSeekerProfileApi();
        Get.back();
        Utils.toastMessage('Profile updated') ;
        if (kDebugMode) {
          print(responseData['message']);
        }
      } if(response.statusCode == 401) {
        sp.clear() ;
        Get.offAll( () => const Login()) ;
      }
      loading(false);
      loadingImage(false);
    } catch (e) {
      loading(false);
      loadingImage(false);
      if (kDebugMode) {
        print(e.toString()) ;
      }
    }
  }
}