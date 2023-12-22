
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:get/get.dart';

import '../SeekerViewCompanyController/SeekerViewCompanyController.dart';

class SeekerPostReviewController extends GetxController {

  final _api = SeekerRepository();
  RxBool loading = false.obs;
  var errorMessage = "".obs ;
  SeekerViewCompanyController seekerViewCompanyController = Get.put(SeekerViewCompanyController()) ;

  postReview( String? recruiterID , String? review , String? rating) async{
    loading(true) ;
    var data =  {};

    data.addIf(recruiterID != null && recruiterID.length != 0 , 'recruiter_id' , "$recruiterID" ) ;
    data.addIf(review != null && review.length != 0 , 'discription' , "$review" ) ;
    data.addIf(rating != null && rating.length != 0 , 'stars' , "$rating" ) ;

    _api.seekerPostReview(data).then((value){
      loading(false) ;
      if(value.status!){
        Get.back() ;
        seekerViewCompanyController.viewCompany(recruiterID) ;
        Utils.toastMessage('Post saved') ;
      }
    }).onError((error, stackTrace){
      print(error);
      loading(false) ;
      // Get.back() ;
    }) ;
  }
}