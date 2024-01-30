import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/JobAlert/view_job.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../controllers/JobAlertWiseJobListingController/JobAlertWiseJobListingController.dart';
import '../../controllers/SeekerSavedJobsController/SeekerSavedJobsController.dart';
import '../../controllers/SeekerUnSavePostController/SeekerUnSavePostController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class JobAlertWiseJobListing extends StatefulWidget {
 final String positionID;
  const JobAlertWiseJobListing({super.key, required this.positionID});

  @override
  State<JobAlertWiseJobListing> createState() => _JobAlertWiseJobListingState();
}

class _JobAlertWiseJobListingState extends State<JobAlertWiseJobListing> {

  SeekerJobAlertWiseJobListingController seekerJobAlertWiseJobListingControllerInstanse = Get.put(SeekerJobAlertWiseJobListingController()) ;

  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController());
  SeekerUnSavePostController unSavePostController = Get.put(SeekerUnSavePostController());
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController());

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertListApi(widget.positionID) ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertListApi(widget.positionID) ;
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
/////refresh/////

  @override
  void initState() {
    // TODO: implement initState
    seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertListApi(widget.positionID) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      switch (seekerJobAlertWiseJobListingControllerInstanse.rxRequestStatus.value) {
        case Status.LOADING:
          return const
          Scaffold(body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (seekerJobAlertWiseJobListingControllerInstanse.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {},
            );
          } else {
            return GeneralExceptionWidget(onPress: () {});
          }
        case Status.COMPLETED:
          return
      Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark
        ),
        toolbarHeight: 40,
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back() ;
          },
          child: Image.asset(
            "assets/images/icon_back_blue.png",
          ),
        ),
        title: Text("Marketing intern In California",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList == null ||
                  seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?.length == 0 ?
              Text("No data",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),):
              SizedBox(height: Get.height*.03,),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const JobViewJobAlert()) ;
                        },
                        child: Container(
                          height: Get.height*.2,
                          decoration:  BoxDecoration(
                            color: AppColors.homeGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                // horizontalTitleGap: 0,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 26,
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) => const SizedBox(
                                      height: 50,
                                        width: 50,
                                        child: Placeholder()),
                                      imageUrl: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].featureImg ?? "" ,height: Get.height*.07,
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                        fit: BoxFit.cover,
                                        )
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    ),
                                  ),
                                ),
                                title: Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].recruiterDetails?.companyName ?? "",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                                subtitle: Row(
                                  children: [
                                    Text("${seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].recruiter?.companyReviews}" ?? "",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: AppColors.yellowColor),),
                                    SizedBox(width: 5,),
                                    RatingBar(
                                      initialRating: 1.0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 1,
                                      itemSize: 20,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star, color: Colors.amber),
                                        half: const Icon(Icons.star_half, color: Colors.amber),
                                        empty: const Icon(Icons.star_border, color: Colors.amber),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    CommonFunctions.confirmationDialog(context,
                                        message: getJobsListingController.getJobsListing.value.jobs?[index].postSaved ?"Do you want to remove the\n post from saved posts" : "Do you want to save the post",
                                        onTap: () async {
                                          Get.back();
                                          if(getJobsListingController.getJobsListing.value.jobs?[index].postSaved == true) {
                                            CommonFunctions.showLoadingDialog(context, "removing...");
                                            var result = await unSavePostController.unSavePost(getJobsListingController.getJobsListing.value.jobs?[index].id.toString(), "1", context, true);
                                            if(result = true) {
                                              if (kDebugMode) {
                                                print("inside result");
                                              }
                                              getJobsListingController.getJobsListing.value.jobs?[index].postSaved = false;
                                              setState(() {});
                                            }
                                          } else {
                                            CommonFunctions.showLoadingDialog(context, "Saving") ;
                                            var result = await seekerSaveJobController.saveJobApi(getJobsListingController.getJobsListing.value.jobs?[index].id, 1);
                                            if (result == true) {
                                              if (kDebugMode) {
                                                print("inside result");
                                              }
                                              getJobsListingController.getJobsListing.value.jobs?[index].postSaved = true;
                                              setState(() {});
                                            }
                                          }
                                        },) ;
                                  },
                                  child: getJobsListingController.getJobsListing.value.jobs?[index].postSaved == false
                                  ? Image.asset(
                                    "assets/images/icon_unsave_post.png",
                                    height: 50,
                                    width: 50,
                                  ) :
                                  Image.asset(
                                    "assets/images/icon_Save_post.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobTitle ??  "",style: Theme.of(context).textTheme.titleLarge,),
                                    Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobLocation ?? "",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: AppColors.silverColor),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.minSalaryExpectation ?? ''} - ${seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'}',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),),
                                        // Text("1d",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500,color: AppColors.black),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
);}}
