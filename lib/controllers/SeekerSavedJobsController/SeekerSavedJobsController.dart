import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../GetJobsListingController/GetJobsListingController.dart';

class SeekerSaveJobController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  GetJobsListingController getJobsListingController = GetJobsListingController() ;

  Future<bool> saveJobApi( dynamic id , dynamic type ,) async{
    loading(true) ;
    Map data =  {
      'id' : "$id" ,
      'type' : "$type"
    };
    if (kDebugMode) {
      print(data);
    }

  return await  _api.seekerSaveJobPost(data).then((value){
      loading(false) ;
      if(value.status!){
        Get.back(result: true) ;
        Utils.toastMessage('Post saved') ;
        return true ;
      }
      else{
        errorMessage.value =  value.message.toString();
        Get.back() ;
        return false ;
      }
    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
      }
      loading(false) ;
      Get.back() ;
      return false ;
    }) ;
  }
}