
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialLoginController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;

  Future<bool> socialLoginApi(
      String email ,
      String? name ,
      String? deviceToke ,
      String? role ,
      String? googleID ,
      BuildContext context
      ) async{
    loading.value = true ;
    success(false) ;
    Map data = {};
    data.addIf(email.isNotEmpty ,"email",email);
    data.addIf( name != null &&  name.isNotEmpty ,"name",name);
    data.addIf(deviceToke != null && deviceToke.isNotEmpty ,"device_token",deviceToke);
    data.addIf(role != null && role.isNotEmpty ,"role",role);
    data.addIf(googleID != null && googleID.isNotEmpty ,"google_id",googleID);
    print(data);

    return await _api.socialLoginApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.back(result: true) ;
        // interviewListController.refreshInterview();
        Utils.toastMessage('Thanks for your response') ;
        return true ;
      }
      else{
        errorMessage.value =  value.message.toString();
        loading.value = false ;
        return false ;
      }
      // Get.to(TabScreen(index: 0));
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      return false ;
    });
  }
}