
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Job Seeker/Role_Choose/choose_skills.dart';


class SeekerChoosePositionController extends GetxController {

  final _api = AuthRepository();

  final positioncontroller = TextEditingController().obs;

  RxBool loading = false.obs;
  var errorMessage = "".obs ;

  Future<void> seekerChoosePositionApiHit(
      var id ,
      BuildContext context

      ) async {
    print("$id");
    loading.value = true ;
    print(loading.value);
    Map data = {
      'position_id' :id.toString(),
    };
    print(data);

    SharedPreferences sp = await SharedPreferences.getInstance() ;
    _api.SeekerChoosePositionApi(data).then((value){
      loading.value = false ;
      print(value);
      sp.setInt("step", 2) ;
      print("dataaaaa");
      // Utils.snackBar( "Message",value.message.toString());

      Get.to(() => const ChooseSkills());
    }).onError((error, stackTrace){
      print(error);
      loading.value = false ;
      // Utils.snackBar('Failed',error.toString());
      Utils.showApiErrorDialog(context, error.toString()) ;
    });
  }
}