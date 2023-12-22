import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/RecruiterReportModel/RecruiterReportModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RecruiterReportController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final reportData = RecruiterReportModel().obs ;
  RxString error = ''.obs;

  void getReportData(RecruiterReportModel _value) => reportData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void reportApi(){
    setRxRequestStatus(Status.LOADING);
    _api.reportApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      reportData(value) ;
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
    });
  }
}