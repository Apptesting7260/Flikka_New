
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerForumIndustryListModel/SeekerForumIndustryListModel.dart';
import 'package:get/get.dart';
import '../../repository/SeekerDetailsRepository/SeekerRepository.dart';

class SeekerForumIndustryController extends GetxController {

  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final industryData = ForumIndustryListModel().obs ;
  RxString error = ''.obs;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void seekerEarnings(ForumIndustryListModel _value) => industryData.value = _value ;
  void setError(String _value) => error.value = _value ;


  void industryApi(){
    _api.forumIndustryList().then((value){
      setRxRequestStatus(Status.COMPLETED);
      industryData(value);

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      print(stackTrace) ;
      setRxRequestStatus(Status.ERROR);

    });
  }

}