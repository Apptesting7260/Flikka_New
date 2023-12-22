import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SeekerMapJobsController/SeekerMapJobsController.dart';


class ViewSeekerProfileController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerData = ViewSeekerProfileModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  var refreshLoading = false.obs ;
var seekerID ;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void viewSeeker(ViewSeekerProfileModel value) => viewSeekerData.value = value ;
  void setError(String value) => error.value = value ;
  SeekerMapJobsController jobsController = Get.put(SeekerMapJobsController());

   viewSeekerProfileApi() async {
     SharedPreferences sp = await SharedPreferences.getInstance() ;
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.viewSeekerProfile().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeeker(value);
      loading(false) ;
      if (kDebugMode) {
        print(  "${viewSeekerData.value.seekerInfo?.id.toString()}============USERID");
        print(value);
      }
      seekerID = value.seekerInfo?.id ;
      sp.setString("seekerName", value.seekerInfo?.fullname ?? "") ;
      sp.setString("seekerID", value.seekerInfo?.id.toString() ?? "") ;
      sp.setString("seekerLocation", value.seekerInfo?.location ?? "") ;
      sp.setString("seekerPosition", value.seekerDetails?.positions ?? "") ;
      sp.setString("seekerProfileImg", value.seekerInfo?.profileImg ?? "") ;
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

  void refreshApi(){
    refreshLoading(true) ;
    _api.viewSeekerProfile().then((value){
      viewSeekerData( value);
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