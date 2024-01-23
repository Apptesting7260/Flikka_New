import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import '../../models/SeekerJobAlertListModel/SeekerJobAlertListModel.dart';

class SeekerJobAlertListController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewSeekerJobAlertListData = SeekerJobAlertListModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeekerJobAlertList(SeekerJobAlertListModel _value) => viewSeekerJobAlertListData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewSeekerJobAlertListApi() async {
    setRxRequestStatus(Status.LOADING);
    print("object") ;
    loading(true) ;
    _api.jobAlertListDataApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewSeekerJobAlertListData(value);
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