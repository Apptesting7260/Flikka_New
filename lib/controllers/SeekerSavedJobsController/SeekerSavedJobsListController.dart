
import 'package:flikka/models/SeekerSavedPostModel/SeekerSavedPostModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';

class SeekerSavedJobsListController extends GetxController {

  final _api = SeekerRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  final savedPosts = SeekerSavedJobsListModel().obs ;
  RxString error = ''.obs;
  var loading = false.obs ;
  var refreshLoading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void savedPostData(SeekerSavedJobsListModel _value) => savedPosts.value = _value ;
  void setError(String _value) => error.value = _value ;

  savePostApi(dynamic type )
  async{
    loading(true) ;
    setRxRequestStatus(Status.LOADING);
    Map data =  {'type' : "$type"};
    print(data);

    _api.seekerSavedJobsListApi(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      loading(false) ;
      if(value.status!){
      savedPosts(value) ;
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());
      setRxRequestStatus(Status.ERROR);

    }) ;
  }

  // void refreshApi(dynamic type){
  //   // setRxRequestStatus(Status.LOADING);
  //   Map data =  {'type' : "$type"};
  //   refreshLoading(true) ;
  //   _api.seekerSavedJobsListApi(data).then((value){
  //     // setRxRequestStatus(Status.COMPLETED);
  //     savedPosts( value);
  //     refreshLoading(false) ;
  //     print(value);
  //
  //   }).onError((error, stackTrace){
  //     setError(error.toString());
  //     print(error.toString());
  //     refreshLoading(false) ;
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
}