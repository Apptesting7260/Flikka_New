import 'dart:convert';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';
import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class EditSeekerLanguageController extends GetxController {

  final _api = AuthRepository();
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;
  languageApi( dynamic language ) async{
    loading.value = true ;
    success(false) ;
    Map data = {
      'language' : jsonEncode(language),
    };
    print(data);
    _api.editSeekerLanguageApi(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status!){
        success(true) ;
        Get.back(result: true) ;
        seekerProfileController.viewSeekerProfileApi() ;
        Utils.toastMessage('Profile updated') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back(result: false) ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back(result: false) ;
    });
  }
}