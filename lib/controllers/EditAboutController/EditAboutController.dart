
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditAboutController extends GetxController {

  final _api = AuthRepository();
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
   aboutApi(
      String about ,
      BuildContext context
      ) async{
    loading.value = true ;
    success(false) ;
    Map data = {
      'about_me' : about,
    };
    print(data);

    _api.editSeekerAboutApi(data).then((value){
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
      // Get.to(TabScreen(index: 0));
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back(result: false) ;
    });
  }
}