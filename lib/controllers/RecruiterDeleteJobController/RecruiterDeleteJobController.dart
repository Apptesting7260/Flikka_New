import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';

class RecruiterDeleteJobController extends GetxController {

  final _api = RecruiterRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  ViewRecruiterProfileGetController profileGetController = Get.put(ViewRecruiterProfileGetController()) ;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void setError(String value) => error.value = value ;

  deleteApi(dynamic id )
  async{
    loading(true) ;
    setRxRequestStatus(Status.LOADING);
    Map data =  {'job_id' : "$id"};
    debugPrint(data.toString());
    _api.deleteJob(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      loading(false) ;
      if(value.status!){
       Utils.toastMessage(value.message!) ;
       profileGetController.refreshRecruiterProfileApi() ;
       Get.back() ;
      }else {
        loading(false) ;
        Get.back() ;
      }
    }).onError((error, stackTrace){
      loading(false) ;
      Get.back() ;
      setError(error.toString());
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    }) ;
  }
}