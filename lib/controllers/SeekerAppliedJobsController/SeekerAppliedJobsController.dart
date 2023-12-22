import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';
import '../../models/SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';
import '../../models/SeekerSavedPostModel/SeekerSavedPostModel.dart';


class SeekerAppliedJobsController extends GetxController {

  final _api = SeekerRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final jobsList = SeekerAppliedJobsModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  final appliedJobs = <AppliedJobsList?>[] ;
  final requestedJobs = <AppliedJobsList?>[] ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> getJobsApi() async {
    setRxRequestStatus(Status.LOADING);
    _api.appliedJobsApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      jobsList(value);
      if (value.job?.length != 0) {
        requestedJobs.clear() ;
        appliedJobs.clear() ;
        for(int i = 0 ; i < value.job!.length ; i++){
          if(value.job?[i].requestedStatus){
            requestedJobs.add(value.job?[i]) ;
          } else {
                appliedJobs.add(value.job?[i]) ;
          }
        }
      }
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());

      setRxRequestStatus(Status.ERROR);

    });
  }

}