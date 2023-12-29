import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Job Recruiter/bottom_bar/tab_bar.dart';
import '../../Job Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import '../../Job Seeker/Authentication/user/create-profile.dart';
import '../../Job Seeker/Role_Choose/choose_position.dart';
import '../../Job Seeker/Role_Choose/choose_skills.dart';
import '../../Job Seeker/SeekerBottomNavigationBar/tab_bar.dart';

class CheckSocialLoginController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  RxBool success = false.obs;
  var errorMessage = "".obs ;

  Future<bool> checkSocialLogin( String email ) async {
    loading.value = true ;
    success(false) ;
    Map data = {};
    data.addIf(email.isNotEmpty ,"email",email);
    if (kDebugMode) {
      print(data);
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await _api.checkSocialLoginApi(data).then((value){
      loading.value = false ;
      if (kDebugMode) {
        print(value);
      }
      if(value.emailRegistered == false ) {
        success(true);
        Get.to( () => const ChooseRole()) ;
      } else {
        if (value.role == 0) {
          value.step == 1
              ? Get.offAll(() => const ChoosePosition())
              : value.step == 2
              ? Get.offAll(() => const ChooseSkills())
              : value.step == 3
              ? Get.offAll(() => const CreateProfile())
              : Get.offAll(const TabScreen(index: 0)) ;
          sp.setString("loggedIn", "seeker");
        } else if (value.role == 1) {
          value.step == 1 ? Get.offAll( () => const RecruiterProfileEdit()) :
          Get.offAll( () => TabScreenEmployer(index: 0,)) ;
          sp.setString("loggedIn", "recruiter");
        }
      }
        return true ;
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      loading.value = false ;
      return false ;
    });
  }
}