
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';

class SeekerViewCompanyController extends GetxController {

  final _api = SeekerRepository();

  RxBool loading = false.obs;
  RxString error = ''.obs;
  var companyData = ViewRecruiterProfileModel().obs ;
  final rxRequestStatus = Status.LOADING.obs ;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> viewCompany(
     String? recruiterID
      ) async{
    setRxRequestStatus(Status.LOADING) ;
    var data = {};
    data.addIf(recruiterID != null && recruiterID.toString().length != 0 , 'recruiter_id' , recruiterID) ;
    print(data);

    _api.seekerViewCompanyDetail(data).then((value){
      setRxRequestStatus(Status.COMPLETED) ;
      if(value.status!){
        companyData(value) ;
        print("this is value ==== $value") ;
      }
    }).onError((error, stackTrace){
      setRxRequestStatus(Status.ERROR) ;
      setError(error.toString()) ;
      print(error);
    });
  }
}