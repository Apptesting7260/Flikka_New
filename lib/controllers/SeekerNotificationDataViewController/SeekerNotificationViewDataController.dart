import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../models/SeekerNotificationDataModel/SeekerNotificationDataModel.dart';


class SeekerViewNotificationController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerNotificationData = SeekerNotificationDataModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeekerNotification(SeekerNotificationDataModel _value) => viewSeekerNotificationData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewSeekerNotificationApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.viewSeekerNotificationDataApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeekerNotificationData(value);
      loading(false) ;
      print(value);


    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }


  Future<void> refreshSeekerNotificationApi() async {
    // setRxRequestStatus(Status.LOADING);
    // loading(true) ;
    _api.viewSeekerNotificationDataApi().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      viewSeekerNotificationData(value);
      // loading(false) ;
      if (kDebugMode) {
        print(value);
      }


    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(stackTrace);
        print(error.toString());
      }
      // loading(false) ;
      // setRxRequestStatus(Status.ERROR);
    });
  }

}