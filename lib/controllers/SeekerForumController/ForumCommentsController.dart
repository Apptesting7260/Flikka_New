import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ForumCommentsModel/ForumCommentsModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'SeekerForumDataController.dart';

class ForumCommentsController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  final commentsData = ForumCommentsModel().obs ;
  List<SeekerComment>? reversedList = [] ;
  RxString error = ''.obs;

  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;
  void getForumData(ForumCommentsModel _value) => commentsData.value = _value ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  void forumCommentsListApi( String? industryID,{String? forumID} ){
    var data = {} ;
    data.addIf(forumID != null && forumID.length != 0 , "forum_id" , forumID) ;

    setRxRequestStatus(Status.LOADING);
    _api.forumComments(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      commentsData(value) ;
      reversedList = value.seekerComment ?? [] ;
      forumDataController.refreshForumListApi(industryID: industryID) ;
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

  void refreshForumCommentsListApi( String? industryID,{String? forumID} ){
    var data = {} ;
    data.addIf(forumID != null && forumID.length != 0 , "forum_id" , forumID) ;
    _api.forumComments(data).then((value){
      commentsData(value) ;
      reversedList = value.seekerComment ?? [] ;
      forumDataController.refreshForumListApi(industryID: industryID) ;
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
}