
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SaveBankDetailsController extends GetxController {
  final _api = AuthRepository();

  RxBool loading = false.obs;
  var bankErrorMessage = ''.obs ;

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
      'account_holder' : accountHolder,
      'branch_code' : branchCode,
      'account_number' : accountNumber,
      'IFSC_code' : ifscCode,
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