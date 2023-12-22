
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flikka/controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SeekerViewCompanyController/SeekerViewCompanyController.dart';

class SeekerUpdateRequestedJobStatusController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  SeekerAppliedJobsController jobsController = Get.put(SeekerAppliedJobsController()) ;

  updateStatus( String? jobId , String? status , BuildContext context) async{
    loading(true) ;
    var data =  {};
    data.addIf(jobId != null && jobId.length != 0 , 'job_id' , "$jobId" ) ;
    data.addIf(status != null && status.length != 0 , 'status' , "$status" ) ;

    _api.seekerUpdateRequestedJobStatus(data).then((value){
      loading(false) ;
      if(value.status!){
        jobsController.getJobsApi() ;
        Get.back() ;
        Utils.toastMessage('Status updated') ;
      }
      Get.back() ;
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      Get.back() ;
      Utils.showMessageDialog(context, "oops! something went wrong") ;
    });
  }
}