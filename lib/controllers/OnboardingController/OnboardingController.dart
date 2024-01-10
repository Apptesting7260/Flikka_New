
import 'package:flikka/models/OnboardingModel/OnboardingModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/response/status.dart';

class OnboardingController extends GetxController {
  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  String ?amount;
  RxBool loading = false.obs;

  final getOnboardingDetails = OnboardingModel().obs ;

  Future<void> onboardingApiHit(

      String? jobPositionID ,
      BuildContext context
      ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading.value = true ;
    setRxRequestStatus(Status.LOADING);
    Map data = {};
    data.addIf(jobPositionID != null && jobPositionID.length != 0 , "job_position_id" , jobPositionID ) ;
    _api.onboardingApi(data).then((value){
      getOnboardingDetails(value) ;
      setRxRequestStatus(Status.COMPLETED);
      loading.value = false ;
      if (kDebugMode) {
        print(value);
      }

      if(value.status == true) {
        // Utils.showMessageDialog(context, "Payment Request Successfully") ;
      }else if(value.status == false) {
        // paymentDialog(context) ;
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      setRxRequestStatus(Status.ERROR);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}