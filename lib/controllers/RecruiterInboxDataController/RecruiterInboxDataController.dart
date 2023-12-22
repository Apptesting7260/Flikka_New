import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import '../../models/RecruiterInboxDataModel/RecruiterInboxDataModel.dart';


class ShowInboxDataController extends GetxController {

  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final viewInboxData = RecruiterInboxDataModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void viewSeeker(RecruiterInboxDataModel _value) => viewInboxData.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> showInboxDataApi() async {
    setRxRequestStatus(Status.LOADING);
    loading(true) ;
    _api.viewInboxData().then((value){
      setRxRequestStatus(Status.COMPLETED);
      viewInboxData(value);
      loading(false) ;
      print(value);


    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace);
      loading(false) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}