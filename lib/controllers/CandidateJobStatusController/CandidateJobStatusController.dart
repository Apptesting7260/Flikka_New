import 'dart:async';

import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/EditAboutModel/EditAboutModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ChatRecruter/CreateFuction.dart';
import '../ApplicantTrackingController/ApplicantTrackingController.dart';
import '../ViewParticularCandidateController/ViewParticularCandidateController.dart';

class CandidateJobStatusController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final response = EditAboutModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;

  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());
  ViewParticularCandidateController candidateController = Get.put(ViewParticularCandidateController()) ;
  Createchatrecruter Ctreatechatinstance = Createchatrecruter();


  void getHomeData(EditAboutModel _value) => response.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void jobStatus( String? candidateStatus , String? requestID , {
    dynamic jobTitle , dynamic status
  } ){
    var data = {} ;
    data.addIf(requestID != null && requestID.length != 0 , "request_id" , requestID) ;
    data.addIf(candidateStatus != null && candidateStatus.length != 0 , "candidate_status" , candidateStatus) ;
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.candidateJobStatus(data).then((value){
      Get.back() ;
      Get.back() ;
      if(candidateStatus == "Accepted") {
        SeekerIDchat = candidateController.candidateData.value.seekerDetails?.seekerData?.seekerId.toString() ;
        Seekerimgchat = candidateController.candidateData.value.seekerDetails?.profileImg.toString();
        SeekerName = candidateController.candidateData.value.seekerDetails?.fullname.toString();
        // setState(() {
        //   SeekerIDchat;
        //   Seekerimgchat;
        //   SeekerName;
        // });

        if (kDebugMode) {
          print(SeekerIDchat);
          print(Seekerimgchat);
          print(SeekerName);
        }

        Timer(const Duration(seconds: 0), () {
          if(SeekerIDchat.toString()!="null"&&Seekerimgchat.toString()!="null"&&SeekerName.toString()!="null"){
            Ctreatechatinstance.CreateChat(acceptedProfile: true);
          }

        });

      }
      setRxRequestStatus(Status.COMPLETED);
      loading(false) ;
      response(value) ;
      trackingDataController.refreshApi(jobTitle, status) ;
      Utils.toastMessage("${value.message}") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      Get.back() ;
      Utils.toastMessage("could not update status") ;
      setError(error.toString());
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}