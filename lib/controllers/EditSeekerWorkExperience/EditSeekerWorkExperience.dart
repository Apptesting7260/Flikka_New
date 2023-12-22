
import 'dart:convert';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerExperienceController extends GetxController {

  final _api = AuthRepository();
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
  workApi(
      bool isExperience ,
     dynamic experience ,
      BuildContext context
      ) async{
    loading.value = true ;
    success(false) ;
    Map data = isExperience ? {
      'work_exp_job' : jsonEncode(experience),
    }: {
      "education_level" : jsonEncode(experience)
    }
    ;
    print(data);

  isExperience ?  _api.editSeekerExperienceApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.back(result: true) ;
        seekerProfileController.viewSeekerProfileApi() ;
        Utils.toastMessage('Profile updated') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back(result: false) ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back(result: false) ;
    }) :
    _api.editSeekerEducationApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.back(result: true) ;
        seekerProfileController.viewSeekerProfileApi() ;
        Utils.toastMessage('Profile updated') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back(result: false) ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back(result: false) ;
    });
  }
}