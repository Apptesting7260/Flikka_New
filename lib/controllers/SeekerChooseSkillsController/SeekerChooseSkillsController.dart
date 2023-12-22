
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Job Seeker/Authentication/user/create-profile.dart';
import '../../repository/Auth_Repository.dart';
import '../../utils/utils.dart';

class SeekerChooseSkillsController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  seekerSkillsApi (
      List? skills ,
      List? strengths ,
      List? passion ,
      List? industryPreference ,
      var minSalaryExpectation  ,
      var maxSalaryExpectation  ,
      List? startWork ,
      List? availability
     ) async {

    loading(true) ;

    var data = {
      "skill_id" : jsonEncode(skills) ,
      "strength_id" : jsonEncode(strengths),
      "passion_id" : jsonEncode(passion),
      "industry_preference_id" : jsonEncode(industryPreference),
      "min_salary_expectation" : minSalaryExpectation.toString(),
      "max_salary_expectation" : maxSalaryExpectation.toString(),
      "start_work_id" : jsonEncode(startWork),
      "availabity_id" : jsonEncode(availability),
    };
    print(skills.toString());
    SharedPreferences sp = await SharedPreferences.getInstance() ;
    _api.seekerChooseSkillsApi(data).then((value){
      loading(false) ;
      sp.setInt("step", 3) ;
      Get.to(() => const CreateProfile());

    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      errorMessage.value = error.toString() ;
      // Utils.snackBar('Failed',error.toString());
    });
  }

}