import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerForumDataModel/SeekerForumDataModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SeekerForumDataController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final forumData = SeekerForumDataModel().obs ;
  RxString error = ''.obs;
  RxString industryId = ''.obs;

  void getForumData(SeekerForumDataModel _value) => forumData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;
  RxList<ForumDatum>? forumList = <ForumDatum>[].obs;
  List<ForumDatum>? reversedList = [] ;

  void seekerForumListApi({String? industryID} ){
    var data = {} ;
    data.addIf(industryID != null && industryID.length != 0 , "industry_id" , industryID) ;

    setRxRequestStatus(Status.LOADING);
    _api.seekerForumData(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      forumData(value) ;
      if(value.forumData != null) {
        reversedList = value.forumData ?? [] ;
        forumList?.value = value.forumData ?? [] ;
      }
      if(industryID != null && industryID?.length != 0 ) {
        if(value.forumData != null && value.forumData?.length != 0) {
          industryId.value = "${value.forumData?[0].industryId}" ;
        }
      }
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshForumListApi({String? industryID} ){
    var data = {} ;
    data.addIf(industryID != null && industryID.length != 0 , "industry_id" , industryID) ;


    _api.seekerForumData(data).then((value){

      forumData(value) ;
      if(value.forumData != null) {
        reversedList = value.forumData ?? [] ;
        forumList?.value = value.forumData ?? [] ;
      }
      if(industryID != null && industryID?.length != 0 ) {
        if(value.forumData != null && value.forumData?.length != 0) {
          industryId.value = "${value.forumData?[0].industryId}" ;
        }
      }
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      setRxRequestStatus(Status.ERROR);
    });
  }

  filterList(String? query) {
    if(reversedList != null) {
      forumList?.value = reversedList!.where((element) {
        if( element.title != null) {
          if( element.title!.toLowerCase().contains(query.toString().toLowerCase()) || 
              element.industryPreference!.toLowerCase().contains(query.toString().toLowerCase())) {
            return true ;
          }else {
            return false ;
          }
        }else {
          return false ;
        }}).toList() ;
    }
  }
}