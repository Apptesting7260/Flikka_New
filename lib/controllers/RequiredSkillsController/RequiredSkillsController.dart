
import 'dart:convert';

import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/Job%20Recruiter/ViewRecruiterJob.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Job Seeker/Authentication/user/create-profile.dart';
import '../../data/response/status.dart';
import '../../models/SeekerGetAllSkillsModel/SeekerGetAllSkillsModel.dart';
import '../../repository/Auth_Repository.dart';
import '../../utils/utils.dart';

class RequiredSkillsController extends GetxController {

  final _api = AuthRepository();
  RxBool loading = false.obs;
  RxString error = ''.obs;
  final rxRequestStatus = Status.LOADING.obs ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  var errorMessage = "".obs ;
  var refreshLoading = false.obs ;
  final seekerGetAllSkillsData =  SeekerGetAllSkillsModel().obs ;
  void setError(String _value) => error.value = _value ;


  requiredSkillsApi (
      dynamic jobId ,
      List? skills ,
      List? strengths ,
      List? passion ,
      List? industryPreference ,
      dynamic minSalaryExpectation  ,
      dynamic maxSalaryExpectation  ,
      List? startWork ,
      List? availability
      ) {
    loading(true) ;
    setRxRequestStatus(Status.LOADING);
    var data = {
      "job_id" : jobId.toString() ,
      "skill_id" : jsonEncode(skills) ,
      "strength_id" : jsonEncode(strengths),
      "passion_id" : jsonEncode(passion),
      "industry_preference_id" : jsonEncode(industryPreference),
      "min_salary_expectation" : minSalaryExpectation.toString(),
      "max_salary_expectation" : maxSalaryExpectation.toString(),
      "start_work_id" : jsonEncode(startWork),
      "availabity_id" : jsonEncode(availability),

    };
    print(skills);

    _api.requiredSkillsApi(data).then((value){
      loading(false) ;
      // print(value);
      Get.offAll(TabScreenEmployer(index: 4, profileTabIndex: 2,));
  // Get.to(()=>const CompanyRecruiter());
      // Utils.snackBar( "Message",value.message);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);
      // Utils.snackBar('Failed',error);
    });
  }

  void refreshApi(){
    // setRxRequestStatus(Status.LOADING);
    refreshLoading(true) ;
    _api.seekerGetAllSkillsApi().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      seekerGetAllSkillsData( value);
      refreshLoading(false) ;
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      refreshLoading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}