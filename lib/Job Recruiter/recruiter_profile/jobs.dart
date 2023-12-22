import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/ViewRecruiterJob.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/RecruiterDeleteJobController/RecruiterDeleteJobController.dart';
import '../AddJobPage/add_a_job_page_area.dart';

class RecruiterJobs extends StatefulWidget {
  final RxList<RecruiterJobsData>? recruiterJobsData ;
  final String? company ; final String? location ; final bool? isSeeker ;
  const RecruiterJobs({super.key, this.recruiterJobsData, this.company, this.location, this.isSeeker});

  @override
  State<RecruiterJobs> createState() => _RecruiterJobsState();
}

class _RecruiterJobsState extends State<RecruiterJobs> {

  RecruiterDeleteJobController deleteJobController = Get.put(RecruiterDeleteJobController()) ;

  String formatDateTime(DateTime? dateTime) {
    if(dateTime != null) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks > 1 ? 's' : ''} ago';
      } else {
        final months = difference.inDays ~/ 30;
        return '$months month${months > 1 ? 's' : ''} ago';
      }
    }else {
      return "No Data" ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0x000ff000),
        body: SingleChildScrollView(
          child: widget.recruiterJobsData?.length == 0 || widget.recruiterJobsData == null ?
          Center(
            child: Column( crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*.05,),
              Text("No jobs have been posted",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),),
             SizedBox(height: Get.height*.1,),
             widget.isSeeker == true ? const SizedBox() : GestureDetector(
                  onTap: () { Get.to(const AddAJobPage()) ; },
                    child: Text("Add a job",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor),)),
              ],
            ),
          ) :
          Column(
            children: [
              SizedBox(height: Get.height*.02,),
              Obx( () =>
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.recruiterJobsData?.value.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = widget.recruiterJobsData?.value[index] ;
                    String uploadingTime = formatDateTime(data?.createdAt) ;
                    print("${data?.featureImg}") ;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      // height: Get.height*.18,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff353535),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(

                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        onTap: () {
                          if(widget.isSeeker == true) {
                            Get.to( () => ViewRecruiterJob(recruiterJobsData: data , company: widget.company, isSeeker: true,)) ;
                          }else{
                            Get.to( () => ViewRecruiterJob(recruiterJobsData: data , company: widget.company,)) ;
                          }
                        },
                        minVerticalPadding: 13,
                        leading: CachedNetworkImage(
                          imageUrl: "${data?.featureImg}",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image:  DecorationImage(
                                image: imageProvider,fit: BoxFit.cover
                              ) ,
                            ),
                          ),
                          placeholder: (context, url) => const CircularProgressIndicator(),
                        ),
                        title: Text(data?.jobTitle ?? "",overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Color(0xffFFFFFF),fontWeight: FontWeight.w700),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data?.jobPositions ?? "",overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.001,),
                            Text(widget.company ?? "",overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge?.copyWith(color: const Color(0xffCFCFCF),fontWeight: FontWeight.w400)
                            ),
                            SizedBox(height: Get.height*.001,),
                            Text(data?.jobLocation ?? "No Data",overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.001,),
                            Text(uploadingTime,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: const Color(0xff9D9D9D),fontWeight: FontWeight.w400)
                            ),
                          ],
                        ),
                        trailing: widget.isSeeker == true ? const SizedBox() : PopupMenuButton<int>(
                          onSelected: (value) {
                            // Handle the selected option
                            switch (value) {
                              case 1:
                              Get.to( () => ViewRecruiterJob(recruiterJobsData: data , company: widget.company,)) ;
                                break;
                              case 2:
                              Get.to( () => AddAJobPage(recruiterJobsData: data,)) ;
                                break;
                              case 3:
                              CommonFunctions.confirmationDialog(context, message: "Do you want to delete",
                                  onTap: () {
                                Get.back() ;
                                CommonFunctions.showLoadingDialog(context, "Deleting") ;
                                deleteJobController.deleteApi(data?.id) ;
                                  }) ;
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<int>>[
                              PopupMenuItem<int>(
                                value: 1,
                                child: Text('View',  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF))),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: Text('Edit',  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF))),
                              ),
                              PopupMenuItem<int>(
                                value: 3,
                                child: Text('Delete',  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF))),
                              ),
                            ];
                          },
                          child:const Icon(Icons.more_vert, color: Colors.white, size: 25),
                        ),
                      ),
                      ),
                  );
                },
                ),
              )
            ],
          ),
        ),
    )
    );
  }
}
