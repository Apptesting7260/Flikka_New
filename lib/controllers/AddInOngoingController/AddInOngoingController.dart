import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class AddInOngoingController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  // ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  Future<bool>  ongoingApi ( BuildContext context , String? requestID) async {
    loading(true) ;
    var data = {} ;
    data.addIf(requestID != null && requestID.length != 0 , "request_id" , requestID ) ;

    setRxRequestStatus(Status.LOADING);
    return await _api.addInOngoing(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);

      loading(false);
      Get.back() ;
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
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      setRxRequestStatus(Status.ERROR);
      return false ;
    });
  }
}