
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerEarningModel/SeekerEarningModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../models/ShowReferralByUserSeeker/ShowReferralByUserSeeker.dart';
import '../../repository/SeekerDetailsRepository/SeekerRepository.dart';

class SeekerEarningController extends GetxController {


  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final getEarningDetails = ShowReferralByUserModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(ShowReferralByUserModel _value) => getEarningDetails.value = _value ;
  void setError(String _value) => error.value = _value ;


  void seekerEarningApi(){
    setRxRequestStatus(Status.LOADING);

    _api.getWalletApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getEarningDetails(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
      if (kDebugMode) {
        print(stackTrace) ;
      }
      setRxRequestStatus(Status.ERROR);

    });
  }

  void refreshWalletApi(){
    // setRxRequestStatus(Status.LOADING);
    // refreshLoading(true) ;
    _api.getWalletApi().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      getEarningDetails( value);
      // refreshLoading(false) ;
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      // refreshLoading(false) ;
      // setRxRequestStatus(Status.ERROR);

    });
  }

}