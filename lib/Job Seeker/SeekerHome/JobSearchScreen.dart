import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/SeekerFilter/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import '../../widgets/app_colors.dart';
import '../SeekerDrawer/Drawer_page.dart';
import '../SeekerJobs/no_job_available.dart';
import 'find_job_home_page.dart';

class JobSearchScreen extends StatefulWidget {
  const JobSearchScreen({super.key});

  @override
  State<JobSearchScreen> createState() => _JobSearchScreenState();
}

class _JobSearchScreenState extends State<JobSearchScreen> {

  TextEditingController searchController = TextEditingController() ;
  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController());
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        toolbarHeight: 0,elevation: 0,
      ),
      endDrawer: DrawerClass(
        name: '${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}',
        location: '${seekerProfileController.viewSeekerData.value.seekerInfo?.location}',
        jobTitle: '${seekerProfileController.viewSeekerData.value.seekerDetails?.positions ?? ''}',
        profileImage: '${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}',
      ),
      body: SingleChildScrollView(
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Row(children: [
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Get.back() ;
                },
                child: Container(
                padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle ,
                      color: AppColors.blueThemeColor),
                  child: const Icon(Icons.arrow_back_ios,color: AppColors.white,),
                ),
              ),
              SizedBox(width: Get.width *.2,),
              Text("Jobs",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black,fontSize: 20,fontWeight: FontWeight.w700),),
            ],),
           const SizedBox(height: 20,),
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              SizedBox( width: Get.width * .1,
                child: GestureDetector(
                  onTap: () {
                    Get.to( () => const FilterPage()) ;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.blueThemeColor),
                    child: Image.asset("assets/images/filterIcon.png"),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * .5,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (query) {
                    getJobsListingController.filterJobs(query) ;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: "Start a job search" ,
                    hintStyle: const TextStyle(color: AppColors.black),
                    filled: true,
                    fillColor: AppColors.homeGrey ,
                    prefixIcon: const Icon(Icons.search , color: AppColors.blueThemeColor,)
                  ),
                ),
              ),
              SizedBox( width: Get.width * .1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.blueThemeColor
                    ),
                    child: Image.asset("assets/images/icon_forum_select.png"),
                  ),
                ),
              ),
              SizedBox( width: Get.width * .1,
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer() ;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.blueThemeColor
                        ),
                        child: Image.asset("assets/images/drawerIconWhite.png"),
                      ),
                    );
                  }
                ),
              ),
            ],) ,
            SizedBox(height: Get.height * .02,) ,
            Text("Jobs based on your profile" , style: Theme.of(context).textTheme.bodyLarge,) ,
            SizedBox(height: Get.height * .02,) ,
            getJobsListingController.getJobsListing.value.jobs == null ||
            getJobsListingController.getJobsListing.value.jobs?.length == 0 ?
            const SeekerNoJobAvailable() :
            ListView.builder(
               physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: getJobsListingController.getJobsListing.value.jobs?.length,
                itemBuilder: (context , index) {
                var data = getJobsListingController.getJobsListing.value.jobs?[index] ;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      FindJobHomeScreenState.currentPage = index ;
                      Get.back(result: true) ;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: Get.height*.02),
                      color: AppColors.homeGrey,
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            imageUrl: data?.featureImg ?? "" ,
                            placeholder:(context, url) => const Center(child: CircularProgressIndicator(),),
                            errorWidget: (context, url, error) =>
                            const SizedBox( height: 40, child: Placeholder()),
                            imageBuilder:(context, imageProvider) =>  Container(
                              height: 80, width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle ,
                                  image: DecorationImage(image: imageProvider , fit: BoxFit.cover)
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*.04,),
                          Flexible(
                            child: SizedBox( width: Get.width *.6,
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( data?.jobPositions ??"" , style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),),
                                  Text(data?.recruiterDetails?.companyName ?? "" , style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black),),
                                  SizedBox(height: Get.height *.01,) ,
                                  Text(data?.jobLocation ?? "" , style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black),),
                                  SizedBox(height: Get.height *.01,) ,
                                  Text( "${data?.jobsDetail?.minSalaryExpectation} - ${data?.jobsDetail?.maxSalaryExpectation}" , style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),),
                                ],
                              ),
                            ),
                          ),
                          CircularPercentIndicator(
                              percent: data?.jobMatchPercentage/100,
                              progressColor: AppColors.green,
                              backgroundColor: AppColors.white,
                              center: Column( mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${data?.jobMatchPercentage}%" , style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black),),
                                  Text("match" , style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black),),
                                ],
                              ),
                              lineWidth: 12,
                              radius: 40),
                        ],
                      ),
                    ),
                  ) ,
                  SizedBox(height: Get.height * .02,)
                ],
              ) ;
            }) ,

          ],
        ),
      ),
    );
  }
}
