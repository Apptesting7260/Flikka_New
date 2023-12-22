import 'dart:async';
import 'package:flikka/Job%20Seeker/Authentication/otp.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CheckEmailSignUpController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  var errorMessage = "".obs ;

   RxInt secondsRemaining = 60.obs;
  late Timer timer = Timer(const Duration(seconds: 1), () {});
  void startTimer() {
    if(timer.isActive){
      timer.cancel() ;
    }
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }
  void checkEmailSignUpApiHit(
      String email,
      BuildContext context
      ) async{
    loading.value = true ;
    Map data = { 'email' : email,};
    if (kDebugMode) {
      print(data);
    }
    _api.checkEmailSignUpApi(data).then((value){
      loading.value = false ;
      if (kDebugMode) {
        print(value);
      }
      if(value.status!){
        if (timer.isActive) {
          timer.cancel();
        }
        secondsRemaining.value = 60 ;
        startTimer() ;
        Get.back() ;
       Utils.toastMessage("otp sent successfully") ;
        Get.to(() => const OtpScreen(register: true) , arguments: {"email": email}) ;
      }
      else{
        // Get.back() ;
     errorMessage.value =  value.message.toString();
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      Get.back() ;
      loading.value = false ;
      Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }

}