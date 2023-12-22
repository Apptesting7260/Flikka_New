import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ApplicantTrackingController/ApplicantTrackingController.dart';

class AddToTalentPoolController extends GetxController {

  final _api = RecruiterRepository();
  final response = EditAboutModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;

  void poolSeeker( String? description , String? seekerID ){
    var data = {} ;
    data.addIf(seekerID != null && seekerID.length != 0 , "seeker_id" , seekerID) ;
    data.addIf(description != null && description.length != 0 , "discription" , description) ;
    loading(true) ;
    _api.addToPool(data).then((value){
      loading(false) ;
      response(value) ;
      Get.back() ;
      Utils.toastMessage("Added to talent pool") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      loading(false) ;
    });
  }
}