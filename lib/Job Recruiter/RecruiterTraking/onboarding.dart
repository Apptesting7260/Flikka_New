import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/ApplicantTrackingController/ApplicantTrackingController.dart';
import '../../controllers/OnboardingController/OnboardingController.dart';
import '../../controllers/RecruiterHomePageJobsController/RecruiterHomePageJobsController.dart';
import '../../controllers/SelectOrRejectAfterInterviewController/SelectOrRejectAfterInterviewController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  String? jobTitleValue;
  String? jobPositionValue ;
  String? positionID ;
  String? titleID ;

  final List<String> statusList = ['Accepted','Rejected',"Pending","All"];
  String? statusValue;
  String? requestId;

  OnboardingController onboardingController = Get.put(OnboardingController()) ;
  SelectOrRejectAfterInterviewController selectOrRejectAfterInterviewController = Get.put(SelectOrRejectAfterInterviewController()) ;
  RecruiterHomePageJobsController jobsController = Get.put(RecruiterHomePageJobsController()) ;

  //////refresh//////
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await onboardingController.onboardingApiHit(positionID, context);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    if(onboardingController.getOnboardingDetails.value.appliedSeeker == null ||
        onboardingController.getOnboardingDetails.value.appliedSeeker?.length == 0
    ){
      onboardingController.onboardingApiHit(positionID, context) ;
    }
    super.initState();
  }

  void _onLoading() async{
    await onboardingController.onboardingApiHit(positionID, context);
    if(mounted)
      // setState(() {
      //
      // });
    _refreshController.loadComplete();
  }
  /////refresh/////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (onboardingController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),);
          case Status.ERROR:
            if (onboardingController.error.value == 'No internet') {
              return Scaffold(
                body: InterNetExceptionWidget(
                  onPress: () {
                    onboardingController.onboardingApiHit(positionID, context) ;
                  },
                ),);
            } else {
              return Scaffold(body: GeneralExceptionWidget(onPress: () {
                onboardingController.onboardingApiHit(positionID, context) ;
              }),);
            }
          case Status.COMPLETED:
            return Obx(() {
              switch (jobsController.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),);
                case Status.ERROR:
                  if (jobsController.error.value == 'No internet') {
                    return Scaffold(
                      body: InterNetExceptionWidget(
                        onPress: () {
                          jobsController.recruiterJobsApi() ;
                        },
                      ),);
                  } else {
                    return Scaffold(body: GeneralExceptionWidget(onPress: () {
                      jobsController.recruiterJobsApi() ;
                    }),);
                  }
                case Status.COMPLETED:
                  return SmartRefresher(
                    controller: _refreshController,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: Get.height * .008),
                            //   decoration: BoxDecoration(
                            //     color: AppColors.textFieldFilledColor,
                            //     borderRadius: BorderRadius.circular(33.0),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       const Icon(
                            //         Icons.search,
                            //         color: AppColors.blueThemeColor,
                            //         size: 27,),
                            //       SizedBox(width: Get.width * .03),
                            //       Expanded(
                            //         child: TextFormField(
                            //           style: Theme.of(context).textTheme.bodyLarge
                            //               ?.copyWith(color: const Color(0xffCFCFCF), fontSize: 19),
                            //           onChanged: (query) {
                            //             trackingDataController.filterList(query) ;
                            //           },
                            //           decoration: InputDecoration(
                            //             hintText: 'Search',
                            //             hintStyle: Theme.of(context).textTheme.bodyLarge
                            //                 ?.copyWith(color: const Color(0xffCFCFCF)), border: InputBorder.none,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: Get.height * .03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      jobPositionValue == null
                                          ? 'Select position'
                                          : jobPositionValue.toString(),
                                      style: Get.theme.textTheme.bodyLarge!
                                          .copyWith(
                                          color: AppColors.white,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,),
                                    items: jobsController.getJobsDetails
                                        .value
                                        .jobPositionList?.map((item) =>
                                        DropdownMenuItem(
                                          value: item.id,
                                          child: Text(
                                            item.positions.toString(),
                                            style: Get.theme.textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                color: AppColors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow
                                                .ellipsis,),
                                          onTap: () {
                                            setState(() {
                                              jobPositionValue = item.positions.toString();
                                              positionID = "${item.id}" ;
                                              onboardingController.onboardingApiHit(positionID, context) ;
                                            });
                                          },
                                        )).toList(),
                                    // value: jobTitleValue,
                                    onChanged: (value) {},
                                    buttonStyleData: ButtonStyleData(
                                      height: Get.height * 0.055,
                                      width: Get.width * .4,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(35),
                                          border: Border.all(
                                              color: const Color(
                                                  0xff686868))
                                        // color: Color(0xff353535),
                                      ),
                                      elevation: 2,
                                    ),

                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: Get.height * 0.35,
                                      width: Get.width * .42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            14),
                                        color: const Color(0xff353535),
                                      ),
                                      offset: const Offset(5, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty
                                            .all<
                                            double>(6),
                                        thumbVisibility: MaterialStateProperty
                                            .all<
                                            bool>(true),
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * .03,),
                            Column(
                              children: [
                                onboardingController.getOnboardingDetails.value.appliedSeeker == null ||
                                    onboardingController.getOnboardingDetails.value.appliedSeeker?.length == 0 ?
                                Text("No Data", style: Theme.of(context)
                                    .textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,
                                    color: const Color(0xffFFFFFF))) :
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: onboardingController.getOnboardingDetails.value.appliedSeeker?.length,
                                    itemBuilder: (context, index) {
                                      // var candidateStatusData = trackingDataController.applicantList?[index];
                                        var data = onboardingController.getOnboardingDetails.value.appliedSeeker?[index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width *
                                                .04),
                                        margin: EdgeInsets.only(
                                            bottom: Get.height * .04),
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xff353535),
                                            borderRadius: BorderRadius
                                                .circular(24)
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height *
                                                  .013,),
                                            ListTile(
                                              contentPadding: EdgeInsets
                                                  .zero,
                                              minVerticalPadding: 15,
                                              leading: CircleAvatar(
                                                radius: 27,
                                                // backgroundImage: NetworkImage("${data?.seekerData?.profileImg}"),
                                                child: CachedNetworkImage(
                                                  imageUrl: "${data?.seekerlist?.profileImg}",
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover,)),
                                                      ),
                                                  placeholder: (context, url) =>
                                                  const Center(
                                                      child: CircularProgressIndicator()),
                                                ),
                                              ),
                                              title: Text(
                                                data?.seekerlist?.fullname ?? "No data",
                                                style: Theme.of(context).textTheme.titleLarge
                                                    ?.copyWith(color: const Color(0xffFFFFFF)),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Applied for :-",
                                                      style: Theme.of(context).textTheme.bodySmall
                                                          ?.copyWith(color: const Color(0xffCFCFCF),
                                                          fontWeight: FontWeight.w600)),
                                                  SizedBox(height: Get.height * .003,),
                                                  Text(data?.jobsData?.jobTitle ?? "No job title",
                                                      style: Theme.of(context).textTheme.bodySmall
                                                          ?.copyWith(color: const Color(0xffCFCFCF),
                                                          fontWeight: FontWeight.w600)),
                                                  SizedBox(height: Get.height * .003,),
                                                  // Text(candidateStatusData?.jobPositions ?? "",
                                                  //     style: Theme
                                                  //         .of(context)
                                                  //         .textTheme
                                                  //         .bodySmall
                                                  //         ?.copyWith(
                                                  //         color: const Color(
                                                  //             0xffCFCFCF),
                                                  //         fontWeight: FontWeight
                                                  //             .w600)
                                                  // ),
                                                  SizedBox(
                                                    height: Get
                                                        .height *
                                                        .003,),
                                                  Text(
                                                    data?.seekerlist?.location ??
                                                        "No location",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .labelLarge
                                                        ?.copyWith(
                                                        fontWeight: FontWeight
                                                            .w400,
                                                        color: const Color(
                                                            0xffCFCFCF)),),
                                                  SizedBox(
                                                    height: Get
                                                        .height *
                                                        .003,),
                                                  // Text(data?.status
                                                  //     .toString()
                                                  //     .toLowerCase() ??
                                                  //     "",
                                                  //   style: Theme
                                                  //       .of(context)
                                                  //       .textTheme
                                                  //       .labelLarge
                                                  //       ?.copyWith(
                                                  //       fontWeight: FontWeight
                                                  //           .w700,
                                                  //       color: "${data
                                                  //           ?.status}"
                                                  //           .toLowerCase() ==
                                                  //           "accepted"
                                                  //           ? const Color(
                                                  //           0xff42D396)
                                                  //           :
                                                  //       "${data
                                                  //           ?.status}"
                                                  //           .toLowerCase() ==
                                                  //           "rejected"
                                                  //           ? Colors
                                                  //           .red
                                                  //           : AppColors
                                                  //           .white
                                                  //   ),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height *
                                                  .010,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                   MyButton(
                                                     width: Get.width*.38 ,
                                                     height: Get.height * .066,
                                                     title: "SELECT",
                                                      onTap1: () {
                                                       CommonFunctions.confirmationDialog(context, message: "Do you want to select this profile", onTap: () {
                                                         selectOrRejectAfterInterviewController.selectOrRejectAfterInterviewApiHit("${data?.id.toString()}", "Selected",context) ;
                                                       },) ;
                                                      },),
                                                  MyButton(
                                                    width: Get.width*.38 ,
                                                    height: Get.height * .066,
                                                    title: "REJECT",
                                                      onTap1: () {
                                                      CommonFunctions.confirmationDialog(context, message: "Do you want to reject this profile", onTap: () {
                                                        selectOrRejectAfterInterviewController.selectOrRejectAfterInterviewApiHit("${data?.id.toString()}", "Rejected", context) ;
                                                      },) ;
                                                      },),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height *
                                                  .022,),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * .08,),
                          ],
                        ),
                      ),
                    ),
                  );
              }
            }
            );
        }
      }
      ),
    );
  }

}
