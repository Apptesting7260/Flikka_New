import 'package:flikka/data/response/status.dart';
import 'package:get/get.dart';
import '../../models/CoverAvtarListRecruiterModel/CoverAvtarListRecruiterModel.dart';
import '../../repository/SeekerDetailsRepository/SeekerRepository.dart';


class CoverAvtarListController extends GetxController {

  final _api = SeekerRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final coverAvtarListRecruiter = CoverAvtarListRecruiter().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  Future<void> getCoverAvtarList() async {
    setRxRequestStatus(Status.LOADING);
    _api.coverAvtarList().then((value){
      setRxRequestStatus(Status.COMPLETED);
      coverAvtarListRecruiter(value);
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());

      setRxRequestStatus(Status.ERROR);

    });
  }

}