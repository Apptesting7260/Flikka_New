
import 'dart:convert';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerAppreciationController extends GetxController {

  final _api = AuthRepository();
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
  appreciationApi(
      dynamic appreciation ,
      BuildContext context
      ) async{
    loading.value = true ;
    Map data =  {
      'appreciation' : jsonEncode(appreciation)
    };
    print(appreciation);

    _api.editSeekerAppreciationApi(data).then((value){
      loading.value = false ;
      if(value.status!){
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
    }) ;
  }
}