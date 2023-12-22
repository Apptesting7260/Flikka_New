
import 'package:flikka/Job%20Seeker/Role_Choose/import_cv.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/location_pop_up.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';


class SeekerReferralController extends GetxController {

  final _api = AuthRepository();

  RxBool loading = false.obs;


   referralApi(
      var referralCode ,
      var role ,
       context
      )  {
    loading.value = true ;
    Map data = {
      'referral_code' : referralCode,
      'role' :role.toString()
    };
    _api.seekerReferral(data).then((value){
      loading.value = false ;
      print(value);
      if(value.status == true){
        Get.off(() => LocationPopUp(role: role )) ;
      } else if(value.status == false) {
        Utils.showMessageDialog(context, value.message.toString()) ;
      }
      // Utils.snackBar( "Message",value.message.toString());
    }).onError((error, stackTrace){
      Utils.showMessageDialog(context, "Something went wrong") ;
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
      // Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }
}