
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';
import '../../models/SeenUnSeenWalletMessageModel/SeenUnSeenWalletMessageModel.dart';
import '../SeekerEarningController/SeekerEarningController.dart';

class SeenUnSeenWalletMessageController extends GetxController {

  final _api = AuthRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final response = SeenUnSeenWalletMessageModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;

  SeekerEarningController seekerEarningController = Get.put(SeekerEarningController());
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  Future<void> seenUnSeenWalletMessage( BuildContext context, String? email) async {
    loading(true) ;
    var data = {} ;
    data.addIf(email != null && email.length != 0, "email", email);
    print(data) ;
    setRxRequestStatus(Status.LOADING);
   return await _api.seenUnSeenWalletApi(data).then((value){
      seekerEarningController.refreshWalletApi() ;
      setRxRequestStatus(Status.COMPLETED);
      loading(false) ;
      if (kDebugMode) {
        print(value);
      }
      response(value) ;
      // Get.back() ;
      // Utils.toastMessage("removed from talent pool") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      Get.back() ;
      // Utils.showMessageDialog(context, "oops! something went wrong") ;
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
    });
  }

}