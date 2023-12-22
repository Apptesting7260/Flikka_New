import 'package:flikka/controllers/TalentPoolController/TalentPoolController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ApplicantTrackingController/ApplicantTrackingController.dart';

class RemoveFromTalentPoolController extends GetxController {

  final _api = RecruiterRepository();
  final response = EditAboutModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;
  TalentPoolController poolController = Get.put(TalentPoolController()) ;

  void removeSeeker( BuildContext context ,String? seekerID ){
    var data = {} ;
    data.addIf(seekerID != null && seekerID.length != 0 , "seeker_id" , seekerID) ;
    loading(true) ;
    _api.removeFromPool(data).then((value){
      poolController.refreshPool() ;
      loading(false) ;
      response(value) ;
      Get.back() ;
      Utils.toastMessage("removed from talent pool") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      Get.back() ;
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      loading(false) ;
    });
  }
}