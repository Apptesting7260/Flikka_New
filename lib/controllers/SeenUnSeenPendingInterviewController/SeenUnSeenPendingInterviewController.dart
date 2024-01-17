
import 'package:flikka/controllers/SeekerViewInterviewAllController/SeekerViewInterviewAllController.dart';
import 'package:flikka/models/SeenUnseenPendingInterviewModel/SeenUnSeenPendingInterviewModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeenUnSeenInterviewPendingController extends GetxController {

  final _api = AuthRepository();
  final response = SeenUnseenPendingInterviewModel().obs ;
  RxString error = ''.obs;
  RxBool loading = false.obs ;
   Rx<TextEditingController> emailController = TextEditingController().obs ;
   SeekerViewInterviewAllController interviewListController = Get.put(SeekerViewInterviewAllController()) ;
  // TalentPoolController poolController = Get.put(TalentPoolController()) ;

  void seenUnSeenPendingInterviewAPi( BuildContext context, String email){
    var data = {} ;
    data.addIf(emailController != null && emailController.value.text.length != 0, "email", emailController);
    loading(true) ;
    _api.seenUnseenInterviewApi(data).then((value){
      // interviewListController.seekerInterViewListApi() ;
      // poolController.refreshPool() ;
      loading(false) ;
      response(value) ;
      Get.back() ;
      // Utils.toastMessage("removed from talent pool") ;
      debugPrint(value.toString());
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      Get.back() ;
      // Utils.showMessageDialog(context, "oops! something went wrong") ;
      loading(false) ;
    });
  }
}