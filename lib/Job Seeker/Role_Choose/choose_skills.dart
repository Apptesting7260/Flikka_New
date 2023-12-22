
import 'package:flikka/controllers/SeekerChooseSkillsController/SeekerChooseSkillsController.dart';
import 'package:flikka/controllers/SkipStepController/SkipStepController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/RangeSlider.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/SeekerGetAllSkillsController/SeekerGetAllSkillsController.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';

class ChooseSkills extends StatefulWidget {
  const ChooseSkills({Key? key}) : super(key: key);

  @override
  State<ChooseSkills> createState() => _ChooseSkillsState();
}

class _ChooseSkillsState extends State<ChooseSkills> {
  List _selectedChooseSkillsIndices = [];
  List _selectedChoosePassionSkills =[];
  List _selectedChoosepreferenceSkills =[];
  List _selectedChoosestrengthsSkills =[];
  List _selectedChooseworkingSkills =[];
  List _selectedChooseAvailabilitySkills =[];
  var choose=1;
  var selectedSalary ;

  SeekerGetAllSkillsController seekerGetAllSkillsController = Get.put(SeekerGetAllSkillsController()) ;
  SeekerChooseSkillsController seekerChooseSkillsController = Get.put(SeekerChooseSkillsController()) ;
  SkipStepController skipStepController = Get.put(SkipStepController()) ;


  @override
  void initState() {
    seekerGetAllSkillsController.seekerGetAllSkillsApi() ;
    RangePicker.minValue = 5000.0 ;
    RangePicker.maxValue = 10000.0 ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (seekerGetAllSkillsController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (seekerGetAllSkillsController
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {
                seekerGetAllSkillsController.seekerGetAllSkillsApi() ;
              },
            ),)
            ;
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {
                  seekerGetAllSkillsController.seekerGetAllSkillsApi() ;
                }),)
            ;
          }
        case Status.COMPLETED:
          return SafeArea(
              child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 40) {
                        print("object") ;
                      seekerGetAllSkillsController.refreshApi() ;
                      }
                    },
                    child:  Container(
                        height: Get.height,
                        width: Get.width,
                        // margin: seekerGetAllSkillsController.refreshLoading.value ? const EdgeInsets.only(top : 100) : EdgeInsets.zero,
                        decoration: const BoxDecoration(color: AppColors.blueThemeColor),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: Get.height * .020,),
                            Obx(() =>
                            seekerGetAllSkillsController.refreshLoading.value ?
                            const Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            ),)
                                : const SizedBox()
                            ),
                            SizedBox(height: Get.height * .020,),
                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .07),
                                  child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Image.asset(
                                        "assets/images/icon_back.png",
                                        height: Get.height * .055,)),
                                ),
                                TextButton(onPressed: (){
                                  skipStepController.skipStepApi(2) ;
                                 CommonFunctions.showLoadingDialog(context, "Skipping") ;
                                },
                                    child: const Text("Skip",
                                      style: TextStyle(color: Colors.white ,
                                          fontSize: 16),))
                              ],
                            ),
                            SizedBox(height: Get.height * .02,),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .07),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Choose Skills", style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                      fontSize: 30, fontWeight: FontWeight.w700),)),
                            ),
                            SizedBox(height: Get.height * .02,),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .07),
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w400,
                                    color: Color(0xffFFFFFF)),),
                            ),
                            SizedBox(height: Get.height * .05,),
                          ],
                        ),
                      ),

                  ),
                  Obx( () =>
                     DraggableScrollableSheet(
                        initialChildSize:  seekerGetAllSkillsController.refreshLoading.value ? 0.65 : 0.71,
                         minChildSize: seekerGetAllSkillsController.refreshLoading.value ? 0.65 : 0.71,// half screenscreen
                        maxChildSize: 1, // full screen
                        builder: ( context,  ScrollController scrollController ) {
                          return Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),),
                                color: Colors.black),
                            // color: Colors.black,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              children:  [Container(
                                // height: Get.height,
                                // width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xff000000),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height * .03,),
                                      Obx(() => seekerChooseSkillsController.errorMessage.value.isEmpty ?
                                      const SizedBox() :  Center(
                                        child: Text(seekerChooseSkillsController.errorMessage.value,
                                          style: const TextStyle(color: Colors.red),),
                                      )) ,
                                      SizedBox(height: Get.height * .03,),
                                      Text("Soft Skills", style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall,),
                                      SizedBox(height: Get.height * .01,),
                                      Obx( () =>
                                        GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount: seekerGetAllSkillsController
                                              .seekerGetAllSkillsData.value.softSkill
                                              ?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var data = seekerGetAllSkillsController
                                                .seekerGetAllSkillsData.value
                                                .softSkill?[index] ;
                                            final isSelected = _selectedChooseSkillsIndices
                                                .contains("${data?.id.toString()}");
                                            final borderColor = isSelected ? Color(
                                                0xff56B6F6) : Color(0xffFFFFFF);

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChooseSkillsIndices
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChooseSkillsIndices
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChooseSkillsIndices
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(index);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelected ?  AppColors.blueThemeColor : const Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                                color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(Icons.check,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              size: 15,),
                                                          ),
                                                          if (!_selectedChooseSkillsIndices
                                                              .contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                        "${data?.skills}",
                                                      overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          color: isSelected ?AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .02,),
                                      Text("Passion", style: Theme.of(context).textTheme.displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      Obx( () =>
                                        GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount:  seekerGetAllSkillsController.seekerGetAllSkillsData.value.passion?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.passion?[index] ;
                                            final isSelectedPassion = _selectedChoosePassionSkills.contains("${data?.id.toString()}");
                                            //final isSelected = _selectedChooseSkillsIndex == index;

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChoosePassionSkills
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChoosePassionSkills
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChoosePassionSkills
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(data?.id.toString());
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelectedPassion ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                               color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(Icons.check,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              size: 15,),
                                                          ),
                                                          if (!_selectedChoosePassionSkills
                                                              .contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                        "${data?.passion}",
                                                       overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: isSelectedPassion ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .02,),
                                      Text("Industry Preference", style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      Obx( () =>
                                        GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount:  seekerGetAllSkillsController
                                              .seekerGetAllSkillsData.value.industry
                                              ?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {

                                            var data =  seekerGetAllSkillsController
                                                .seekerGetAllSkillsData.value.industry?[index] ;
                                            final isSelectedpreference = _selectedChoosepreferenceSkills.contains("${data?.id.toString()}");
                                            //final isSelected = _selectedChooseSkillsIndex == index;

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChoosepreferenceSkills
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChoosepreferenceSkills
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChoosepreferenceSkills
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(index);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelectedpreference ?  AppColors.blueThemeColor : Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                                color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(Icons.check,
                                                              color: Color(0xffFFFFFF), size: 15,),
                                                          ),
                                                          if (!_selectedChoosepreferenceSkills.contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                        "${data?.industryPreferences}" , overflow: TextOverflow.ellipsis, style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: isSelectedpreference ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .02,),
                                      Text("Strengths", style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      Obx( () =>
                                      GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount:  seekerGetAllSkillsController.seekerGetAllSkillsData.value.strengths?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var data =  seekerGetAllSkillsController
                                                .seekerGetAllSkillsData.value.strengths?[index] ;
                                            final isSelectedstrengths = _selectedChoosestrengthsSkills
                                                .contains("${data?.id.toString()}");
                                            //final isSelected = _selectedChooseSkillsIndex == index;

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChoosestrengthsSkills
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChoosestrengthsSkills
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChoosestrengthsSkills
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(data?.id.toString() );
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelectedstrengths ?  AppColors.blueThemeColor : const Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                                color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(Icons.check,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              size: 15,),
                                                          ),
                                                          if (!_selectedChoosestrengthsSkills
                                                              .contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                        "${data?.strengths}",
                                                       overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: isSelectedstrengths ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .02,),
                                      Text("Salary Expectation", style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      SizedBox( height: Get.height * 0.1 ,child:
                                      RangePicker(maxSalary: double.tryParse(seekerGetAllSkillsController.seekerGetAllSkillsData.value.salaryExpectation![0].salaryExpectation.toString()),)) ,
                                      SizedBox(height: Get.height * .02,),
                                      Text("When Can I Start Working?", style: Theme.of(context).textTheme.displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      Obx( () =>
                                         GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount:  seekerGetAllSkillsController
                                              .seekerGetAllSkillsData.value.startWork
                                              ?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {

                                            var data =  seekerGetAllSkillsController
                                                .seekerGetAllSkillsData.value.startWork?[index] ;
                                            final isSelectedWorking = _selectedChooseworkingSkills
                                                .contains("${data?.id.toString()}");
                                            //final isSelected = _selectedChooseSkillsIndex == index;
                                              return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChooseworkingSkills
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChooseworkingSkills
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChooseworkingSkills.clear() ;
                                                      _selectedChooseworkingSkills
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(index);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelectedWorking ? AppColors.blueThemeColor : Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                                color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(Icons.check,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              size: 15,),
                                                          ),
                                                          if (!_selectedChooseworkingSkills
                                                              .contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                         "${data?.startWork}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight.w700,
                                                          color: isSelectedWorking ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .02,),
                                      Text("Availability", style: Theme
                                          .of(context)
                                          .textTheme
                                          .displaySmall),
                                      SizedBox(height: Get.height * .02,),
                                      Obx( () =>
                                         GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 65),
                                          itemCount:  seekerGetAllSkillsController.seekerGetAllSkillsData.value.availabity?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.availabity?[index] ;
                                            final isSelectedAvailability = _selectedChooseAvailabilitySkills
                                                .contains("${data?.id.toString()}");
                                            //final isSelected = _selectedChooseSkillsIndex == index;

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * .02,
                                                  vertical: Get.height * .01),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (_selectedChooseAvailabilitySkills
                                                        .contains("${data?.id.toString()}")) {
                                                      _selectedChooseAvailabilitySkills
                                                          .remove("${data?.id.toString()}");
                                                    } else {
                                                      _selectedChooseAvailabilitySkills
                                                          .add("${data?.id.toString()}");
                                                    }
                                                    print(index);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(35),
                                                      border: Border.all(
                                                          color: isSelectedAvailability ?  AppColors.blueThemeColor : Color(0xffFFFFFF))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: Get.width * .06,
                                                            height: Get.height * .05,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                                color: AppColors.blueThemeColor
                                                            ),
                                                            child: const Icon(
                                                              Icons.check,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              size: 15,),
                                                          ),
                                                          if (!_selectedChooseAvailabilitySkills
                                                              .contains("${data?.id.toString()}"))
                                                            Center(
                                                              child: Container(
                                                                width: Get.width *
                                                                    .05,
                                                                height: Get.width *
                                                                    .05,
                                                                decoration: const BoxDecoration(
                                                                  color: Color(
                                                                      0xff000000),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * .02,),
                                                      Expanded(child: Text(
                                                        "${data?.availabity}",
                                                      overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .labelLarge
                                                            ?.copyWith(
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: isSelectedAvailability ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },),
                                      ),
                                      SizedBox(height: Get.height * .06,),
                                      Obx( () => Center(
                                        child: MyButton(
                                          title: "CONTINUE",
                                          loading: seekerChooseSkillsController.loading.value,
                                          onTap1: () {
                                            selectedSalary = "${RangePicker.minValue.toInt()} - ${RangePicker.maxValue.toInt()}" ;
                                            debugPrint("this is =========== $selectedSalary") ;
                                            seekerChooseSkillsController.errorMessage.value = "" ;
                                            if(_selectedChooseSkillsIndices.isEmpty ||
                                                _selectedChoosestrengthsSkills.isEmpty ||
                                                _selectedChoosePassionSkills.isEmpty ||
                                                _selectedChoosepreferenceSkills.isEmpty ||
                                                selectedSalary == null ||
                                                _selectedChooseworkingSkills.isEmpty ||
                                                _selectedChooseAvailabilitySkills.isEmpty
                                            ) {
                                              seekerChooseSkillsController.errorMessage.value = "Please select at least 1 field from each section" ;
                                            } else {
                                              if(seekerChooseSkillsController.loading.value){} else{
                                                seekerChooseSkillsController
                                                  .seekerSkillsApi(
                                                  _selectedChooseSkillsIndices,
                                                  _selectedChoosestrengthsSkills,
                                                  _selectedChoosePassionSkills,
                                                  _selectedChoosepreferenceSkills,
                                                  RangePicker.minValue.toInt() ,
                                                  RangePicker.maxValue.toInt() ,
                                                  _selectedChooseworkingSkills,
                                                  _selectedChooseAvailabilitySkills);
                                              }
                                            }
                                            if( seekerChooseSkillsController.errorMessage.value.isNotEmpty) {
                                                scrollController.animateTo(
                                                  scrollController.position.minScrollExtent,
                                                  curve: Curves.easeOut,
                                                  duration: const Duration(milliseconds: 100),
                                                );
                                            }
                                          },),
                                      ),
                                      ),
                                      SizedBox(height: Get.height * .1,),
                                    ],
                                  ),
                                ),
                              ),
                          ]
                            ),
                          );}
                    ),
                  ),
                ],
              ),
            ),
          ));
      }
    } );
  }
}
