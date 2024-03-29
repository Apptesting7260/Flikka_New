import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../RecruiterInboxDataController/RecruiterInboxDataController.dart';
import '../SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';


class SeekerNotificationSeenController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  ShowInboxDataController ShowInboxDataControllerInstanse = Get.put(ShowInboxDataController());

  Future<bool>  notificationSeen ( BuildContext context , String? email) async {
    loading(true) ;
    var data = {} ;
    data.addIf(email != null && email.length != 0 , "email" , email ) ;
    print(data) ;
    setRxRequestStatus(Status.LOADING);
    return await _api.notificationSeen(data).then((value) {
      SeekerViewNotificationControllerInstanse.refreshSeekerNotificationApi() ;
      setRxRequestStatus(Status.COMPLETED);
      loading(false);
      if (kDebugMode) {
        print(value);
      }
      return true ;
    }).onError((error, stackTrace){
      loading(false) ;
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
      return false ;
    });
  }

  Future<bool>  notificationSeenRecruiter ( BuildContext context , String? email) async {
    loading(true) ;
    var data = {} ;
    data.addIf(email != null && email.length != 0 , "email" , email ) ;
    print(data) ;
    setRxRequestStatus(Status.LOADING);
    return await _api.notificationSeen(data).then((value) {
      ShowInboxDataControllerInstanse.refreshInboxDataRecruiternApi() ;
      setRxRequestStatus(Status.COMPLETED);
      loading(false);
      if (kDebugMode) {
        print(value);
      }
      return true ;
    }).onError((error, stackTrace){
      loading(false) ;
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
      return false ;
    });
  }

}