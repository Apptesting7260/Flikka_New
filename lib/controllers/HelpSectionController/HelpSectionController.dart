import 'dart:convert';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class HelpSectionControoler extends GetxController {

  final _api = AuthRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

  var countryName = "".obs ;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> topicController = TextEditingController().obs;
  Rx<TextEditingController> subjectController = TextEditingController().obs;
  Rx<TextEditingController> questionController = TextEditingController().obs;

  void helpSectionApi(
      BuildContext context ,
      String? email,
      String? country,
      String? topic,
      String? subject,
      String? question,
      ){
    var data = {} ;
    data.addIf(email != null  , "email" , jsonEncode(email) ) ;
    data.addIf(country != null , "country" ,country ) ;
    data.addIf(topic != null  , "topic" ,topic ) ;
    data.addIf(subject != null  , "subject" ,subject ) ;
    data.addIf(question != null  , "questions" ,question ) ;

    loading(true);
    _api.helpApi(data).then((value){
      loading(false);
      if(value.status!){
        Get.back() ;
        // Get.back() ;
        //  Utils.showMessageDialog(context, "Help data add successfully") ;
      }
    }).onError((error, stackTrace){
      setError(error.toString());
      loading(false);
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      // Utils.showMessageDialog(context, "Oops Something went wrong") ;
      setRxRequestStatus(Status.ERROR);
    });
  }
}