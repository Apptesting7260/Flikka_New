import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';

import '../../models/ShowBankDetailsModel/ShowBankDetailsModel.dart';


class ShowBankDetailsController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewShowBankDetails = ShowBankDetailsModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeeker(ShowBankDetailsModel _value) => viewShowBankDetails.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> showBankDetailsApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.showBankDetails().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewShowBankDetails(value);
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

}