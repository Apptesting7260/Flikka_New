
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/ForgotPasswordController/ForgotPasswordController.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/Job%20Seeker/Authentication/otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Job Seeker/Authentication/sign_up.dart';

class ResetPasswordController extends GetxController {

  final _api = AuthRepository();

  final emailController=TextEditingController().obs;
  final passwordcontroller=TextEditingController().obs;
  final confirmpasswordcontroller=TextEditingController().obs;

  RxBool loading = false.obs;

  void resetPasswordApiHit(
      var email,BuildContext context
      ){
    print("*****************");
    loading.value = true ;
    print(loading.value);
    Map data = {
      'email' :email,
      'password' :passwordcontroller.value.text,
      'confirm_password' :confirmpasswordcontroller.value.text,
    };
    print(data);
    _api.resetPasswordApi(data).then((value){
      loading.value = false ;
      print(value);
      print("dataaaaa");
      Utils.showMessageDialog(context , "Password reset successful") ;
      // verifyEmail =  emailController.value.text;
      // Utils.snackBar( "Message",value.message.toString());

      // Get.offAll(const Login());
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Utils.toastMessage("Password reset failed") ;
    });
  }
}