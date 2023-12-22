
import 'dart:convert';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_url.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerResumeController extends GetxController {

  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxString errorMessage = "".obs ;
  RxString documentPath = "".obs ;
  RxString resumePath = "".obs ;
  RxString documentName = "".obs ;

  fileApi(
      String file ,
      bool resume,
    String? documentType
      ) async {
    try {
      debugPrint("hitting API") ;
      loading.value = true;
      var sp = await SharedPreferences.getInstance();
      var url = Uri.parse( resume ? AppUrl.editSeekerResume : AppUrl.editSeekerDocument);
      var request = http.MultipartRequest('POST', url);
      if(resume) {
        request.files.add(await http.MultipartFile.fromPath("resume", file));
      }else if (!resume){
        request.fields["document_type"] = documentType ?? "" ;
        request.files.add(await http.MultipartFile.fromPath("document_img", file));
        debugPrint(request.fields.toString()) ;
        debugPrint(request.files.toString()) ;
      }

      request.headers["Authorization"] = "Bearer ${sp.getString("BarrierToken")}";
      var response = await request.send();
      var responded = await http.Response.fromStream(response);
      var responseData = jsonDecode(responded.body);
      if (response.statusCode == 200) {
        loading(false);
        seekerProfileController.viewSeekerProfileApi();
        Get.back();
        Utils.toastMessage("Profile Updated") ;
        if (kDebugMode) {
          print(responseData['message']);
        }
      } if(response.statusCode == 401) {
        sp.clear() ;
        Get.offAll( () => const Login()) ;
      }
      loading(false);
    } catch (e) {
      loading(false);
      if (kDebugMode) {
        print(e.toString()) ;
      }
    }
  }
}