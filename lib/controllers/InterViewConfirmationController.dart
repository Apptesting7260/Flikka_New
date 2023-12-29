
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ScheduledInterviewListController/ScheduledInterviewListController.dart';

class InterViewConfirmationController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;

  ScheduledInterviewListController interviewListController = Get.put(ScheduledInterviewListController()) ;

 Future<bool> interViewConfirmationApi(
      String requestID ,
      String? interViewCompleted ,
      String? interViewDecline ,
      BuildContext context
      ) async{
    loading.value = true ;
    success(false) ;
    Map data = {};
    data.addIf(requestID.isNotEmpty ,"request_id",requestID);
    data.addIf( interViewCompleted != null &&  interViewCompleted.isNotEmpty ,"interview_completed",interViewCompleted);
    data.addIf(interViewDecline != null && interViewDecline.isNotEmpty ,"interview_decline_reason",interViewDecline);
    print(data);

   return await _api.interViewConfirmationApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.back(result: true) ;
        interviewListController.refreshInterview();
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