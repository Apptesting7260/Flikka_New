import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/FilteredJobsModel/FilteredJobsModel.dart';

class SeekerJobFilterController extends GetxController {

  final _api = SeekerRepository();

  RxBool loading = false.obs;
  RxBool reset = true.obs ;
  var errorMessage = "".obs ;
  var jobsData = FilteredJobsListingModel().obs ;

  RxString lat = ''.obs ;
  RxString long = ''.obs ;
  RxBool fromMapScreen = false.obs ;

  void filterJob( bool? fromMap ,
      BuildContext context,
      dynamic jobTitle ,
      dynamic location ,
      dynamic company ,
      dynamic datePosted ,
      dynamic typeOfWorkplace ,
      dynamic minSalaryExpectation ,
      dynamic maxSalaryExpectation ,
      dynamic employmentType ,
      dynamic qualification ,
      dynamic skills ,
      dynamic language,
      dynamic positionId ,
      ) async{
    loading.value = true ;

    var data = {};
    data.addIf(jobTitle != null && jobTitle.toString().length != 0 , 'job_title' , jobTitle.toString()) ;
    data.addIf(location != null && location.toString().length != 0 , 'location' , location.toString()) ;
    data.addIf(company != null && company.toString().length != 0 , 'company' , company.toString()) ;
    data.addIf(datePosted != null && datePosted.toString().length != 0 , 'date_posted' , datePosted.toString()) ;
    data.addIf(typeOfWorkplace != null && typeOfWorkplace.toString().length != 0 , 'type_of_workplace' , typeOfWorkplace.toString()) ;
    data.addIf(minSalaryExpectation != null && minSalaryExpectation.toString().length != 0 , 'min_salary_expectation' , minSalaryExpectation.toString()) ;
    data.addIf(maxSalaryExpectation != null && maxSalaryExpectation.toString().length != 0 , 'max_salary_expectation' , maxSalaryExpectation.toString()) ;
    data.addIf(employmentType != null && employmentType.toString().length != 0 , 'employment_type' , employmentType.toString()) ;
    data.addIf(qualification != null && qualification.toString().length != 0 , 'qualification' , qualification.toString()) ;
    data.addIf(skills != null && skills.toString().length != 0 , 'sales_skills' , skills.toString()) ;
    data.addIf(language != null && language.toString().length != 0 , 'language' , language.toString()) ;
    data.addIf(positionId != null && positionId.toString().length != 0 , 'job_position_id' , positionId.toString()) ;
    if (kDebugMode) {
      print(data);
    }
    _api.seekerJobFilterApi(data).then((value){
      loading.value = false ;
      if(value.status!){
      jobsData(value) ;
      if (kDebugMode) {
        print("this is value ==== $value") ;
        print("this is value list ==== ${value.jobs?.length}") ;
        print("this is job length ==== ${jobsData.value.jobs?.length.toString()}") ;
      } if (fromMap == true) {
        fromMapScreen(true) ;
        Get.back(result: true) ;
      } else {
        Get.back() ;
      }
      reset(false) ;
      if (kDebugMode) {
        print(reset.value) ;
      }
      }
      else{
        Utils.showMessageDialog(context, "No Matching Job Found") ;
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      loading.value = false ;
    });
  }
}