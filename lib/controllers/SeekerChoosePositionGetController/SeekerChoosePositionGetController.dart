
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerChoosePositionGetModel/SeekerChoosePositionGetModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SeekerChoosePositionGetController extends GetxController {

  final _api = AuthRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final seekerChoosePositionGetList =SeekerChoosePositionGetModel().obs ;
  RxList<SeekerPositionData>? positionsList = <SeekerPositionData>[].obs  ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void SeekersChoosePositionGetList(SeekerChoosePositionGetModel _value) => seekerChoosePositionGetList.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> seekerGetPositionApi(
      bool edit
      ) async {
    setRxRequestStatus(Status.LOADING);
    var sp = await SharedPreferences.getInstance() ;
    print(sp.getString("BarrierToken")) ;
    _api.seekerGetPositions().then((value){
      setRxRequestStatus(Status.COMPLETED);
      seekerChoosePositionGetList(value);
      positionsList?.value = seekerChoosePositionGetList.value.data! ;

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      if(edit) {
        Get.back() ;
      }
      setRxRequestStatus(Status.ERROR);

    });
  }

  filterList(String? query) {
    positionsList?.value = seekerChoosePositionGetList.value.data!.where((element) =>
        element.positions!.toLowerCase().contains(query!.toLowerCase())).toList() ;
  }


  Future<void> refreshApi() async {
    refreshLoading(true) ;
    var sp = await SharedPreferences.getInstance() ;
    print(sp.getString("BarrierToken")) ;
    _api.seekerGetPositions().then((value){
      refreshLoading(false) ;
      seekerChoosePositionGetList(value);
      positionsList?.value = seekerChoosePositionGetList.value.data! ;

      print(value);

    }).onError((error, stackTrace){
      refreshLoading(false) ;
      setError(error.toString());
      print(error.toString());
    });
  }

}