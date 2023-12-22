import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SelectIndustryModel/SelectIndustryModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';

class SelectIndustryController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final getIndustriesData =SelectIndustryModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerGetSkills(SelectIndustryModel _value) => getIndustriesData.value = _value ;
  void setError(String _value) => error.value = _value ;


  void selectIndustriesApi(){
    setRxRequestStatus(Status.LOADING);

    _api.selectIndustryApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getIndustriesData(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      setRxRequestStatus(Status.ERROR);

    });
  }

}