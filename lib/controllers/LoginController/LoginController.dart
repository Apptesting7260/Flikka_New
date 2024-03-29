
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Seeker/Authentication/user/create-profile.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_position.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_skills.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/hiring%20Manager/Applicant_Tracking/applicant_tracking_tabbar.dart';
import 'package:flikka/main.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Job Recruiter/bottom_bar/tab_bar.dart';
import '../../utils/utils.dart';

class LoginController extends GetxController {
  final _api = AuthRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  var errorMessage = "".obs ;

  RxBool loading = false.obs;

  void loginApiHit(
      BuildContext context
      ) async {
    loading.value = true;
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (kDebugMode) {
      print(loading.value);
    }
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
      'device_token' : fcmToken,
    };
    if (kDebugMode) {
      print(data);
    }
    _api.LoginApi(data).then((value) {
      loading.value = false;
      sp.setString("BarrierToken", value.token.toString());
      sp.setString("name", value.name.toString());
      sp.setBool("hiringManager", value.hiringManager ?? false) ;
      if (kDebugMode) {
        print(sp.getString("BarrierToken"));
      }

      if (value.status == true) {
        if(value.hiringManager == true) {
          Get.offAll( () => const ApplicantTrackingHiringManager() ) ;
        } else {
          sp.setInt("step", value.step) ;
          if (value.role == 0) {
            value.step == 1
                ? Get.offAll(() => const ChoosePosition())
                : value.step == 2
                ? Get.offAll(() => const ChooseSkills())
                : value.step == 3
                ? Get.offAll(() => const CreateProfile())
                : Get.offAll(const TabScreen(index: 0, loadData: true,));
            sp.setString("loggedIn", "seeker");
          } else if (value.role == 1) {
            value.step == 1 ? Get.offAll(() => const RecruiterProfileEdit()) :
            Get.offAll(() => TabScreenEmployer(index: 0,));
            sp.setString("loggedIn", "recruiter");
          }
        }
      }
      else {
        errorMessage.value = "${value.message}" ;
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
      loading.value = false;
      Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }
}
