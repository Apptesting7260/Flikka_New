
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
  RxList<SeekerJobsData>? filteredList = <SeekerJobsData>[].obs ;

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

  filterJobs (String query) {
      if(getJobsListing.value.jobs != null) {
        filteredList?.value =  getJobsListing.value.jobs!.where((e) {
          if(e.recruiterDetails != null && e.jobLocation != null) {
            if(e.jobLocation!.toLowerCase().contains(query.toLowerCase()) ||
                e.recruiterDetails!.companyName!.toLowerCase().contains(query.toLowerCase())) {
              if (kDebugMode) {
                print(filteredList?.length) ;
              }
              return true;
            }else{
              return false ;
            }
          }else{
            return false ;
          }
        }
   ).toList() ;
      }
  }
}