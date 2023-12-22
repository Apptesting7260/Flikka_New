
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/controllers/SeekerReferalController/SeekerReferralController.dart';
import 'package:flikka/repository/Auth_Repository.dart';
import 'package:flikka/res/components/request_timeout_widget.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Job Seeker/Role_Choose/import_cv.dart';
import '../../Job Seeker/Role_Choose/location_pop_up.dart';
import '../../Job Seeker/Authentication/sign_up.dart';
import '../../data/response/status.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class SignUpController extends GetxController {

  final _api = AuthRepository();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  var errorMessage = "".obs ;
  RxString error = ''.obs;
  final rxRequestStatus = Status.COMPLETED.obs ;
  void setError(String _value) => error.value = _value ;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;

  RxBool loading = false.obs;
  String ? id;
  var role ;
  Future<void> signUpApiHit(
      var role ,
      BuildContext context
      ) async {
    setRxRequestStatus(Status.LOADING);
    loading.value = true ;
    this.role = role ;
    var sp = await SharedPreferences.getInstance() ;

    Map data = {
      'email' : sp.getString("email"),
      'password' : sp.getString("password"),
      'name' : sp.getString("name"),
      "role" : "$role"
    };
    _api.SignUpApi(data).then((value){
      setRxRequestStatus(Status.COMPLETED);
      loading.value = false ;
      print("this is status ====== ${value.status}");
      print("this is role ======================== $role") ;

       id = value.id.toString();
       if(value.status){
         sp.setString("BarrierToken", value.token) ;
         if(role == 0) {
           sp.setString("loggedIn" , "seeker") ;
         }else{
           sp.setString("loggedIn" , "recruiter") ;
         }

         sp.setInt("step", 1) ;
         showReferralCodeDialog(context) ;
       }else{
         errorMessage.value = value.message.toString() ;
       }

    }).onError((error, stackTrace){
      print('********************************');
      print(error);
      loading.value = false ;
       Utils.showApiErrorDialog(context, error.toString()) ;
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void showReferralCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          //********** you can't define any value because this is auto value padding added *********
          //insetPadding: EdgeInsets.all(20),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Get.height * 0.02),
                Text(
                  'Thank you for signing up.',
                  style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  'Do you have a Referral Code',
                  style: Get.theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                ),
                SizedBox(height: Get.height * 0.04),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.06,
                          child: MyButton(onTap1: () {
                            showReferralSubmissionDialog(context) ;
                          }, title: 'YES', style: Get.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),),
                        ),
                      ),
                      const SizedBox(width: 20), // Adding spacing between buttons
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                            onPressed: () {
                             Get.off(() => LocationPopUp( role: role )) ;
                            },
                            child: Text(
                              'NO',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  void showReferralSubmissionDialog(BuildContext context) {
    SeekerReferralController seekerReferralController = Get.put(SeekerReferralController()) ;
    var controller = TextEditingController() ;
    var _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog( backgroundColor: Colors.transparent,
        // const Color(0xff353535),
          contentPadding: EdgeInsets.zero,
          //********** you can't define any value because this is auto value padding added *********
          //insetPadding: EdgeInsets.all(20),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.blueThemeColor,
                            borderRadius: BorderRadius.circular(12),),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),),
                      ],
                      ),
                    )],),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Color.fromRGBO(52, 52, 52, 1), borderRadius: BorderRadius.circular(12),),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Referral Code',
                        style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      TextFormField(
                        controller: controller,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: const Color(0xff454545),
                            hintText: "Enter Referral Code",
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(color: Color(0xff353535)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xffCFCFCF)),
                            contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Obx( () => Center(
                          child: MyButton(title: "SUBMIT",
                            loading: seekerReferralController.loading.value,
                            onTap1: () {
                            if(_formKey.currentState!.validate()) {
                              seekerReferralController.referralApi(controller.text, role,context) ;
                            }
                          },),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

}