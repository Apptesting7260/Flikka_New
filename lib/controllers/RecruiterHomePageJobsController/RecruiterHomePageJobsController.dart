import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/RecruiterHomePageJobsModel/RecruiterHomePageJobsModel.dart';
import 'package:flikka/models/RecuiterJobTitleModel/RecruiterJobTitleModel.dart';
import 'package:flikka/repository/RecruiterRepository/RecruiterRepository.dart';
import 'package:get/get.dart';

class RecruiterHomePageJobsController extends GetxController {

  final _api = RecruiterRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final getJobsDetails = RecruiterHomePageJobsModel().obs ;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(RecruiterHomePageJobsModel _value) => getJobsDetails.value = _value ;
  void setError(String _value) => error.value = _value ;


  void recruiterJobsApi () {
    setRxRequestStatus(Status.LOADING);

    _api.getHomePageJobsApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getJobsDetails(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}