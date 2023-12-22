
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerGetAllSkillsModel/SeekerGetAllSkillsModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';

class SeekerGetAllSkillsController extends GetxController {
  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final seekerGetAllSkillsData =  SeekerGetAllSkillsModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerGetSkills(SeekerGetAllSkillsModel _value) => seekerGetAllSkillsData.value = _value ;
  void setError(String _value) => error.value = _value ;


  void seekerGetAllSkillsApi(){
    setRxRequestStatus(Status.LOADING);

    _api.seekerGetAllSkillsApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      seekerGetAllSkillsData(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      setRxRequestStatus(Status.ERROR);

    });
  }

  void refreshApi(){
    // setRxRequestStatus(Status.LOADING);
    refreshLoading(true) ;
    _api.seekerGetAllSkillsApi().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      seekerGetAllSkillsData( value);
      refreshLoading(false) ;
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      refreshLoading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}