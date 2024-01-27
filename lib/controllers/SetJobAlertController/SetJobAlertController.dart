import 'dart:convert';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class SetJobAlertController extends GetxController {

  final _api = AuthRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void setJobAlert(BuildContext context ,String? positions, String? location){
    var data = {} ;
    data.addIf(positions != null && positions.length != 0 , "position_id" , jsonEncode(positions) ) ;
    data.addIf(location != null && location.length != 0 , "location" , jsonEncode(location) ) ;

    loading(true);
    _api.setJobAlertApi(data).then((value){
      loading(false);
      if(value.status!){
        Get.back() ;
        Get.back() ;
        Utils.toastMessage("Job alerts have been added successfully") ;
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      loading(false);
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    Utils.showMessageDialog(context, "Oops Something went wrong") ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}