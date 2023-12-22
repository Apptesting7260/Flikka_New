import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ShowBankDetailsController/ShowBankDetailsController.dart';
import '../controllers/ShowBankDetailsController/ShowBankDetailsController.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
class ShowBankAccountDetail extends StatefulWidget {
  const ShowBankAccountDetail({super.key});

  @override
  State<ShowBankAccountDetail> createState() => _ShowBankAccountDetailState();
}

class _ShowBankAccountDetailState extends State<ShowBankAccountDetail> {

  ShowBankDetailsController ShowBankDetailsControllerInstanse = Get.put(
      ShowBankDetailsController());

  @override
  void initState() {
    super.initState();
    ShowBankDetailsControllerInstanse.showBankDetailsApi();
  }


  final bankController = TextEditingController();
  final nameController = TextEditingController();
  final branchController = TextEditingController();
  final acNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (ShowBankDetailsControllerInstanse
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (ShowBankDetailsControllerInstanse
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),)
            ;
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {}),)
            ;
          }
        case Status.COMPLETED:
          return
            SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  //title: Text("Request Withdraw", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                  toolbarHeight: 75,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset('assets/images/icon_back_blue.png')),
                  ),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     // SizedBox(height: Get.height * .04,),
                      Text("Bank account details", style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,),
                      SizedBox(height: Get.height * .03,),
                      CommonWidgets.textFieldHeading(context, 'Bank'),
                      SizedBox(height: Get.height * .01,),
                      TextFormField(
                        controller: bankController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: ShowBankDetailsControllerInstanse
                              .viewShowBankDetails.value.bankDetails!.bankName,
                          hintStyle: TextStyle(fontSize: 14.0, color: Color
                              .fromRGBO(255, 255, 255, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          fillColor: Color(0xff373737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                          ),

                        ),
                      ),
                      SizedBox(height: Get.height * .04,),
                      CommonWidgets.textFieldHeading(
                          context, 'Account Holder Name'),
                      SizedBox(height: Get.height * .01,),
                      TextFormField(
                        controller: bankController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: ShowBankDetailsControllerInstanse
                              .viewShowBankDetails.value.bankDetails!
                              .accountHolder,
                          hintStyle: TextStyle(fontSize: 14.0, color: Color
                              .fromRGBO(255, 255, 255, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          fillColor: Color(0xff373737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                          ),

                        ),
                      ),
                      SizedBox(height: Get.height * .04,),
                      CommonWidgets.textFieldHeading(context, 'Branch Code'),
                      SizedBox(height: Get.height * .01,),
                      TextFormField(
                        controller: bankController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: ShowBankDetailsControllerInstanse
                              .viewShowBankDetails.value.bankDetails!
                              .branchCode,
                          hintStyle: TextStyle(fontSize: 14.0, color: Color
                              .fromRGBO(255, 255, 255, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          fillColor: Color(0xff373737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                          ),

                        ),
                      ),
                      SizedBox(height: Get.height * .04,),
                      CommonWidgets.textFieldHeading(context, 'Account Number'),
                      SizedBox(height: Get.height * .01,),
                      TextFormField(
                        controller: bankController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: ShowBankDetailsControllerInstanse
                              .viewShowBankDetails.value.bankDetails!
                              .accountNumber,
                          hintStyle: TextStyle(fontSize: 14.0, color: Color
                              .fromRGBO(255, 255, 255, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          fillColor: Color(0xff373737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                          ),

                        ),
                      ),
                      SizedBox(height: Get.height * .04,),
                      CommonWidgets.textFieldHeading(context, 'IFSC Code'),
                      TextFormField(
                        controller: bankController,
                        readOnly: true,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: ShowBankDetailsControllerInstanse
                              .viewShowBankDetails.value.bankDetails!.ifscCode,
                          hintStyle: TextStyle(fontSize: 14.0, color: Color
                              .fromRGBO(255, 255, 255, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 17, horizontal: 15),
                          fillColor: Color(0xff373737),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                          ),

                        ),
                      ),
                      SizedBox(height: Get.height * .04,),
                      Center(
                        child: MyButton(
                          height: Get.height * .08,
                          width: Get.width * .75,
                          title: "EDIT", onTap1: () {

                        },),
                      ),
                      SizedBox(height: Get.height * .02,),
                      Center(
                        child: Container(
                          height: Get.height * .08,
                          width: Get.width * .75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: Text("ADD NEW BANK", style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * .1,),
                    ],
                  ),
                ),
              ),
            );
      }
    });
  }
}