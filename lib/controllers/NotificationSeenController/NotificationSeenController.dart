import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class SeekerNotificationSeenController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  Future<bool>  notificationSeen ( BuildContext context , String? email) async {
    loading(true) ;
    var data = {} ;
    data.addIf(email != null && email.length != 0 , "email" , email ) ;
    setRxRequestStatus(Status.LOADING);
    return await _api.notificationSeen(data).then((value) {
      SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
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