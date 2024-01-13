
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../PaymentRequestController/PaymentRequestController.dart';

class SaveBankDetailsController extends GetxController {
  final _api = AuthRepository();

  RxBool loading = false.obs;
  var bankErrorMessage = ''.obs ;

  var bankName = "".obs ;
  Rx<TextEditingController> accountHolderNameController = TextEditingController().obs;
  Rx<TextEditingController> branchCodeController = TextEditingController().obs ;
  Rx<TextEditingController> accountNumberController = TextEditingController().obs ;
  Rx<TextEditingController> ifscCodeController = TextEditingController().obs ;

  Future<void> saveBankDetailsApiHit(
      var bankName,
      var accountHolder,
      var branchCode,
      var accountNumber,
      var ifscCode,
      BuildContext context
      ) async {

    loading.value = true ;
    Map data = {
      'bank_name' : bankName.toString(),
      'account_holder' : accountHolderNameController.value.text,
      'branch_code' : branchCodeController.value.text,
      'account_number' : accountNumberController.value.text,
      'IFSC_code' : ifscCodeController.value.text,
    };
    print(data);

    _api.SaveBankDetailsApi(data).then((value){
      loading.value = false ;
      print(value);

      if(value.status==true) {
       Utils.showMessageDialog(context, "Bank Details save successfully") ;
      }
      // Get.to(AddBankAccountDetails()) ;

    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}