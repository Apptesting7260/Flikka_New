import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/main.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/NewProfileModelSeeker/NewProfileModelSeeker.dart';


class ViewSeekerProfileControllerr extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerData = ProfileModelSeeker().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  var refreshLoading = false.obs ;
  var seekerID ;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
  void viewSeeker(ProfileModelSeeker value) => viewSeekerData.value = value ;
  void setError(String value) => error.value = value ;


  viewSeekerProfileApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance() ;
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.viewSeekerProfilerr().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeeker(value);
      print(  "${viewSeekerData.value.seekerInfo!.id.toString()}============USERID");
      loading(false) ;
      print(value);
      print("fcm token set up sie5666767hgjjjjgjhgjgjwjjgwjgwjgjgjjw");
      seekerID = value.seekerInfo?.id ;
      sp.setString("seekerName", value.seekerInfo?.fullname ?? "") ;
      sp.setString("seekerID", value.seekerInfo?.id.toString() ?? "") ;
      sp.setString("seekerLocation", value.seekerInfo?.location ?? "") ;
      sp.setString("seekerPosition", value.seekerDtls?.positions ?? "") ;
      sp.setString("seekerProfileImg", value.seekerInfo?.profileImg ?? "") ;
      var deviceTokenRef = _firestore.collection("S-ID${value.seekerInfo?.id.toString()}").doc('DeviceToken');

      print("fcm token set 5666767hgjjjjgjhgjgjwjjgwjgwjgjgjjw");


      deviceTokenRef.set({'device token': fcmToken});
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }



// void refreshApi(){
//   refreshLoading(true) ;
//   _api.viewSeekerProfile().then((value){
//     viewSeekerData( value);
//     refreshLoading(false) ;
//     print(value);

//   }).onError((error, stackTrace){
//     setError(error.toString());
//     print(error.toString());
//     refreshLoading(false) ;
//     setRxRequestStatus(Status.ERROR);

//   });
// }

}