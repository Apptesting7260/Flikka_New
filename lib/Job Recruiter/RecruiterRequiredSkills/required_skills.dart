import 'package:flikka/controllers/RequiredSkillsController/RequiredSkillsController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/SeekerGetAllSkillsController/SeekerGetAllSkillsController.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/RangeSlider.dart';


// class RequiredSkills extends StatefulWidget {
//   final RecruiterJobsData? recruiterJobsData ;
//   const RequiredSkills({super.key, this.recruiterJobsData});
//
//   @override
//   State<RequiredSkills> createState() => _RequiredSkillsState();
// }
//
// class _RequiredSkillsState extends State<RequiredSkills> {
//   List _selectedChooseSkillsIndices = [];
//   List _selectedChoosePassionSkills =[];
//   List _selectedChoosepreferenceSkills =[];
//   List _selectedChoosestrengthsSkills =[];
//   List _selectedChooseworkingSkills =[];
//   List _selectedChooseAvailabilitySkills =[];
//   RxString error = ''.obs;
//   var choose=1;
//   var selectedSalary ;
//        SeekerGetAllSkillsController seekerGetAllSkillsController = Get.put(SeekerGetAllSkillsController()) ;
//        RequiredSkillsController requiredSkillsController = Get.put(RequiredSkillsController()) ;
//        ScrollController scrollController = ScrollController() ;
//   @override
//   void initState() {
//     seekerGetAllSkillsController.seekerGetAllSkillsApi() ;
//     RangePicker.minValue = 5000.0 ;
//     RangePicker.maxValue = 10000.0 ;
//     if(widget.recruiterJobsData?.jobsDetail?.skillName != null){
//       _selectedChooseSkillsIndices = widget.recruiterJobsData?.jobsDetail?.skillName?.map((e) => e.id.toString()).toList() ?? [];
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.availabityName != null){
//       _selectedChooseAvailabilitySkills = widget.recruiterJobsData?.jobsDetail?.availabityName?.map((e) => e.id.toString()).toList() ?? [];
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.passionName != null){
//       _selectedChoosePassionSkills = widget.recruiterJobsData?.jobsDetail?.passionName?.map((e) => e.id.toString()).toList() ?? [] ;
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.industryPreferenceName != null){
//       _selectedChoosepreferenceSkills = widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.map((e) => e.id.toString()).toList() ?? [] ;
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.strengthsName != null){
//       _selectedChoosestrengthsSkills = widget.recruiterJobsData?.jobsDetail?.strengthsName?.map((e) => e.id.toString()).toList() ?? [];
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.startWorkName != null){
//       _selectedChooseworkingSkills = widget.recruiterJobsData?.jobsDetail?.startWorkName?.map((e) => e.id.toString()).toList() ?? [] ;
//     }
//     if(widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation != null) {
//       RangePicker.minValue = double.tryParse('${widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation}') ?? 5000.0 ;
//       RangePicker.maxValue = double.tryParse('${widget.recruiterJobsData?.jobsDetail?.maxSalaryExpectation}') ?? 10000.0 ;
//     }
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx( () {
//       switch (seekerGetAllSkillsController
//           .rxRequestStatus.value) {
//       case Status.LOADING:
//       return const Scaffold(
//       body: Center(
//       child: CircularProgressIndicator()),
//       );
//
//       case Status.ERROR:
//       if (seekerGetAllSkillsController
//           .error.value ==
//       'No internet') {
//       return Scaffold(body: InterNetExceptionWidget(
//       onPress: () {},
//       ),)
//       ;
//       } else {
//       return Scaffold(body: GeneralExceptionWidget(
//       onPress: () {}),)
//       ;
//       }
//       case Status.COMPLETED:
//       return SafeArea(
//         child: Scaffold(
//           body: Stack(
//            children: [
//              SingleChildScrollView(
//                physics: NeverScrollableScrollPhysics(),
//                child: GestureDetector(
//                  onVerticalDragUpdate: (details) {
//                    if (details.delta.dy > 40) {
//                      print("object") ;
//                      seekerGetAllSkillsController.refreshApi() ;
//                    }
//                  },
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      SizedBox(height: Get.height * .025,),
//                      Obx(() => seekerGetAllSkillsController.refreshLoading.value ?
//                      const Center(
//                        child: CircularProgressIndicator(
//                          color: Colors.white,
//                        ),
//                      ):const SizedBox()) ,
//
//                      Padding(
//                        padding: EdgeInsets.symmetric(
//                            horizontal: Get.width * .03),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Row(
//                              children: [
//                                SizedBox(height: Get.height * .05,),
//                                GestureDetector(
//                                    onTap: () {
//                                      Get.back();
//                                    },
//                                    child: Image.asset(
//                                      "assets/images/icon_back_blue.png",
//                                      height: Get.height * .05,)),
//                                SizedBox(width: Get.width * .04,),
//                                Text("Required Skills", style: Theme
//                                    .of(context)
//                                    .textTheme
//                                    .headlineSmall
//                                    ?.copyWith(fontWeight: FontWeight.w700),),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                      Container(
//                        decoration: const BoxDecoration(
//                            borderRadius: BorderRadius.only(
//                              topRight: Radius.circular(30),
//                              topLeft: Radius.circular(30),),
//                            color: Colors.black),
//                        // color: Colors.black,
//                        child: SingleChildScrollView(
//                          controller: scrollController,
//                          child: Container(
//                            // height: Get.height,
//                            // width: Get.width,
//                            decoration: const BoxDecoration(
//                              color: Color(0xff000000),
//                              borderRadius: BorderRadius.only(
//                                topLeft: Radius.circular(30.0),
//                                topRight: Radius.circular(30.0),
//                              ),
//                            ),
//                            child: Padding(
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: Get.width * .03),
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                   SizedBox(height: Get.height * .02,),
//                                  Obx(() => requiredSkillsController.errorMessage.value.isEmpty ?
//                                  const SizedBox() :
//                                  Center(child: Text(requiredSkillsController.errorMessage.value,style: TextStyle(color: Colors.red),))
//                                  ) ,
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Soft Skills", style: Theme
//                                      .of(context)
//                                      .textTheme
//                                      .displaySmall,),
//                                  SizedBox(height: Get.height * .01,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount: seekerGetAllSkillsController.seekerGetAllSkillsData.value.softSkill?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//                                      var data = seekerGetAllSkillsController
//                                          .seekerGetAllSkillsData.value
//                                          .softSkill?[index];
//                                      final isSelected = _selectedChooseSkillsIndices
//                                          .contains("${data?.id.toString()}");
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChooseSkillsIndices
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChooseSkillsIndices
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChooseSkillsIndices
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(index);
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                          shape: BoxShape.circle,
//                                                          color: AppColors.blueThemeColor
//                                                      ),
//                                                      child: const Icon(Icons.check,
//                                                        color: Color(0xffFFFFFF), size: 15,),),
//                                                    if (!_selectedChooseSkillsIndices
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(
//                                                    child: Text(
//                                                      "${data?.skills}",
//                                                      overflow: TextOverflow.ellipsis, style: Theme
//                                                        .of(context)
//                                                        .textTheme
//                                                        .labelLarge
//                                                        ?.copyWith(
//                                                        fontWeight: FontWeight.w500,
//                                                        color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Passion", style: Theme.of(context).textTheme.displaySmall),
//                                  SizedBox(height: Get.height * .02,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                        crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount:  seekerGetAllSkillsController
//                                        .seekerGetAllSkillsData.value.passion
//                                        ?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//
//                                      var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.passion?[index] ;
//                                      final isSelectedPassion = _selectedChoosePassionSkills
//                                          .contains("${data?.id.toString()}");
//                                      //final isSelected = _selectedChooseSkillsIndex == index;
//                                      final borderColor = isSelectedPassion
//                                          ? Color(0xff56B6F6)
//                                          : Color(0xffFFFFFF);
//                                      // final gradient = isSelected
//                                      //     ? LinearGradient(colors: [Color(0xff56B8F6), Color(0xff4D6FED)])
//                                      //     : LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]);;
//
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChoosePassionSkills
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChoosePassionSkills
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChoosePassionSkills
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(data?.id.toString());
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelectedPassion ? AppColors.blueThemeColor : Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        color : AppColors.blueThemeColor,
//                                                      ),
//                                                      child: const Icon(Icons.check,
//                                                        color: Color(0xffFFFFFF), size: 15,),
//                                                    ),
//                                                    if (!_selectedChoosePassionSkills
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(child: Text(
//                                                  "${data?.passion}",
//                                                  overflow: TextOverflow.ellipsis, style: Theme
//                                                    .of(context)
//                                                    .textTheme
//                                                    .labelLarge
//                                                    ?.copyWith(
//                                                    fontWeight: FontWeight.w700,
//                                                    color: isSelectedPassion ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Industry Preference", style: Theme.of(context).textTheme.displaySmall),
//                                  SizedBox(height: Get.height * .02,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                        crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount:  seekerGetAllSkillsController
//                                        .seekerGetAllSkillsData.value.industry
//                                        ?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//
//                                      var data =  seekerGetAllSkillsController
//                                          .seekerGetAllSkillsData.value.industry?[index] ;
//                                      final isSelectedpreference = _selectedChoosepreferenceSkills
//                                          .contains("${data?.id.toString()}");
//                                      //final isSelected = _selectedChooseSkillsIndex == index;
//                                      final borderColor = isSelectedpreference
//                                          ? Color(0xff56B6F6)
//                                          : Color(0xffFFFFFF);
//
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChoosepreferenceSkills
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChoosepreferenceSkills
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChoosepreferenceSkills
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(index);
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelectedpreference ? AppColors.blueThemeColor : Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        color: AppColors.blueThemeColor,
//                                                      ),
//                                                      child: const Icon(Icons.check,
//                                                        color: Color(0xffFFFFFF), size: 15,),
//                                                    ),
//                                                    if (!_selectedChoosepreferenceSkills
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(child: Text(
//                                                  "${data?.industryPreferences}",
//                                                  overflow: TextOverflow.ellipsis, style: Theme
//                                                    .of(context)
//                                                    .textTheme
//                                                    .labelLarge
//                                                    ?.copyWith(
//                                                    fontWeight: FontWeight.w700,
//                                                    color: isSelectedpreference ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Strengths", style: Theme.of(context).textTheme.displaySmall),
//                                  SizedBox(height: Get.height * .02,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                        crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount:  seekerGetAllSkillsController
//                                        .seekerGetAllSkillsData.value.strengths
//                                        ?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//
//                                      var data =  seekerGetAllSkillsController
//                                          .seekerGetAllSkillsData.value.strengths?[index] ;
//                                      final isSelectedstrengths = _selectedChoosestrengthsSkills
//                                          .contains("${data?.id.toString()}");
//                                      //final isSelected = _selectedChooseSkillsIndex == index;
//                                      final borderColor = isSelectedstrengths
//                                          ? Color(0xff56B6F6)
//                                          : Color(0xffFFFFFF);
//
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChoosestrengthsSkills
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChoosestrengthsSkills
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChoosestrengthsSkills
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(data?.id.toString() );
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelectedstrengths ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        color: AppColors.blueThemeColor,
//                                                      ),
//                                                      child: const Icon(Icons.check,
//                                                        color: Color(
//                                                            0xffFFFFFF),
//                                                        size: 15,),
//                                                    ),
//                                                    if (!_selectedChoosestrengthsSkills
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(child: Text(
//                                                  "${data?.strengths}",
//                                                  overflow: TextOverflow.ellipsis, style: Theme
//                                                    .of(context)
//                                                    .textTheme
//                                                    .labelLarge
//                                                    ?.copyWith(
//                                                    fontWeight: FontWeight.w700,
//                                                    color: isSelectedstrengths ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Salary Expectation", style: Theme.of(context).textTheme.displaySmall),
//                                  // SizedBox(height: Get.height * .02,),
//                                  SizedBox( height: Get.height * 0.1 ,child:
//                                  RangePicker(maxSalary: double.tryParse(seekerGetAllSkillsController.seekerGetAllSkillsData.value.salaryExpectation![0].salaryExpectation.toString()),)) ,
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("When Can I Start Working?", style: Theme.of(context).textTheme.displaySmall),
//                                  SizedBox(height: Get.height * .02,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount:  seekerGetAllSkillsController.seekerGetAllSkillsData.value.startWork?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//                                      var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.startWork?[index] ;
//                                      final isSelectedWorking = _selectedChooseworkingSkills.contains("${data?.id.toString()}");
//                                      //final isSelected = _selectedChooseSkillsIndex == index;
//                                      final borderColor = isSelectedWorking
//                                          ? Color(0xff56B6F6)
//                                          : Color(0xffFFFFFF);
//                                      // final gradient = isSelected
//                                      //     ? LinearGradient(colors: [Color(0xff56B8F6), Color(0xff4D6FED)])
//                                      //     : LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]);
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChooseworkingSkills
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChooseworkingSkills
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChooseworkingSkills
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(index);
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelectedWorking ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        color: AppColors.blueThemeColor,
//                                                      ),
//                                                      child: const Icon(Icons.check,
//                                                        color: Color(
//                                                            0xffFFFFFF),
//                                                        size: 15,),
//                                                    ),
//                                                    if (!_selectedChooseworkingSkills
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(child: Text(
//                                                  "${data?.startWork}",
//                                                  overflow: TextOverflow.ellipsis, style: Theme
//                                                    .of(context)
//                                                    .textTheme
//                                                    .labelLarge
//                                                    ?.copyWith(
//                                                    fontWeight: FontWeight.w700,
//                                                    color: isSelectedWorking ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .02,),
//                                  Text("Availability", style: Theme.of(context).textTheme.displaySmall),
//                                  SizedBox(height: Get.height * .02,),
//                                  GridView.builder(
//                                    physics: const NeverScrollableScrollPhysics(),
//                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                        crossAxisCount: 2, mainAxisExtent: 65),
//                                    itemCount:  seekerGetAllSkillsController
//                                        .seekerGetAllSkillsData.value.availabity
//                                        ?.length,
//                                    shrinkWrap: true,
//                                    itemBuilder: (context, index) {
//
//                                      var data =  seekerGetAllSkillsController
//                                          .seekerGetAllSkillsData.value.availabity?[index] ;
//                                      final isSelectedAvailability = _selectedChooseAvailabilitySkills
//                                          .contains("${data?.id.toString()}");
//                                      //final isSelected = _selectedChooseSkillsIndex == index;
//                                      final borderColor = isSelectedAvailability
//                                          ? Color(0xff56B6F6)
//                                          : Color(0xffFFFFFF);
//                                      return Padding(
//                                        padding: EdgeInsets.symmetric(
//                                            horizontal: Get.width * .02,
//                                            vertical: Get.height * .01),
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (_selectedChooseAvailabilitySkills
//                                                  .contains("${data?.id.toString()}")) {
//                                                _selectedChooseAvailabilitySkills
//                                                    .remove("${data?.id.toString()}");
//                                              } else {
//                                                _selectedChooseAvailabilitySkills
//                                                    .add("${data?.id.toString()}");
//                                              }
//                                              print(index);
//                                            });
//                                          },
//                                          child: Container(
//                                            decoration: BoxDecoration(
//                                                borderRadius: BorderRadius
//                                                    .circular(35),
//                                                border: Border.all(
//                                                    color: isSelectedAvailability ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
//                                            ),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment
//                                                  .spaceBetween,
//                                              children: [
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Stack(
//                                                  alignment: Alignment.center,
//                                                  children: [
//                                                    Container(
//                                                      width: Get.width * .06,
//                                                      height: Get.height * .05,
//                                                      decoration: const BoxDecoration(
//                                                        shape: BoxShape.circle,
//                                                        color: AppColors.blueThemeColor,
//                                                      ),
//                                                      child: const Icon(
//                                                        Icons.check,
//                                                        color: Color(
//                                                            0xffFFFFFF),
//                                                        size: 15,),
//                                                    ),
//                                                    if (!_selectedChooseAvailabilitySkills
//                                                        .contains("${data?.id.toString()}"))
//                                                      Center(
//                                                        child: Container(
//                                                          width: Get.width *
//                                                              .05,
//                                                          height: Get.width *
//                                                              .05,
//                                                          decoration: const BoxDecoration(
//                                                            color: Color(
//                                                                0xff000000),
//                                                            shape: BoxShape
//                                                                .circle,
//                                                          ),
//                                                        ),
//                                                      ),
//                                                  ],
//                                                ),
//                                                SizedBox(
//                                                  width: Get.width * .02,),
//                                                Expanded(
//                                                    child: Text(
//                                                      "${data?.availabity}",
//                                                      overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.
//                                                    labelLarge?.copyWith(fontWeight: FontWeight.w700,
//                                                        color: isSelectedAvailability ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
//                                              ],
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    },),
//                                  SizedBox(height: Get.height * .06,),
//                                  Center(
//                                    child: MyButton(
//                                      title: "CONTINUE",
//                                      loading: requiredSkillsController.loading.value,
//                                      onTap1: () {
//                                        selectedSalary = "${RangePicker.minValue.toInt()} - ${RangePicker.maxValue.toInt()}" ;
//                                        debugPrint("this is =========== $selectedSalary") ;
//                                        requiredSkillsController.errorMessage.value = "" ;
//                                        if(_selectedChooseSkillsIndices.isEmpty ||
//                                            _selectedChoosestrengthsSkills.isEmpty ||
//                                            _selectedChoosePassionSkills.isEmpty ||
//                                            _selectedChoosepreferenceSkills.isEmpty ||
//                                            selectedSalary == null ||
//                                            _selectedChooseworkingSkills.isEmpty ||
//                                            _selectedChooseAvailabilitySkills.isEmpty
//                                        ) {
//                                          requiredSkillsController.errorMessage.value = "Please select atleast 1 field from each section" ;
//                                          setState((){
//                                            scrollController.animateTo(
//                                              scrollController.position.minScrollExtent,
//                                              curve: Curves.easeOut,
//                                              duration: const Duration(milliseconds:100),
//                                            );}) ;
//                                        }
//                                        else {
//                                          requiredSkillsController.requiredSkillsApi(
//                                              Get.arguments["job_id"],
//                                              _selectedChooseSkillsIndices,
//                                              _selectedChoosestrengthsSkills,
//                                              _selectedChoosePassionSkills,
//                                              _selectedChoosepreferenceSkills,
//                                              RangePicker.minValue,
//                                              RangePicker.maxValue,
//                                              _selectedChooseworkingSkills,
//                                              _selectedChooseAvailabilitySkills);
//                                        }
//                                      },),
//                                  ),
//                                  SizedBox(height: Get.height * .1,),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              )
//
//            ],
//           ),
//         ),
//       ) ;
//     }
//         });
//   }
// }

//////////////////////////

//////////////new


class RequiredSkills extends StatefulWidget {
  final RecruiterJobsData? recruiterJobsData ;
  const RequiredSkills({Key? key, this.recruiterJobsData}) : super(key: key);

  @override
  State<RequiredSkills> createState() => _RequiredSkillsState();
}

class _RequiredSkillsState extends State<RequiredSkills> {
  List _selectedChooseSkillsIndices = [];
  List _selectedChoosePassionSkills =[];
  List _selectedChoosepreferenceSkills =[];
  List _selectedChoosestrengthsSkills =[];
  List _selectedChooseworkingSkills =[];
  List _selectedChooseAvailabilitySkills =[];
  RxString error = ''.obs;
  var choose=1;
  var selectedSalary ;
  SeekerGetAllSkillsController seekerGetAllSkillsController = Get.put(SeekerGetAllSkillsController()) ;
  RequiredSkillsController requiredSkillsController = Get.put(RequiredSkillsController()) ;
  ScrollController scrollController = ScrollController() ;


  @override
  void initState() {
    seekerGetAllSkillsController.seekerGetAllSkillsApi() ;
    RangePicker.minValue = 5000.0 ;
    RangePicker.maxValue = 10000.0 ;
    if(widget.recruiterJobsData?.jobsDetail?.skillName != null){
      _selectedChooseSkillsIndices = widget.recruiterJobsData?.jobsDetail?.skillName?.map((e) => e.id.toString()).toList() ?? [];
    }
    if(widget.recruiterJobsData?.jobsDetail?.availabityName != null){
      _selectedChooseAvailabilitySkills = widget.recruiterJobsData?.jobsDetail?.availabityName?.map((e) => e.id.toString()).toList() ?? [];
    }
    if(widget.recruiterJobsData?.jobsDetail?.passionName != null){
      _selectedChoosePassionSkills = widget.recruiterJobsData?.jobsDetail?.passionName?.map((e) => e.id.toString()).toList() ?? [] ;
    }
    if(widget.recruiterJobsData?.jobsDetail?.industryPreferenceName != null){
      _selectedChoosepreferenceSkills = widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.map((e) => e.id.toString()).toList() ?? [] ;
    }
    if(widget.recruiterJobsData?.jobsDetail?.strengthsName != null){
      _selectedChoosestrengthsSkills = widget.recruiterJobsData?.jobsDetail?.strengthsName?.map((e) => e.id.toString()).toList() ?? [];
    }
    if(widget.recruiterJobsData?.jobsDetail?.startWorkName != null){
      _selectedChooseworkingSkills = widget.recruiterJobsData?.jobsDetail?.startWorkName?.map((e) => e.id.toString()).toList() ?? [] ;
    }
    if(widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation != null) {
      RangePicker.minValue = double.tryParse('${widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation}') ?? 5000.0 ;
      RangePicker.maxValue = double.tryParse('${widget.recruiterJobsData?.jobsDetail?.maxSalaryExpectation}') ?? 10000.0 ;
    }


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
                              // SizedBox(height: Get.height * .01,),
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
                                  // TextButton(onPressed: (){
                                  //   skipStepController.skipStepApi(2) ;
                                  //   CommonFunctions.showLoadingDialog(context, "Skipping") ;
                                  // },
                                  //     child: const Text("Skip",
                                  //       style: TextStyle(color: Colors.white ,
                                  //           fontSize: 16),))
                                ],
                              ),
                              SizedBox(height: Get.height * .02,),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .07),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Required Skills", style: Theme
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
                                      color: const Color(0xffFFFFFF)),),
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
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Container(
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
                                            SizedBox(height: Get.height * .02,),
                                            Obx(() => requiredSkillsController.errorMessage.value.isEmpty ?
                                            const SizedBox() :
                                            Center(child: Text(requiredSkillsController.errorMessage.value,style: TextStyle(color: Colors.red),))
                                            ) ,
                                            SizedBox(height: Get.height * .02,),
                                            Text("Soft Skills", style: Theme
                                                .of(context)
                                                .textTheme
                                                .displaySmall,),
                                            SizedBox(height: Get.height * .01,),
                                            GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 65),
                                              itemCount: seekerGetAllSkillsController.seekerGetAllSkillsData.value.softSkill?.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var data = seekerGetAllSkillsController
                                                    .seekerGetAllSkillsData.value
                                                    .softSkill?[index];
                                                final isSelected = _selectedChooseSkillsIndices
                                                    .contains("${data?.id.toString()}");
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
                                                              color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
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
                                                                  color: Color(0xffFFFFFF), size: 15,),),
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
                                                          Expanded(
                                                              child: Text(
                                                                "${data?.skills}",
                                                                overflow: TextOverflow.ellipsis, style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .labelLarge
                                                                  ?.copyWith(
                                                                  fontWeight: FontWeight.w500,
                                                                  color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF)),))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },),
                                            SizedBox(height: Get.height * .02,),
                                            Text("Passion", style: Theme.of(context).textTheme.displaySmall),
                                            SizedBox(height: Get.height * .02,),
                                            GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2, mainAxisExtent: 65),
                                              itemCount:  seekerGetAllSkillsController
                                                  .seekerGetAllSkillsData.value.passion
                                                  ?.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {

                                                var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.passion?[index] ;
                                                final isSelectedPassion = _selectedChoosePassionSkills
                                                    .contains("${data?.id.toString()}");
                                                //final isSelected = _selectedChooseSkillsIndex == index;
                                                final borderColor = isSelectedPassion
                                                    ? Color(0xff56B6F6)
                                                    : Color(0xffFFFFFF);
                                                // final gradient = isSelected
                                                //     ? LinearGradient(colors: [Color(0xff56B8F6), Color(0xff4D6FED)])
                                                //     : LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]);;

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
                                                              color: isSelectedPassion ? AppColors.blueThemeColor : Color(0xffFFFFFF))
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
                                                                  color : AppColors.blueThemeColor,
                                                                ),
                                                                child: const Icon(Icons.check,
                                                                  color: Color(0xffFFFFFF), size: 15,),
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
                                                            overflow: TextOverflow.ellipsis, style: Theme
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
                                            SizedBox(height: Get.height * .02,),
                                            Text("Industry Preference", style: Theme.of(context).textTheme.displaySmall),
                                            SizedBox(height: Get.height * .02,),
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
                                                final isSelectedpreference = _selectedChoosepreferenceSkills
                                                    .contains("${data?.id.toString()}");
                                                //final isSelected = _selectedChooseSkillsIndex == index;
                                                final borderColor = isSelectedpreference
                                                    ? Color(0xff56B6F6)
                                                    : Color(0xffFFFFFF);

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
                                                              color: isSelectedpreference ? AppColors.blueThemeColor : Color(0xffFFFFFF))
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
                                                                  color: AppColors.blueThemeColor,
                                                                ),
                                                                child: const Icon(Icons.check,
                                                                  color: Color(0xffFFFFFF), size: 15,),
                                                              ),
                                                              if (!_selectedChoosepreferenceSkills
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
                                                            "${data?.industryPreferences}",
                                                            overflow: TextOverflow.ellipsis, style: Theme
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
                                            SizedBox(height: Get.height * .02,),
                                            Text("Strengths", style: Theme.of(context).textTheme.displaySmall),
                                            SizedBox(height: Get.height * .02,),
                                            GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2, mainAxisExtent: 65),
                                              itemCount:  seekerGetAllSkillsController
                                                  .seekerGetAllSkillsData.value.strengths
                                                  ?.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {

                                                var data =  seekerGetAllSkillsController
                                                    .seekerGetAllSkillsData.value.strengths?[index] ;
                                                final isSelectedstrengths = _selectedChoosestrengthsSkills
                                                    .contains("${data?.id.toString()}");
                                                //final isSelected = _selectedChooseSkillsIndex == index;
                                                final borderColor = isSelectedstrengths
                                                    ? Color(0xff56B6F6)
                                                    : Color(0xffFFFFFF);

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
                                                              color: isSelectedstrengths ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
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
                                                                  color: AppColors.blueThemeColor,
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
                                                            overflow: TextOverflow.ellipsis, style: Theme
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
                                            SizedBox(height: Get.height * .02,),
                                            Text("Salary Expectation", style: Theme.of(context).textTheme.displaySmall),
                                            // SizedBox(height: Get.height * .02,),
                                            SizedBox( height: Get.height * 0.1 ,child:
                                            RangePicker(maxSalary: double.tryParse(seekerGetAllSkillsController.seekerGetAllSkillsData.value.salaryExpectation![0].salaryExpectation.toString()),)) ,
                                            SizedBox(height: Get.height * .02,),
                                            Text("When Can I Start Working?", style: Theme.of(context).textTheme.displaySmall),
                                            SizedBox(height: Get.height * .02,),
                                            GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 65),
                                              itemCount:  seekerGetAllSkillsController.seekerGetAllSkillsData.value.startWork?.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var data =  seekerGetAllSkillsController.seekerGetAllSkillsData.value.startWork?[index] ;
                                                final isSelectedWorking = _selectedChooseworkingSkills.contains("${data?.id.toString()}");
                                                //final isSelected = _selectedChooseSkillsIndex == index;
                                                final borderColor = isSelectedWorking
                                                    ? Color(0xff56B6F6)
                                                    : Color(0xffFFFFFF);
                                                // final gradient = isSelected
                                                //     ? LinearGradient(colors: [Color(0xff56B8F6), Color(0xff4D6FED)])
                                                //     : LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]);
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
                                                          _selectedChooseworkingSkills.clear();
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
                                                              color: isSelectedWorking ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
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
                                                                  color: AppColors.blueThemeColor,
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
                                                            overflow: TextOverflow.ellipsis, style: Theme
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
                                            SizedBox(height: Get.height * .02,),
                                            Text("Availability", style: Theme.of(context).textTheme.displaySmall),
                                            SizedBox(height: Get.height * .02,),
                                            GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2, mainAxisExtent: 65),
                                              itemCount:  seekerGetAllSkillsController
                                                  .seekerGetAllSkillsData.value.availabity
                                                  ?.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {

                                                var data =  seekerGetAllSkillsController
                                                    .seekerGetAllSkillsData.value.availabity?[index] ;
                                                final isSelectedAvailability = _selectedChooseAvailabilitySkills
                                                    .contains("${data?.id.toString()}");
                                                //final isSelected = _selectedChooseSkillsIndex == index;
                                                final borderColor = isSelectedAvailability
                                                    ? Color(0xff56B6F6)
                                                    : Color(0xffFFFFFF);
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
                                                              color: isSelectedAvailability ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
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
                                                                  color: AppColors.blueThemeColor,
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
                                                          Expanded(
                                                              child: Text(
                                                                "${data?.availabity}",
                                                                overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.
                                                              labelLarge?.copyWith(fontWeight: FontWeight.w700,
                                                                  color: isSelectedAvailability ? AppColors.blueThemeColor : Color(0xffFFFFFF)),))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },),
                                            SizedBox(height: Get.height * .06,),
                                            Center(
                                              child: Obx( () =>
                                             MyButton(
                                                  title: widget.recruiterJobsData != null ? "Update" : "Post",
                                                  loading: requiredSkillsController.loading.value,
                                                  onTap1: () {
                                                    selectedSalary = "${RangePicker.minValue.toInt()} - ${RangePicker.maxValue.toInt()}" ;
                                                    debugPrint("this is =========== $selectedSalary") ;
                                                    requiredSkillsController.errorMessage.value = "" ;
                                                    if(_selectedChooseSkillsIndices.isEmpty ||
                                                        _selectedChoosestrengthsSkills.isEmpty ||
                                                        _selectedChoosePassionSkills.isEmpty ||
                                                        _selectedChoosepreferenceSkills.isEmpty ||
                                                        selectedSalary == null ||
                                                        _selectedChooseworkingSkills.isEmpty ||
                                                        _selectedChooseAvailabilitySkills.isEmpty
                                                    ) {
                                                      requiredSkillsController.errorMessage.value = "Please select atleast 1 field from each section" ;
                                                      setState((){
                                                        scrollController.animateTo(
                                                          scrollController.position.minScrollExtent,
                                                          curve: Curves.easeOut,
                                                          duration: const Duration(milliseconds:100),
                                                        );}) ;
                                                    }
                                                    else {
                                                      requiredSkillsController.requiredSkillsApi(
                                                          Get.arguments["job_id"],
                                                          _selectedChooseSkillsIndices,
                                                          _selectedChoosestrengthsSkills,
                                                          _selectedChoosePassionSkills,
                                                          _selectedChoosepreferenceSkills,
                                                          RangePicker.minValue,
                                                          RangePicker.maxValue,
                                                          _selectedChooseworkingSkills,
                                                          _selectedChooseAvailabilitySkills);
                                                    }
                                                  },),
                                              ),
                                            ),
                                            SizedBox(height: Get.height * .1,),
                                          ],
                                        ),
                                      ),
                                    ),
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
