
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetJobsListingController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final getJobsListing = GetJobsListingModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void seekerGetJobs(GetJobsListingModel value) => getJobsListing.value = value ;
  void setError(String value) => error.value = value ;

  void seekerGetAllJobsApi(){
    if (kDebugMode) {
      print("called get jobs list step 1") ;
    }
    setRxRequestStatus(Status.LOADING);
    _api.getJobsListingApi().then((value){
      if (kDebugMode) {
        print("called get jobs list step 2") ;
      }
      setRxRequestStatus(Status.COMPLETED);
      seekerGetJobs(value);
      update() ;
      if (kDebugMode) {
        print("called get jobs list step 3") ;
      }

      if (kDebugMode) {
        print(value) ;
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshJobsApi(){
    _api.getJobsListingApi().then((value){
      seekerGetJobs(value);
      if (kDebugMode) {
        print("this is length ===== ${getJobsListing.value.jobs?.length}") ;
        print(value);
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    });
  }
}