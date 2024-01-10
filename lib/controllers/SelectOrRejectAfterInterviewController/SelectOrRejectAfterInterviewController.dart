
import 'package:flikka/models/OnboardingModel/OnboardingModel.dart';
import 'package:flikka/models/SelectOrRejectAfterInterviewModel/SelectOrRejectAfterInterviewModel.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/response/status.dart';

class SelectOrRejectAfterInterviewController extends GetxController {
  final _api = AuthRepository();

  final rxRequestStatus = Status.LOADING.obs ;
  RxString error = ''.obs;

  String ?amount;
  RxBool loading = false.obs;

  final getSelectOrRejectAfterInterviewDetails =SelectOrRejectAfterInterviewModel().obs ;

  Future<void> selectOrRejectAfterInterviewApiHit(
      String? requestID ,
      String? interviewStatus ,
      BuildContext context
      ) async {
    CommonFunctions.showLoadingDialog(context, "Updating...") ;
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading.value = true ;
    Map data = {};
    data.addIf(requestID != null && requestID.length != 0 , "request_id" , requestID ) ;
    data.addIf(interviewStatus != null && interviewStatus.length != 0 , "interview_status" , interviewStatus ) ;
    print(data);
    print(amount) ;
    _api.selectOrRejectInterviewApi(data).then((value){
      loading.value = false ;
      print(value);

      if(value.status == true) {
        Get.back() ;
      }else if(value.status == false) {
        // paymentDialog(context) ;
      }
      Get.back() ;
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      Get.back() ;
      // Utils.snackBar('Failed',error.toString());
    });
  }
// paymentDialog(BuildContext context) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(22),
//         ),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//         child:  Padding(
//           padding: const EdgeInsets.all(28.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: Text("message: You can only make one withdrawal request per month",style: Theme.of(context).textTheme.titleSmall,)) ,
//               const SizedBox(height: 15,) ,
//               Center(
//                 child: MyButton(
//                   width: Get.width*.3,
//                   height: Get.height*.055,
//                   title: "Ok", onTap1: () {
//                   Get.back() ;
//                 },),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}