import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewParticularCandidateModel/ViewParticularCandidateModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class ViewParticularCandidateController extends GetxController {

  final _api = RecruiterRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final candidateData = ViewParticularCandidateModel().obs ;
  RxString error = ''.obs;

  void getHomeData(ViewParticularCandidateModel _value) => candidateData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void viewCandidateApi( String? seekerID ){
    var data = {
      "seeker_id" : seekerID
    } ;

    setRxRequestStatus(Status.LOADING);
    _api.viewParticularCandidate(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      candidateData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}