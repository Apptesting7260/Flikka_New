import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class RequestedSeekersController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final requestedData = ScheduledInterviewListModel().obs ;
  RxString error = ''.obs;

  void getHomeData(ScheduledInterviewListModel _value) => requestedData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void request(){

    setRxRequestStatus(Status.LOADING);
    _api.getRequestedSeekersList().then((value){
      setRxRequestStatus(Status.COMPLETED);
      requestedData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}