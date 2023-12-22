
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewLanguageModel/VIewLanguageModel.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';

class ViewLanguageController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewLanguageData = ViewLanguageModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewLanguage(ViewLanguageModel _value) => viewLanguageData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewLanguageApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    // var sp = await SharedPreferences.getInstance() ;
    // print(sp.getString("BarrierToken")) ;
    _api.viewLanguageApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewLanguageData(value);
      loading(false) ;
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}