import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/AvtarImageListModel/AvtarImageListModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';
import '../../models/SeekerAppliedJobsModel/SeekerAppliedJobsModel.dart';
import '../../models/SeekerSavedPostModel/SeekerSavedPostModel.dart';


class AvtarImageListController extends GetxController {

  final _api = SeekerRepository();


  final rxRequestStatus = Status.LOADING.obs ;
  final avtarImageList = AvtarImageListModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  Future<void> getAvtarListApi() async {
    setRxRequestStatus(Status.LOADING);
    _api.avtarListApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      avtarImageList(value);
      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());

      setRxRequestStatus(Status.ERROR);

    });
  }

}