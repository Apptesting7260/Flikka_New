import 'package:flikka/data/response/status.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../ViewSeekerProfileController/ViewSeekerProfileController.dart';

class AvtarImageController extends GetxController {

  final _api = SeekerRepository();
  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;
  var loading = false.obs ;

  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;

 Future<bool>  avtarImageApiData ( BuildContext context , String? avtarImage) async {
    loading(true) ;
    var data = {} ;
    data.addIf(avtarImage != null && avtarImage.length != 0 , "avtar_img" , avtarImage ) ;

    setRxRequestStatus(Status.LOADING);
  return await _api.avtarImageApi(data).then((value) {
      setRxRequestStatus(Status.COMPLETED);

      seekerProfileController.viewSeekerProfileApi();
      loading(false);
      Get.back() ;
      if (kDebugMode) {
        print(value);
      }
      return true ;
    }).onError((error, stackTrace){
      loading(false) ;

      setError(error.toString());
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
      Utils.showMessageDialog(context, "oops! something went wrong") ;
      setRxRequestStatus(Status.ERROR);
      return false ;
    });
  }
}