import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'SeekerForumDataController.dart';

class SeekerAddForumController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void seekerAddForum( BuildContext context , String? industryID , String? title , String? description){
    loading(true) ;
    var data = {} ;
    data.addIf(industryID != null && industryID.length != 0 , "industry_id" , industryID?.toLowerCase()) ;
    data.addIf(title != null && title.length != 0 , "title" , title?.toLowerCase()) ;
    data.addIf(description != null && description.length != 0 , "description" , description?.toLowerCase()) ;

    setRxRequestStatus(Status.LOADING);
    _api.seekerAddForum(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      Get.back() ;
      forumDataController.seekerForumListApi(page: "1") ;
      loading(false) ;
      if (kDebugMode) {
        print(value);
      }}
    ).onError((error, stackTrace){
      loading(false) ;
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}