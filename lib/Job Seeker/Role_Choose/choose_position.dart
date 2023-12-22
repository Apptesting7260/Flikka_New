import 'package:flikka/controllers/ChoosePositionController/SeekerChoosePositionController.dart';
import 'package:flikka/controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import 'package:flikka/controllers/SkipStepController/SkipStepController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/SeekerChoosePositionGetModel/SeekerChoosePositionGetModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';

class ChoosePosition extends StatefulWidget {
  const ChoosePosition({Key? key}) : super(key: key);

  @override
  State<ChoosePosition> createState() => _ChoosePositionState();
}

class _ChoosePositionState extends State<ChoosePosition> {
RxBool goToNext = false.obs;

  @override
  void initState() {
    super.initState();
    seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
    // filteredPositionNames = List.from(positionNames);

  }

  SeekerChoosePositionGetController seekerChoosePositionGetControllerInstanse = Get.put(SeekerChoosePositionGetController());

  SeekerChoosePositionController seekerChoosePositionController = Get.put(SeekerChoosePositionController()) ;
  SkipStepController skipStepController = Get.put(SkipStepController()) ;

int? _selectedPositionIndex;

  List<SeekerPositionData>? filteredPositionNames = [];
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

void showSkipDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(backgroundColor: Color(0xff353535),)) ,
                  SizedBox(width: Get.width*.1,),
                  Text("Skipping...",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),) ,
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return
      Obx(() {
      switch (seekerChoosePositionGetControllerInstanse
          .rxRequestStatus.value) {
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
            ) ,)
             ;
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {
                  seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
                }) ,)
             ;
          }
        case Status.COMPLETED:
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SmartRefresher(
                controller: _refreshController,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: AppColors.blueThemeColor
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                            SizedBox(
                              height: Get.height * .010,
                            ),
                            Row(crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * .05),
                                      child: Image.asset(
                                        "assets/images/icon_back.png",
                                        height: Get.height * .055,
                                      ),
                                    )),
                                TextButton(onPressed: (){
                                  skipStepController.skipStepApi(1) ;
                                  CommonFunctions.showLoadingDialog(context, "Skipping") ;
                                },
                                    child: const Text("Skip",
                                    style: TextStyle(color: Colors.white ,
                                    fontSize: 16),))
                              ],
                            ),
                            SizedBox(
                              height: Get.height * .035,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: Get.width *
                                      .05),
                                  child: Text(
                                    "Choose Position",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                      fontSize: 30,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .05),
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffFFFFFF)),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .03,
                            ),
                          ],
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.72, // half screen
                        minChildSize: 0.72, // half screen
                        maxChildSize: 0.72, // full screen
                        builder:
                            (BuildContext context,
                            ScrollController scrollController) {
                          return Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                                color: Colors.black),
                            // color: Colors.black,
                            child: SingleChildScrollView(
                              // controller: scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Container(
                                height: Get.height,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xff000000),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(33.0),
                                    topRight: Radius.circular(33.0),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(
                                      horizontal: Get.width * .07),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Get.height * .02,
                                      ),
                                      Obx(() => seekerChoosePositionController.errorMessage.value.isEmpty ?
                                      const SizedBox() : Text(seekerChoosePositionController.errorMessage.value,
                                      style: const TextStyle(color: Colors.red),)
                                      ) ,
                                      SizedBox(
                                        height: Get.height * .03,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * .05,
                                            vertical: Get.height * .010),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff373737),
                                          borderRadius: BorderRadius.circular(
                                              33.0),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: AppColors.blueThemeColor,
                                              size: 30,
                                            ),
                                            SizedBox(width: Get.width * .03),
                                            Expanded(
                                              child:
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
                                                    hintText: 'Search',
                                                    hintStyle: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                        color: const Color(0xffCFCFCF)),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * .04,
                                      ),

                                      SizedBox(
                                        height: Get.height*.35,
                                        // padding: EdgeInsets.only(bottom: 12),
                                        child:
                                          Obx( () =>
                                             ListView.builder(
                                              //physics: const AlwaysScrollableScrollPhysics(),
                                              itemCount: seekerChoosePositionGetControllerInstanse.positionsList?.value.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: Get.height * .002),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      id= seekerChoosePositionGetControllerInstanse.positionsList?[index]
                                                          .id.toString();

                                                      print("***********************"+'$id');
                                                      setState(() {
                                                        if (_selectedPositionIndex ==
                                                            index) {
                                                        } else {
                                                          _selectedPositionIndex =
                                                              index;
                                                        }
                                                        print(index);
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${ seekerChoosePositionGetControllerInstanse.positionsList?[index].positions}",
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
                                                                // gradient: LinearGradient(
                                                                //   colors: [
                                                                //     Color(0xff56B6F6),
                                                                //     Color(0xff4D6FED)
                                                                //   ],
                                                                //   begin:
                                                                //   Alignment.topLeft,
                                                                //   end: Alignment
                                                                //       .bottomRight,
                                                                // ),
                                                                  color: AppColors.blueThemeColor
                                                              ),
                                                              child: const Icon(
                                                                Icons.check,
                                                                color: Color(
                                                                    0xffFFFFFF),
                                                                size: 15,
                                                              ),
                                                            ),
                                                            if (_selectedPositionIndex !=
                                                                index)
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
                                        height: Get.height * .05,
                                      ),

                                    Obx(() =>  Center(
                                      child: MyButton(
                                        width:Get.width*.77,
                                        loading: seekerChoosePositionController.loading.value,
                                        title: "CONTINUE",
                                        onTap1: () {
                                          seekerChoosePositionController.errorMessage.value = "" ;
                                          if(id == null) {
                                            seekerChoosePositionController.errorMessage.value = "Please select a field" ;
                                          }
                                          else {
                                            print(seekerChoosePositionController.loading.value);
                                            if(seekerChoosePositionController.loading.value){}
                                            else {
                                              seekerChoosePositionController.seekerChoosePositionApiHit(id,context);
                                            }
                                          }
                                          // Get.to(() => ChooseSkills());


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
                        },
                      ),
                    ],
                  ),
                ),
              ),

            );
      }});
  }
}
