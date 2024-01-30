import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import '../../models/JobAlertSeenUnseenModel/JobAlertSeenUnseenModel.dart';

class JobAlertSeenUnseenJobController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerJobAlertSeenUnseenJobData = JobAlertSeenUnseenModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeekerJobAlertWiseList(JobAlertSeenUnseenModel _value) => viewSeekerJobAlertSeenUnseenJobData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> jobAlertSeenUnseenJobApi(
      String jobID
      ) async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    var data = {} ;
    data.addIf(jobID.isNotEmpty , "job_id", jobID) ;
    print(data) ;
    _api.jobAlertSeenUnseenJobApi(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeekerJobAlertSeenUnseenJobData(value);
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