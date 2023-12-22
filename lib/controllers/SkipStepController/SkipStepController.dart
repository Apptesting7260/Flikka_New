
import 'package:flikka/Job%20Seeker/Authentication/user/create-profile.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Job Seeker/Role_Choose/choose_skills.dart';


class SkipStepController extends GetxController {

  final _api = AuthRepository();


  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  Future<void> skipStepApi(
      var step
      ) async {

    loading.value = true ;

    print(loading.value);
    Map data = {
      'skip_step' : step.toString() ,
    };
    print(data);

    _api.skipStepApi(data).then((value){
      loading.value = false ;
      print(value);
      print("dataaaaa");
      if(value.status!) {
        Get.back() ;
       step == 1 ? Get.to(() => const ChooseSkills())
       : Get.to( () => const CreateProfile()) ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back() ;
      errorMessage.value = error.toString() ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
}