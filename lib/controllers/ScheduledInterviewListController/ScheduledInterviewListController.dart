import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/RecruiterHomeModel/RecruiterHomeModel.dart';
import 'package:flikka/models/ScheduledInterviewListModel/ScheduledInterviewListModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class ScheduledInterviewListController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final interviewData = ScheduledInterviewListModel().obs ;
  RxString error = ''.obs;

  void getHomeData(ScheduledInterviewListModel _value) => interviewData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void interviewListApi({String? filter}){
    var data = {} ;
    data.addIf(filter != null && filter.length != 0 , "interview" , filter?.toLowerCase()) ;

    setRxRequestStatus(Status.LOADING);
    _api.getInterviewList(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      interviewData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshInterview({String? filter}){
    var data = {} ;
    data.addIf(filter != null && filter.length != 0 , "interview" , filter?.toLowerCase()) ;

    // setRxRequestStatus(Status.LOADING);
    _api.getInterviewList(data).then((value){
      // setRxRequestStatus(Status.COMPLETED);
      interviewData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      // setRxRequestStatus(Status.ERROR);
    });
  }
}