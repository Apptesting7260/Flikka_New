import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerChoosePositionGetModel/SeekerChoosePositionGetModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';


class ViewRecruiterProfileGetController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final viewRecruiterProfile =ViewRecruiterProfileModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewRecruiterProfileGetList(ViewRecruiterProfileModel _value) => viewRecruiterProfile.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewRecruiterProfileApi() async {
    setRxRequestStatus(Status.LOADING);
    var sp = await SharedPreferences.getInstance() ;
    print(sp.getString("BarrierToken")) ;
    _api.viewRecruiterProfile().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewRecruiterProfile(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);

      setRxRequestStatus(Status.ERROR);

    });
  }


  Future<void> refreshRecruiterProfileApi() async {
    _api.viewRecruiterProfile().then((value){
      viewRecruiterProfile(value);
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
    });
  }

  void refreshApi(){
    // setRxRequestStatus(Status.LOADING);
    refreshLoading(true) ;
    _api.viewRecruiterProfile().then((value){
      // setRxRequestStatus(Status.COMPLETED);
      viewRecruiterProfile( value);
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