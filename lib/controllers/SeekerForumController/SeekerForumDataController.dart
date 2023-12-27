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
  RxBool loadingPage = false.obs ;
  void getForumData(SeekerForumDataModel _value) => forumData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;
  RxList<ForumDatum>? forumList = <ForumDatum>[].obs;
  List<ForumDatum>? reversedList = [] ;

  void seekerForumListApi({String? page} ) {
    var data = {} ;
    data.addIf(page != null && page.length != 0 , "page" , page) ;

    setRxRequestStatus(Status.LOADING);
    _api.seekerForumData(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      forumData(value) ;
      if(value.forumData != null) {
        reversedList = value.forumData ?? [] ;
        forumList?.value = value.forumData ?? [] ;
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

  void refreshForumListApi({String? page} ){
    var data = {} ;
    data.addIf(page != null && page.length != 0 , "page" , page) ;


    _api.seekerForumData(data).then((value){

      forumData(value) ;
      if(value.forumData != null) {
        reversedList = value.forumData ?? [] ;
        forumList?.value = value.forumData ?? [] ;
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


  void paginationForumApi({String? page} ){
    var data = {} ;
    loadingPage(true) ;
    data.addIf(page != null && page.length != 0 , "page" , page) ;
    _api.seekerForumData(data).then((value){
      forumData.value.isLast = value.isLast ;
      if(value.forumData != null) {
        for(int i = 0 ; i < value.forumData!.length ; i++) {
          if(value.forumData?[i] != null) {
            reversedList?.add(value.forumData![i]);
            forumList?.add(value.forumData![i]);
          }
        }
      }
      loadingPage(false) ;
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      loadingPage(false) ;
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