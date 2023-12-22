
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/SignUPController/SignUpController.dart';


class ChooseRole extends StatefulWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  SignUpController signUpController = Get.put(SignUpController()) ;

  var choose = 1;
  bool _jobSeekerCheckBoxValue = true;
  bool _recruiterCheckBoxValue = false;

  void _toggleJobSeekerCheckbox(){
    setState(() {
      _jobSeekerCheckBoxValue = true;
      _recruiterCheckBoxValue = false;
      choose=1;
    });
  }

  void _toggleRecruiterCheckbox() {
    setState(() {
      _jobSeekerCheckBoxValue = false;
      _recruiterCheckBoxValue = true;
      choose=2;
    });
  }
  var role = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: AppColors.blueThemeColor
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.1,),
                    Center(
                      child: Text("Choose Your Role",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30)),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.8,
                        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry..",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                    SizedBox(height: Get.height*.1),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.72, // half screen
                minChildSize: 0.72, // half screen
                maxChildSize: 0.72, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child:   SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33.0),
                            topRight: Radius.circular(33.0),
                          ),
                        ),
                        child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04),
                            child:Column(
                              children: [
                                SizedBox(height: Get.height*.05,),
                                Obx(() =>
                                signUpController.errorMessage.value.isEmpty ? const SizedBox()
                                    : Text(signUpController.errorMessage.value ,
                                  style: TextStyle(color: Colors.red),) ),
                                SizedBox(height: Get.height*.05,),
                                GestureDetector(
                                  onTap: (){_toggleJobSeekerCheckbox();
                                  setState(() {
                                    role = 0;
                                  });},
                                  child: Container(
                                    height: Get.height * 0.083,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:choose==1? Color(0xff4D6FED):Color(0xffFFFFFF)),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                                            child: Text(
                                              'I am a Job Seeker',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(color: choose ==1?AppColors.blueThemeColor:Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          value: _jobSeekerCheckBoxValue,
                                          onChanged: (val) {
                                            setState(() {
                                              role = 0;
                                              _toggleJobSeekerCheckbox();
                                              //rolType=1;
                                            });
                                          },
                                          // fillColor: MaterialStateProperty.all(Color(0xff56B8F6)),
                                          checkColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: AppColors.blueThemeColor)),
                                          activeColor: AppColors.blueThemeColor,
                                          side: const BorderSide(
                                              width: 2 ,
                                              color: AppColors.blueThemeColor
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.03),
                                GestureDetector(
                                  onTap:(){
                                    _toggleRecruiterCheckbox();
                                    role = 1;
                                    // print(rolType);
                                  } ,
                                  child: Container(
                                    height: Get.height * 0.083,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(color:choose==2?const Color(0xff4D6FED):const Color(0xffFFFFFF)),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                                            child: Text(
                                              'I am a Employer',
                                              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500,color: choose==2? AppColors.blueThemeColor:Colors.white),
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          value: _recruiterCheckBoxValue,
                                          onChanged: (value) {
                                            _toggleRecruiterCheckbox();
                                            role = 1;

                                          },
                                          // fillColor: MaterialStateProperty.all(Color(0xff56B8F6)),
                                          checkColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: AppColors.blueThemeColor)),
                                          activeColor: AppColors.blueThemeColor,
                                          side: const BorderSide(
                                            width: 2 ,
                                            color: AppColors.blueThemeColor,
                                          ),
                                        ),

                                        const SizedBox(width: 16.0),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height*.04,),
                                Obx(() =>   Center(

                                  child: MyButton(
                                      loading: signUpController.loading.value,
                                      title: "SIGN UP",
                                      onTap1: () {
                                        if(signUpController.loading.value) {}
                                        else {
                                          signUpController.signUpApiHit(role , context );
                                        }
                                      }
                                  ),
                                ),) ,
                              ],
                            )

                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

        ));
  }
}


