
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/CheckEmailSignUpController/CheckEmailSignUpController.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/Job%20Seeker/Authentication/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Job Seeker/Authentication/sign_up.dart';

class ForgotPasswordController extends GetxController {

  final _api = AuthRepository();

  final emailController = TextEditingController().obs;

  CheckEmailSignUpController checkEmailSignUpController = Get.put(CheckEmailSignUpController());
  var forgotPasswordErrorMessage = ''.obs ;

  RxBool loading = false.obs;
  String ? verifyEmail;
  void forgotPasswordApiHit(BuildContext context){
    loading.value = true ;
    print(loading.value);
    Map data = {
      'email' : emailController.value.text,
    };
    print(data);
    _api.ForgotPasswordApi(data).then((value){
      loading.value = false ;
      print(value);
      verifyEmail =  emailController.value.text;

      if(value.status == true ) {
        Utils.toastMessage("otp sent successfully") ;
        checkEmailSignUpController.secondsRemaining.value = 60 ;
        checkEmailSignUpController.startTimer() ;
        Get.back() ;
        Get.to(() => const OtpScreen(register: false,), arguments: {"email": verifyEmail});
      } else {
        loading.value = false ;
        // Utils.snackBar('Failed',value.message.toString());
        forgotPasswordErrorMessage.value = value.message.toString() ;
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      Get.back() ;
      loading.value = false ;
      Utils.showApiErrorDialog(context, "oops! something went wrong") ;
      // Utils.snackBar('Failed',error.toString());
    });
  }

  @override
  void dispose() {
    checkEmailSignUpController.timer.cancel() ;
    super.dispose();
  }
}