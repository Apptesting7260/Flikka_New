
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyJobController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessageApplyReferral = "".obs ;
  Future<bool> applyJob(BuildContext context,dynamic id , {
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
        errorMessageApplyReferral.value =  value.message.toString();
        Utils.showMessageDialog(context, "${value.message}") ;
        return false ;
      }
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      loading.value = false ;
      Utils.showMessageDialog(context, "Something went wrong") ;
      return false ;
    });
  }
}