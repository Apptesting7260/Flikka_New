
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/CompanyListModel/CompanyListModel.dart';
import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CompaniesListController extends GetxController {

  final _api = SeekerRepository();

  RxBool showCompanies = false.obs ;
  final rxRequestStatus = Status.LOADING.obs ;
  final getCompaniesList = CompanyListModel().obs ;
  RxList<CompanyList>? companies = <CompanyList>[].obs  ;
  RxString error = ''.obs;
  var loading = false.obs ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void companiesData(CompanyListModel _value) => getCompaniesList.value = _value ;
  void setError(String _value) => error.value = _value ;


  Future<void> getCompaniesApi() async {
    setRxRequestStatus(Status.LOADING);
    _api.companiesListApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      getCompaniesList(value);
      companies?.value = value.companyList! ;

      print(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      print(error.toString());

      setRxRequestStatus(Status.ERROR);

    });
  }

  filterList(String? query) {
    if(getCompaniesList.value.companyList != null ) {
      debugPrint("called") ;
      debugPrint(companies.toString()) ;
      companies?.value = getCompaniesList.value.companyList!.where((element) =>
    element.companyName!.toLowerCase().contains(query!.toLowerCase())).toList() ;
    }

    // getCompaniesList.value.companyList!.map((element) {
    //   if(element.companyName != null) {
    //         element.companyName!.toLowerCase().contains(query!.toLowerCase()) ;
    //   }
    //     element.companyName!.toLowerCase().contains(query!.toLowerCase());}) ;
    // positionsList?.value = getCompaniesList.value.data!.where((element) =>
    //     element.positions!.toLowerCase().contains(query!.toLowerCase())).toList() ;
  }

  // Future<void> refreshApi() async {
  //   loading(true) ;
  //   var sp = await SharedPreferences.getInstance() ;
  //   print(sp.getString("BarrierToken")) ;
  //   _api.seekerGetPositions().then((value){
  //     loading(false) ;
  //     seekerChoosePositionGetList(value);
  //     positionsList?.value = seekerChoosePositionGetList.value.data! ;
  //
  //     print(value);
  //
  //   }).onError((error, stackTrace){
  //     loading(false) ;
  //     setError(error.toString());
  //     print(error.toString());
  //   });
  // }
}