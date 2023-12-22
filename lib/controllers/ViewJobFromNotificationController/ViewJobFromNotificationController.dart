import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../models/ViewJobFromNotification/ViewJobFromNotification.dart';

class ViewJobFromNotificationController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  var jobData = ViewJobFromNotification().obs;
  RxString error = ''.obs;
  var loading = false.obs ;
  void setData(ViewJobFromNotification value) => jobData.value = value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void viewJobFromNotificationData( BuildContext context , String? jobID , String? seekerId){
    loading(true) ;
    var data = {} ;
    data.addIf(jobID != null && jobID.length != 0 , "job_id" , jobID ) ;
    data.addIf(seekerId != null && seekerId.length != 0 , "seeker_id" , seekerId ) ;

    setRxRequestStatus(Status.LOADING);
    _api.viewJobFromNotification(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      setData(value) ;
      // Get.back() ;
      loading(false) ;
      if (kDebugMode) {
        print(value);
      }}
    ).onError((error, stackTrace){
      loading(false) ;
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}