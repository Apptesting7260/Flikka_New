import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/RecuiterJobTitleModel/RecruiterJobTitleModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class RecruiterJobTitleController extends GetxController {

  final _api = RecruiterRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final getJobTitleDetails = RecruiterJobTitleModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(RecruiterJobTitleModel _value) => getJobTitleDetails.value = _value ;
  void setError(String _value) => error.value = _value ;


  void recruiterJobTitleApi () {
    setRxRequestStatus(Status.LOADING);

    _api.getJobTitleApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getJobTitleDetails(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}