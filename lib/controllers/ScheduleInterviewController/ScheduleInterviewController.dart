import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ApplicantTrackingController/ApplicantTrackingController.dart';

class ScheduleInterviewController extends GetxController {

  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());
  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final response = EditAboutModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;

  final interViewLinkController = TextEditingController().obs ;
  void getHomeData(EditAboutModel _value) => response.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void scheduleInterview( String? dateTime , String? requestID , String? interviewLink ){
    var data = {
      'interview_link' : interViewLinkController.value.text ,
    } ;
    data.addIf(requestID != null && requestID.length != 0 , "request_id" , requestID!) ;
    data.addIf(dateTime != null && dateTime.length != 0 , "date_time" , dateTime!) ;

    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.scheduleInterview(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      loading(false) ;
      response(value) ;
      Get.back() ;
      Get.back() ;
      trackingDataController.applicantTrackingApi("", "") ;
      Utils.toastMessage("${value.message}") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      setError(error.toString());
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}