
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../ScheduledInterviewListController/ScheduledInterviewListController.dart';

class RecruiterInterviewCancleController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  ScheduledInterviewListController interviewListController = Get.put(ScheduledInterviewListController()) ;

  Future<void> interviewCancle(BuildContext context , id) async {
    loading.value = true ;
    if (kDebugMode) {
      print(loading.value);
    }
    Map data = {
      "job_apply_id" : id.toString(),
    };

    if (kDebugMode) {
      print(data);
    }
    _api.interViewCancleApi(data).then((value){
      loading.value = false ;
      interviewListController.refreshInterview() ;
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      Get.back() ;
      loading.value = false ;
      Utils.showApiErrorDialog(context, "oops! something went wrong") ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}