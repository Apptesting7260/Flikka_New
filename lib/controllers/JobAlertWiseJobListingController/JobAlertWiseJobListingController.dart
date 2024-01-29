import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import '../../models/JobAlertWiseJobListingModel/JobAlertWiseJobListingModel.dart';

class SeekerJobAlertWiseJobListingController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerJobAlertWiseJobListingData = JobAlertWiseJobListingModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeekerJobAlertWiseList(JobAlertWiseJobListingModel _value) => viewSeekerJobAlertWiseJobListingData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewSeekerJobAlertListApi(
      String positionID
      ) async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    var data = {} ;
    data.addIf(positionID.isNotEmpty , "position_id", positionID) ;
    print(data) ;
    _api.jobAlertWiseJobListApi(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeekerJobAlertWiseJobListingData(value);
      loading(false) ;
      print(value);


    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

// Future<void> refreshSeekerNotificationApi() async {
//   // setRxRequestStatus(Status.LOADING);
//   // loading(true) ;
//   _api.viewSeekerNotificationDataApi().then((value){
//     // setRxRequestStatus(Status.COMPLETED);
//     viewSeekerJobAlertListData(value);
//     // loading(false) ;
//     if (kDebugMode) {
//       print(value);
//     }
//
//
//   }).onError((error, stackTrace){
//     setError(error.toString());
//     if (kDebugMode) {
//       print(stackTrace);
//       print(error.toString());
//     }
//     // loading(false) ;
//     // setRxRequestStatus(Status.ERROR);
//   });
// }

}