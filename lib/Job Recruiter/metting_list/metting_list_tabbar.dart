
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/AddInOngoingController/AddInOngoingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Job Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import '../../controllers/InterViewConfirmationController.dart';
import '../../controllers/SeekerViewInterviewAllController/SeekerViewInterviewAllController.dart';
import '../../controllers/SeenUnSeenPendingInterviewController/SeenUnSeenPendingInterviewController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';


class MettingListTabbar extends StatefulWidget {
  const MettingListTabbar({super.key});

  @override
  State<MettingListTabbar> createState() => _MettingListTabbarState();
}


class _MettingListTabbarState extends State<MettingListTabbar> {

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  SeekerViewInterviewAllController interviewListController = Get.put(SeekerViewInterviewAllController()) ;

  void _onRefresh() async{
    interviewListController.seekerInterViewListApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    interviewListController.seekerInterViewListApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////
  SeenUnSeenInterviewPendingController seenUnSeenInterviewPendingControllerInstanse = Get.put(SeenUnSeenInterviewPendingController()) ;
  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());

  final List<String> jobTypeItems = ['Ongoing','Upcoming','Past','All',];
  String? jobTypeValues;

  AddInOngoingController ongoingController = Get.put(AddInOngoingController()) ;
  AddInOngoingController addInOngoingController = Get.put(AddInOngoingController()) ;
  InterViewConfirmationController interviewConfirmationController = Get.put(InterViewConfirmationController()) ;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (interviewListController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (interviewListController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  interviewListController.seekerInterViewListApi();
                },
              ),);
          } else
          if (interviewListController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              interviewListController.seekerInterViewListApi();
            }),);
          }  else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              interviewListController.seekerInterViewListApi();
            }),);
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                toolbarHeight: 75,
                leading: IconButton(
                    onPressed: () {
                      Get.offAll(const TabScreen(index: 0)) ;
                      seenUnSeenInterviewPendingControllerInstanse.seenUnSeenPendingInterviewAPi(
                          context,seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
                      }, icon:
                Image.asset("assets/images/icon_back_blue.png",
                  height: Get.height * .06,)) ,
                title:Text("Interviews", style: Get.theme.textTheme
                    .displayLarge),
              ),
              body: PopScope(
                canPop: true,
                onPopInvoked: (didPop) {
                  if(didPop) {
                    seenUnSeenInterviewPendingControllerInstanse.seenUnSeenPendingInterviewAPi(
                        context,seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
                  }
                },
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // SizedBox(height: Get.height * .02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Interviews", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w700,
                                  color: Color(0xffFFFFFF))),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      const SizedBox(width: 2,),
                                      Expanded(
                                        child: Text(
                                          'Filter',
                                          style: Get.theme.textTheme.bodyLarge!
                                              .copyWith(color: AppColors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: jobTypeItems.map((String item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: Get.theme.textTheme.bodyLarge!
                                              .copyWith(color: AppColors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )).toList(),
                                  value: jobTypeValues,
                                  onChanged: (String? value) {
                                    setState(() {
                                      jobTypeValues = value;
                                      interviewListController.seekerInterViewListApi(filter: jobTypeValues);
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: Get.height * 0.05,
                                    width: Get.width * .26,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(color: Color(0xff686868))
                                      // color: Color(0xff353535),
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: Image.asset('assets/images/arrowdown.png'),
                                    iconSize: 14,
                                    iconEnabledColor: Colors.yellow,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: Get.height * 0.35,
                                    width: Get.width * 0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Color(0xff353535),
                                    ),
                                    offset: const Offset(5, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: Radius.circular(40),
                                      thickness: MaterialStateProperty.all<double>(
                                          6),
                                      thumbVisibility: MaterialStateProperty.all<
                                          bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding: EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * .01,),

                          interviewListController.seekerInterViewData.value.interviewSchedule == null ||
                              interviewListController.seekerInterViewData.value.interviewSchedule?.length == 0 ?
                          Text("No Data", style: Theme.of(context).textTheme.bodyLarge?.
                          copyWith(fontWeight: FontWeight.w700, color: const Color(0xffFFFFFF))) :
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: interviewListController.seekerInterViewData.value.interviewSchedule?.length,
                            itemBuilder: (context, index) {
                              var data = interviewListController.seekerInterViewData.value.interviewSchedule?[index] ;
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: Get.height * .027),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: const Color(0xff353535)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * .06),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Get.height * .013,),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          // minVerticalPadding: 12,
                                          leading: CachedNetworkImage(
                                              imageUrl: data?.seekerlist?.profileImg ?? "",
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white,),
                                          ),
                                          title: Text( data?.seekerlist?.fullname ?? "No data", style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                              color: const Color(0xffFFFFFF)),),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( data?.jobDetails?.jobTitle ?? "No job title",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                      color: const Color(0xffCFCFCF),
                                                      fontWeight: FontWeight.w600)
                                              ),
                                              SizedBox(height: Get.height * .003,),
                                              Text( data?.seekerlist?.location ?? "No location", style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xffCFCFCF)),),
                                            ],
                                          ),
                                          trailing: Obx(() => interviewListController.seekerInterViewData.value.interviewSchedule?[index].isNewInterview == true ?
                                             Container(
                                              height: 23,
                                              width: 23,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle ,
                                                color: AppColors.red,
                                              ),
                                              child: Text("New",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 7,fontWeight: FontWeight.w400,color: AppColors.white),),
                                            )
                                           : const SizedBox()
                                          )
                                        ),
                                        SizedBox(height: Get.height * .025,),
                                        HtmlWidget(data?.seekerlist?.aboutMe ?? "No about",textStyle: Theme.of(context).textTheme
                                            .bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
                                        SizedBox(height: Get.height * .03,),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/icon_calendar.png",
                                              height: Get.height * .026,
                                              color: Color(0xff56B8F6),),
                                            SizedBox(width: Get.width * .02,),
                                            Text("${data?.interviewScheduleTime?.month}-${data?.interviewScheduleTime?.day}-${data?.interviewScheduleTime?.year}", style: Theme
                                                .of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffFFFFFF)),),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * .02,),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/icon_watch.png",
                                              height: Get.height * .026,
                                              color: const Color(0xff56B8F6),),
                                            SizedBox(width: Get.width * .02,),
                                            Text("${data?.interviewScheduleTime?.hour.toString().padLeft(2,"0")} : ${data?.interviewScheduleTime?.minute.toString().padLeft(2,"0")}", style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffCFCFCF)),),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * .03,),
                                        data?.interviewLink == null || data?.interviewLink?.length == 0 ?
                                        const SizedBox() :
                                        GestureDetector(
                                          onTap: () {
                                            launchUrl(Uri.parse("${data?.interviewLink}"),
                                                mode: LaunchMode.externalApplication) ;
                                          },
                                          child: Text(data?.interviewLink ?? "No Data",style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blueThemeColor)),
                                        ) ,
                                        SizedBox(height: Get.height * .031,),
                                        data?.ongoing == true ?  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() =>
                                                MyButton(
                                                  loading: interviewConfirmationController.loading.value,
                                                  width: Get.width*.38 ,
                                                  height: Get.height * .066,
                                                  title: "COMPLETE", onTap1: () {
                                                  CommonFunctions.confirmationDialog(context, message: "Do you want to complete the interview", onTap: () async {
                                                    Get.back() ;
                                                    if(!interviewConfirmationController.loading.value){
                                                      var result = await interviewConfirmationController.interViewConfirmationApi("${data?.id}", "done", "", context) ;
                                                      if(result){
                                                        setState(() {
                                                          jobTypeValues = "All" ;
                                                        });
                                                      }
                                                    }
                                                  },) ;


                                                },),
                                            ),
                                            MyButton(
                                              width: Get.width*.38,
                                              height: Get.height * .066,
                                              title: "DECLINE", onTap1: () {
                                              interViewCancleReason("${data?.id}") ;
                                            },),
                                          ],
                                        ):
                                        data?.interviewScheduleTime?.isBefore(DateTime.now()) ? SizedBox() :  Center(
                                          child: MyButton(
                                            height: Get.height * .066,
                                            width: Get.width * .75,
                                            title: "JOIN", onTap1: () {
                                            addInOngoingController.ongoingApi(context, "${data?.id}") ;
                                          launchUrl(Uri.parse("${data?.interviewLink}"),
                                          mode: LaunchMode.externalApplication) ;
                                          },),
                                        ),
                                        SizedBox(height: Get.height * .031,),
                                    ]),
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
              ),
            ),
          );
      }
    }
    );
  }

  interViewCancleReason(
      String requestId
      ) {
    TextEditingController reasonController = TextEditingController() ;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter reason to decline",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),) ,
                SizedBox(height: Get.height * 0.02,),
                TextField(
                  maxLines: 4,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                  onChanged: (String value) {},
                  controller: reasonController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff373737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none
                    ),
                    hintText: 'Enter your reason',
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.white, fontSize: 12),
                  ),
                ),
                SizedBox(height: Get.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() =>
                        MyButton(
                          loading: interviewConfirmationController.loading.value,
                          width: Get.width*.38 ,
                          height: Get.height * .066,
                          title: "SUBMIT", onTap1: () async {
                          if(!interviewConfirmationController.loading.value) {
                            var result = await interviewConfirmationController.interViewConfirmationApi(requestId, "decline", reasonController.text, context);
                            if(result){
                              setState(() {
                                jobTypeValues = "All" ;
                              });
                            }
                          }
                        },),
                    ),
                    MyButton(
                      width: Get.width*.38,
                      height: Get.height * .066,
                      title: "CANCEL", onTap1: () {
                      Get.back() ;
                    },),
                  ],
                ),
                SizedBox(height: Get.height * 0.02,),
              ],
            ),
          ),
        );
      },
    );
  }

}
