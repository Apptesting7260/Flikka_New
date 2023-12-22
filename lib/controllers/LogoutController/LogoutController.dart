
import 'dart:convert';

import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/models/LogoutModel/LogoutModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../res/app_url.dart';
import '../../utils/utils.dart';

class LogoutController extends GetxController {

  LogoutModel logoutModel = LogoutModel() ;
  final _api = AuthRepository();
  RxBool loading = false.obs;

  // void logout(
  //     ) async{
  //   loading.value = true ;
  //   SharedPreferences sp= await SharedPreferences.getInstance();
  //   try{
  //     var token = sp.getString("BarrierToken") ;
  //     if (kDebugMode) {
  //       print("$token") ;
  //     }
  //     Uri url = Uri.parse(AppUrl.logout) ;
  //     debugPrint(url.toString()) ;
  //     if(sp.getString("BarrierToken") != null && sp.getString("BarrierToken").toString().length != 0  ) {
  //       if (kDebugMode) {
  //         print("inside if") ;
  //       }
  //       var response = await http.post(url,
  //         headers: {
  //           "Authorization": "Bearer ${sp.getString("BarrierToken")}"
  //         },);
  //       logoutModel = LogoutModel.fromJson(jsonDecode(response.body));
  //       if (logoutModel.status == true) {
  //         sp.remove("BarrierToken");
  //         sp.remove("loggedIn");
  //         sp.remove("step");
  //         sp.clear();
  //         Get.offAll(() => const Login());
  //       }
  //     }else {
  //       if (kDebugMode) {
  //         print("inside else") ;
  //       }
  //       sp.clear();
  //       Get.offAll(() => const Login());
  //     }
  //   }catch(e){
  //     debugPrint(e.toString()) ;
  //     Get.back() ;
  //   }
  //
  // }

  Future<void> logout(BuildContext context) async {
    loading.value = true ;
    print(loading.value);
    Map data = {};
    SharedPreferences sp= await SharedPreferences.getInstance();
    print(data);
    _api.logoutApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status == true ) {
        sp.remove("BarrierToken");
        sp.remove("loggedIn");
        sp.remove("step");
        sp.clear();
        Get.offAll(() => const Login());
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
}