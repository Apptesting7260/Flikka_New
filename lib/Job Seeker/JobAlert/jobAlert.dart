
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerChoosePositionGetModel/SeekerChoosePositionGetModel.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/SetJobAlertController/SetJobAlertController.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';

class SetJobAlert extends StatefulWidget {
  const SetJobAlert({Key? key}) : super(key: key);

  @override
  State<SetJobAlert> createState() => _SetJobAlertState();
}

class _SetJobAlertState extends State<SetJobAlert> {

  @override
  void initState() {
    super.initState();
    // seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
  }

  SeekerChoosePositionGetController seekerChoosePositionGetControllerInstanse = Get.put(SeekerChoosePositionGetController());

  SetJobAlertController alertController = Get.put(SetJobAlertController()) ;

  List<SeekerPositionData>? filteredPositionNames = [];
  List<String> positions = [];
  var id ;

  TextEditingController searchController = TextEditingController() ;

//////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
/////refresh/////

  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
        switch (seekerChoosePositionGetControllerInstanse.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator()),
            );

          case Status.ERROR:
            if (seekerChoosePositionGetControllerInstanse
                .error.value ==
                'No internet') {
              return Scaffold(body: InterNetExceptionWidget(
                onPress: () {
                  seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
                },
              ),);
            } else {
              return Scaffold(body: GeneralExceptionWidget(
                  onPress: () {
                    seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
                  }) ,);
            }
          case Status.COMPLETED:
            return Scaffold(
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
                title: Text("Manage Alerts",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
              ),
              // resizeToAvoidBottomInset: false,
              body: SmartRefresher(
                controller: _refreshController,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * .010,
                        ),
                        Obx(() =>
                        seekerChoosePositionGetControllerInstanse.refreshLoading.value ?
                        const Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        ),)
                            : const SizedBox()
                        ),
                        SizedBox(height: Get.height*.02,),
                        TextFormField(
                          controller: searchController,
                          style: Theme.of(context).textTheme
                              .bodyLarge?.copyWith(
                              color: const Color(0xffCFCFCF),
                              fontSize: 19),
                          onChanged: (query) {
                            seekerChoosePositionGetControllerInstanse.filterList(query) ;
                            // setState(() {
                            //  filteredPositionNames = seekerChoosePositionGetControllerInstanse.
                            //  seekerChoosePositionGetList.value.data?.where((element) =>
                            //  element.positions!.toLowerCase().contains(query.toLowerCase())).toList() ;
                            // }) ;
                            // print(filteredPositionNames) ;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search,color: AppColors.blueThemeColor,size: 22,),
                            filled: true,
                            fillColor: AppColors.textFieldFilledColor,

                            hintText: 'Search',
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                color: const Color(0xffCFCFCF)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide: BorderSide.none
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        SizedBox(
                          height: Get.height*.45,
                          // padding: EdgeInsets.only(bottom: 12),
                          child:
                          Obx( () =>
                          seekerChoosePositionGetControllerInstanse.positionsList == null ||
                              seekerChoosePositionGetControllerInstanse.positionsList?.length == 0 ?
                          const Text("No Data")
                              : ListView.builder(
                            itemCount: seekerChoosePositionGetControllerInstanse.positionsList?.value.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * .002),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(positions.contains(seekerChoosePositionGetControllerInstanse.positionsList![index].id.toString())) {
                                        positions.remove(seekerChoosePositionGetControllerInstanse.positionsList![index].id.toString()) ;
                                      }else{
                                        positions.add(seekerChoosePositionGetControllerInstanse.positionsList![index].id.toString()) ;
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${seekerChoosePositionGetControllerInstanse.positionsList?[index].positions}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                              fontWeight:
                                              FontWeight.w500,
                                              color: const Color(0xffFFFFFF)),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: Get.width * .06,
                                            height: Get.height *
                                                .05,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape
                                                    .circle,
                                                color: AppColors.blueThemeColor
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Color(
                                                  0xffFFFFFF),
                                              size: 15,
                                            ),
                                          ),
                                          if (!positions.contains(seekerChoosePositionGetControllerInstanse.positionsList![index].id.toString()))
                                            Center(
                                              child: Container(
                                                width: Get.width *
                                                    .05,
                                                height: Get.width *
                                                    .05,
                                                decoration:
                                                const BoxDecoration(
                                                  color:
                                                  Color(0xff000000),
                                                  shape:
                                                  BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Obx(() =>  Center(
                          child: MyButton(
                            width:Get.width*.77,
                            loading: alertController.loading.value,
                            title: "SUBMIT",
                            onTap1: () {
                              if(positions.isEmpty){
                                Utils.showMessageDialog(context, "Select position to get job alerts") ;
                              } else {
                                if (!alertController.loading.value) {
                                  alertController.setJobAlert(
                                      context, positions);
                                }
                              }
                            },
                          ),
                        ),) ,
                        SizedBox(
                          height: Get.height * .04,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }});
  }
}
