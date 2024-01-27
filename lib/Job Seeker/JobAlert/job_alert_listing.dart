
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/SeekerJobAlertListController/SeekerJobAlertListController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';
import 'job_alert.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {

  SeekerJobAlertListController seekerJobAlertListControllerInstanse = Get.put(SeekerJobAlertListController()) ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
  }

  @override
  Widget build(BuildContext context) {
    return
    Obx(() {
      switch (seekerJobAlertListControllerInstanse.rxRequestStatus.value) {
        case Status.LOADING:
          return const
          Scaffold(body: Center(child: CircularProgressIndicator()),);

        case Status.ERROR:
          if (seekerJobAlertListControllerInstanse.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
              },
            );
          } else {
            return GeneralExceptionWidget(onPress: () {
              seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
            });
          }
        case Status.COMPLETED:
          return
     Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: AppColors.black,
        leading: GestureDetector(
          onTap: () {
            Get.back() ;
          },
          child: Image.asset(
            "assets/images/icon_back_blue.png",
          ),
        ),
        title: Text("Job Alerts",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: Get.height*.04,) ,
            seekerJobAlertListControllerInstanse.viewSeekerJobAlertListData.value.jobAlertList?.length == null ||
                seekerJobAlertListControllerInstanse.viewSeekerJobAlertListData.value.jobAlertList?.length == 0 ?
                Center(
                    child: Text("No data",style: Theme.of(context).textTheme.titleSmall,)) :
            Container(
              height: Get.height*.7,
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: seekerJobAlertListControllerInstanse.viewSeekerJobAlertListData.value.jobAlertList?.length,
                  physics:  const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Get.height*.02),
                      child: Container(
                       decoration:  const BoxDecoration(
                         color: AppColors.textFieldFilledColor,
                         borderRadius: BorderRadius.all(
                             Radius.circular(13)
                         )
                       ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: Get.height*.02,horizontal: Get.width*.03),
                          title: Text(
                           "${seekerJobAlertListControllerInstanse.viewSeekerJobAlertListData.value.jobAlertList?[index].positions}" ??  "No position",
                          overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(seekerJobAlertListControllerInstanse.viewSeekerJobAlertListData.value.jobAlertList?[index].location ?? "No lacation",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),

                        ),
                      ),
                    ) ;
                  },),
            ),
            SizedBox(height: Get.height*.03,) ,
            MyButton(title: "MANAGE ALERTS", onTap1: () {
              Get.to(() => const SetJobAlert()) ;
            },)
          ],
        ),
      ),
    );
  }
}
);
  }
}
