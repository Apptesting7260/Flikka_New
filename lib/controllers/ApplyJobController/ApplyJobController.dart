
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyJobController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  Future<bool> applyJob(dynamic id , {
    String? seekerID , String? referralCode
  }) async{
    loading.value = true ;

    var data = {
      'job_id' : id,
    };
    if (kDebugMode) {
      print(data);
    }
    data.addIf(seekerID != null && seekerID.isNotEmpty , "seeker_id", seekerID) ;
    data.addIf(referralCode != null && referralCode.isNotEmpty , "referral_by", referralCode) ;

  return await  _api.applyJobApi(data).then((value){
      loading.value = false ;
      if (kDebugMode) {
        print(value);
      }
      if(value.status!){
       seekerID == null ? Utils.toastMessage( "Successfully Applied") :
       Utils.toastMessage( "Profile Selected") ;
        Get.back() ;
        return true ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Utils.toastMessage( "${value.message}") ;
        Get.back() ;
        return false ;
      }
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      loading.value = false ;
      return false ;
    });
  }
}