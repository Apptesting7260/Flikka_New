import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';
import '../../models/SeekerViewInterviewAll/SeekerViewInterviewAll.dart';

class SeekerViewInterviewAllController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final seekerInterViewData = SeekerViewInterviewModel().obs ;
  RxString error = ''.obs;

  void getHomeData(SeekerViewInterviewModel _value) => seekerInterViewData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void seekerInterViewListApi({String? filter}){
    var data = {} ;
    data.addIf(filter != null && filter.length != 0 , "interview" , filter?.toLowerCase()) ;

    setRxRequestStatus(Status.LOADING);
    _api.getInterviewList(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      seekerInterViewData(value) ;
      print(value);
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}