import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/CandidateJobStatusController/CandidateJobStatusController.dart';
import 'package:flikka/hiring%20Manager/schedule_interview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ApplicantTrackingController/ApplicantTrackingController.dart';
import '../../controllers/RecruiterHomePageJobsController/RecruiterHomePageJobsController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class AllCandidate extends StatefulWidget {
  const AllCandidate({super.key});

  @override
  State<AllCandidate> createState() => _AllCandidateState();
}

class _AllCandidateState extends State<AllCandidate> {

  String? jobTitleValue;
  String? jobPositionValue ;
  String? positionID ;
  String? titleID ;

  final List<String> statusList = ['Accepted','Rejected',"Pending","All"];
  String? statusValue;

  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());
  CandidateJobStatusController statusController = Get.put(CandidateJobStatusController()) ;
  RecruiterHomePageJobsController jobsController = Get.put(RecruiterHomePageJobsController()) ;

@override
  void initState() {
  jobTitleValue=null;
  jobsController.recruiterJobsApi() ;
  jobTitleController.recruiterJobTitleApi() ;
   trackingDataController.applicantTrackingApi(positionID ,statusValue ) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (trackingDataController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),);
          case Status.ERROR:
            if (trackingDataController.error.value == 'No internet') {
              return Scaffold(
                body: InterNetExceptionWidget(
                onPress: () {
                  trackingDataController.applicantTrackingApi(positionID ,statusValue ) ;
                },
              ),);
            } else {
              return Scaffold(body: GeneralExceptionWidget(onPress: () {
                trackingDataController.applicantTrackingApi(positionID ,statusValue ) ;
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
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: Get.height * .04,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: Get.height * .008),
                                  decoration: BoxDecoration(
                                    color: AppColors.textFieldFilledColor,
                                    borderRadius: BorderRadius.circular(33.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: AppColors.blueThemeColor,
                                        size: 27,),
                                      SizedBox(width: Get.width * .03),
                                      Expanded(
                                        child: TextFormField(
                                          style: Theme.of(context).textTheme.bodyLarge
                                              ?.copyWith(color: const Color(0xffCFCFCF), fontSize: 19),
                                          onChanged: (query) {
                                           trackingDataController.filterList(query) ;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                            hintStyle: Theme.of(context).textTheme.bodyLarge
                                                ?.copyWith(color: const Color(0xffCFCFCF)), border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height * .03,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Text("All Candidate", style: Theme.of(context).textTheme.bodyLarge
                                    //     ?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))),
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
                                                  trackingDataController.applicantTrackingApi(positionID, statusValue);
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
                                    // SizedBox(width: Get.width * .02,),
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton2(
                                    //     isExpanded: true,
                                    //     hint: Text(
                                    //       jobTitleValue == null
                                    //           ? 'Select Title'
                                    //           : jobTitleValue.toString(),
                                    //       style: Get.theme.textTheme.bodyLarge!
                                    //           .copyWith(
                                    //           color: AppColors.white,
                                    //           fontSize: 12),
                                    //       overflow: TextOverflow.ellipsis,),
                                    //     items: jobTitleController
                                    //         .getJobTitleDetails
                                    //         .value.jobTitleList?.map((item) =>
                                    //         DropdownMenuItem(
                                    //           value: item.id,
                                    //           child: Text(
                                    //             item.jobTitle.toString(),
                                    //             style: Get.theme.textTheme
                                    //                 .bodyLarge!
                                    //                 .copyWith(
                                    //                 color: AppColors.white,
                                    //                 fontSize: 12),
                                    //             overflow: TextOverflow
                                    //                 .ellipsis,),
                                    //           onTap: () {
                                    //             setState(() {
                                    //               jobTitleValue = null;
                                    //               jobTitleValue =
                                    //                   item.jobTitle.toString();
                                    //               trackingDataController
                                    //                   .applicantTrackingApi(
                                    //                   item.id.toString(),
                                    //                   statusValue);
                                    //             });
                                    //           },
                                    //         )).toList(),
                                    //     // value: jobTitleValue,
                                    //     onChanged: (value) {},
                                    //     buttonStyleData: ButtonStyleData(
                                    //       height: Get.height * 0.055,
                                    //       width: Get.width * .29,
                                    //       padding: const EdgeInsets.only(
                                    //           left: 10, right: 5),
                                    //       decoration: BoxDecoration(
                                    //           borderRadius: BorderRadius
                                    //               .circular(35),
                                    //           border: Border.all(
                                    //               color: const Color(
                                    //                   0xff686868))
                                    //         // color: Color(0xff353535),
                                    //       ),
                                    //       elevation: 2,
                                    //     ),
                                    //
                                    //     dropdownStyleData: DropdownStyleData(
                                    //       maxHeight: Get.height * 0.35,
                                    //       width: Get.width * .42,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(
                                    //             14),
                                    //         color: const Color(0xff353535),
                                    //       ),
                                    //       offset: const Offset(5, 0),
                                    //       scrollbarTheme: ScrollbarThemeData(
                                    //         radius: const Radius.circular(40),
                                    //         thickness: MaterialStateProperty
                                    //             .all<
                                    //             double>(6),
                                    //         thumbVisibility: MaterialStateProperty
                                    //             .all<
                                    //             bool>(true),
                                    //       ),
                                    //     ),
                                    //
                                    //   ),
                                    // ),
                                    SizedBox(width: Get.width * .02,),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Status',
                                          style: Get.theme.textTheme.bodyLarge!
                                              .copyWith(
                                              color: AppColors.white,
                                              fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: statusList.map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item,
                                                style: Get.theme.textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                            .toList(),
                                        value: statusValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            statusValue = value;
                                            trackingDataController.applicantTrackingApi(positionID, statusValue);
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: Get.height * 0.055,
                                          width: Get.width * .4,
                                          padding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(35),
                                              border: Border.all(
                                                  color: Color(0xff686868))
                                            // color: Color(0xff353535),
                                          ),
                                          elevation: 2,
                                        ),

                                        dropdownStyleData: DropdownStyleData(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 5),
                                          maxHeight: Get.height * 0.35,
                                          width: Get.width * 0.42,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                14),
                                            color: Color(0xff353535),
                                          ),
                                          offset: const Offset(5, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: Radius.circular(40),
                                            thickness: MaterialStateProperty
                                                .all<
                                                double>(6),
                                            thumbVisibility: MaterialStateProperty
                                                .all<
                                                bool>(true),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Get.height * .03,),
                                Column(
                                  children: [
                                    trackingDataController.applicantList == null ||
                                        trackingDataController.applicantList?.length == 0 ?
                                    Text("No Data", style: Theme.of(context)
                                        .textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,
                                        color: const Color(0xffFFFFFF))) :
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: trackingDataController.applicantList?.length,
                                        itemBuilder: (context, i) {
                                          var candidateStatusData = trackingDataController.applicantList?[i];
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: candidateStatusData?.appliedJob?.length,
                                              itemBuilder: (context, index) {
                                                var data = candidateStatusData?.appliedJob?[index];
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
                                                            imageUrl: "${data?.seekerData?.profileImg}",
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
                                                          data?.seekerData?.fullname ?? "No data",
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
                                                            Text(candidateStatusData?.jobTitle ?? "No job title",
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
                                                              data?.seekerData
                                                                  ?.location ??
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
                                                            Text(data?.status
                                                                .toString()
                                                                .toLowerCase() ??
                                                                "",
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .labelLarge
                                                                  ?.copyWith(
                                                                  fontWeight: FontWeight
                                                                      .w700,
                                                                  color: "${data
                                                                      ?.status}"
                                                                      .toLowerCase() ==
                                                                      "accepted"
                                                                      ? const Color(
                                                                      0xff42D396)
                                                                      :
                                                                  "${data
                                                                      ?.status}"
                                                                      .toLowerCase() ==
                                                                      "rejected"
                                                                      ? Colors
                                                                      .red
                                                                      : AppColors
                                                                      .white
                                                              ),),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height *
                                                            .010,),
                                                      MyButton(
                                                        height: Get.height *
                                                            .059,
                                                        width: Get.width * .75,
                                                        title: "VIEW PROFILE",
                                                        onTap1: () {
                                                          Get.to(() =>
                                                              ScheduleInterview(
                                                                seekerID: "${data?.seekerId}",
                                                                requestID: '${data?.id}',
                                                                status: "${data?.status}".toLowerCase(),
                                                                scheduleInterview: data?.scheduleInterView,
                                                                   ));
                                                        },),
                                                      SizedBox(
                                                        height: Get.height *
                                                            .022,),
                                                    ],
                                                  ),
                                                );
                                              }
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height * .08,),
                              ],
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
