
import 'dart:convert';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';

class EditSeekerSoftSkillsController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  RxBool salaryLoading = false.obs;
  var errorMessage = "".obs ;
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;

  skillsApi(
      dynamic skills ,
      int number
      ) async{
    loading(true) ;
    Map data = number == 1 ?  {'skill_id' : jsonEncode(skills)} :
     number == 2 ? {'passion_id' : jsonEncode(skills)} :
    number == 3 ? {'industry_id' : jsonEncode(skills)} :
    number == 4 ? {'strengths_id' : jsonEncode(skills)} :
    number == 5 ? {'start_work_id' : jsonEncode(skills)} :
    {'availabity_id' : jsonEncode(skills)};
    print(data);

    _api.editSeekerSoftSkill(data , number).then((value){
      loading(false) ;
      if(value.status!){
        seekerProfileController.viewSeekerProfileApi() ;
        Get.back() ;
        Utils.toastMessage('Profile Updated') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back() ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      Get.back() ;
    }) ;
  }

  salaryApi( dynamic minSalary , dynamic maxSalary ) async{
    salaryLoading(true) ;
    Map data = {
      'min_salary_expectation' : minSalary.toString() ,
      'max_salary_expectation' : maxSalary.toString() ,
    };
    print(data);

    _api.editSeekerSalaryExpectation(data).then((value){
      salaryLoading(false) ;
      if(value.status!){
        seekerProfileController.viewSeekerProfileApi() ;
        Get.back() ;
        Utils.toastMessage('Profile Updated') ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back() ;
      }
    }).onError((error, stackTrace){
      print(error);
      salaryLoading(false) ;
      Get.back() ;
    }) ;
  }
}