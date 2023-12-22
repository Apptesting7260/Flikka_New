import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/TalentPoolController/RemoveFromPoolController.dart';
import 'package:flikka/controllers/TalentPoolController/TalentPoolController.dart';
import 'package:flikka/hiring%20Manager/schedule_interview.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';

class TalentPool extends StatefulWidget {
  const TalentPool({super.key});

  @override
  State<TalentPool> createState() => _TalentPoolState();
}

class _TalentPoolState extends State<TalentPool> {

  TalentPoolController poolController = Get.put(TalentPoolController()) ;
  RemoveFromTalentPoolController removeController = Get.put(RemoveFromTalentPoolController()) ;

  @override
  void initState() {
   poolController.talentPoolApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (poolController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (poolController.error.value == 'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  poolController.talentPoolApi() ;
                },
              ),);
          } else if (poolController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              poolController.talentPoolApi() ;
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              poolController.talentPoolApi() ;
            }),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                child: poolController.poolData.value.data?.length == 0 ||
                    poolController.poolData.value.data == null ?
                const Center(child: Text("No profiles have been selected for talent pool." ,
                  textAlign: TextAlign.center,)) :
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: poolController.poolData.value.data?.length,
                        itemBuilder: (context, index) {
                          var data = poolController.poolData.value.data?[index] ;
                          return Container(
                            width: Get.width,
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.symmetric(vertical: Get.height * .027),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: const Color(0xff353535)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height * .013,),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    minVerticalPadding: 12,
                                    leading: CachedNetworkImage(
                                      imageUrl: "${data?.seekerData?.profileImg}",
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
                                    title: Text(data?.seekerData?.fullname ?? "No data", style: Theme.of(context)
                                        .textTheme.titleLarge?.copyWith(color: const Color(0xffFFFFFF)),),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Get.height * .003,),
                                        Text( data?.seekerDetailsInfo?.positions ?? "No positions",
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color:
                                            const Color(0xffCFCFCF), fontWeight: FontWeight.w600)
                                        ),
                                        SizedBox(height: Get.height * .003,),
                                        Text( data?.seekerData?.location ?? "No location", overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme
                                            .labelLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
                                        // SizedBox(height: Get.height * .003,),
                                        // Text(
                                        //     "TALENT POOL",
                                        //     style: Theme.of(context).textTheme.bodySmall?.copyWith
                                        //       (color: const Color(0xffFFFFFF), fontWeight: FontWeight.w700)
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.height * .02,),
                                  Center(
                                    child: MyButton(
                                      height: Get.height * .066,
                                      width: Get.width*.75,
                                      title: "VIEW PROFILE", onTap1: () {
                                        Get.to( () => ScheduleInterview(seekerID:"${data?.seekerId}" , requestID: "",talentPool: true, scheduleInterview: false,)) ;
                                    },),
                                  ),
                                  SizedBox(height: Get.height * .02,),
                                  Center(
                                    child: MyButton(
                                      // loading: removeController.loading.value,
                                        height: Get.height * .066,
                                        width: Get.width*.75,
                                        title: "REMOVE PROFILE", onTap1: () {
                                        CommonFunctions.confirmationDialog(context, message: "Do you want remove this profile", onTap: () {
                                          Get.back() ;
                                          CommonFunctions.showLoadingDialog(context, "Removing...") ;
                                          if (!removeController.loading.value) {
                                            if (kDebugMode) {
                                              print(data?.seekerId.toString()) ;
                                            }
                                            removeController.removeSeeker(context, data?.seekerId.toString());
                                          }
                                        }
                                      ) ;
                                      },),
                                  )
                                ],
                              ),
                            ),
                          );
                        },),
                      SizedBox(height: Get.height * .1,),
                    ],
                  ),
                ),
              ),
            ),
          );
      }
    }
    );
  }
}
