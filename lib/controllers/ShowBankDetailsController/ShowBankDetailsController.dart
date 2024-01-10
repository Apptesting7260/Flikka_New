import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import '../../models/ShowBankDetailsModel/ShowBankDetailsModel.dart';
import '../SaveBankDetailsController/SaveBankDetailsController.dart';

class ShowBankDetailsController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewShowBankDetails = ShowBankDetailsModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeeker(ShowBankDetailsModel _value) => viewShowBankDetails.value = _value ;
  void setError(String _value) => error.value = _value ;

  SaveBankDetailsController SaveBankDetailsControllerInstanse = Get.put(SaveBankDetailsController()) ;
  Future<void> showBankDetailsApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.showBankDetails().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewShowBankDetails(value);
      loading(false) ;
      print(value);
      SaveBankDetailsControllerInstanse.bankName.value = value.bankDetails?.bankName.toString() ?? "";
      SaveBankDetailsControllerInstanse.accountHolderNameController.value.text = value.bankDetails?.accountHolder ?? "";
      SaveBankDetailsControllerInstanse.branchCodeController.value.text = value.bankDetails?.branchCode ?? "";
      SaveBankDetailsControllerInstanse.accountNumberController.value.text = value.bankDetails?.accountNumber ?? "";
      SaveBankDetailsControllerInstanse.ifscCodeController.value.text = value.bankDetails?.ifscCode ?? "";

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}