import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteUserController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
  deleteUser(
      BuildContext context
      ) async{
    loading.value = true ;
    success(false) ;
    Map data = {};
    print(data);

    _api.deleteUser(data).then((value) async {
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.offAll(() => const Login()) ;
        SharedPreferences sp = await SharedPreferences.getInstance() ;
        sp.clear() ;
        Utils.toastMessage('User Deleted') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back(result: false) ;
      }
      // Get.to(TabScreen(index: 0));
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back(result: false) ;
    });
  }
}