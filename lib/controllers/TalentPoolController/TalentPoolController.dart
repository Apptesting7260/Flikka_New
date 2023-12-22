import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/TalentPoolModel/TalentPoolModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class TalentPoolController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final poolData = TalentPoolModel().obs ;
  RxString error = ''.obs;

  void getHomeData(TalentPoolModel _value) => poolData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void talentPoolApi(){
    setRxRequestStatus(Status.LOADING);
    _api.talentPoolApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      poolData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshPool(){
    _api.talentPoolApi().then((value){
      poolData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}