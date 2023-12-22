import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/RecruiterHomeModel/RecruiterHomeModel.dart';
import 'package:flikka/models/RecruiterHomePageModel/RecruiterHomePageModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class RecruiterHomeController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final homeData = RecruiterHomePageModel().obs ;
  RxString error = ''.obs;

  void getHomeData(RecruiterHomePageModel _value) => homeData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void recruiterHomeApi({ String? jobPosition}){
    var data = {} ;
    data.addIf(jobPosition != null && jobPosition.isNotEmpty , "job_position_id",jobPosition);
    setRxRequestStatus(Status.LOADING);
    _api.recruiterHomeApi(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      homeData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}