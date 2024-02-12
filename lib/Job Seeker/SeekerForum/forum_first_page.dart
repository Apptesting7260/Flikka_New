import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/TabBarController.dart';
import 'package:flikka/Job%20Seeker/SeekerForum/add_new_forum.dart';
import 'package:flikka/controllers/SeekerForumController/ForumIndustryListController.dart';
import 'package:flikka/controllers/SeekerForumController/SeekerForumDataController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../SeekerChatMessage/message_page.dart';
import 'forum_only_comment_page.dart';

class ForumFirstPage extends StatefulWidget {
  const ForumFirstPage({super.key});

  @override
  State<ForumFirstPage> createState() => _ForumFirstPageState();
}

class _ForumFirstPageState extends State<ForumFirstPage> {

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    forumDataController.seekerForumListApi(page: "1");
    industryID = null ;
    _refreshController.refreshCompleted();
  }

  final ScrollController _scrollController = ScrollController() ;

  // void _onLoading() async{
  //    forumDataController.seekerForumListApi();
  //   if(mounted)
  //     setState(() {
  //
  //     });
  //   _refreshController.loadComplete();
  // }
  /////refresh/////

  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;
  SeekerForumIndustryController industryController = Get.put(SeekerForumIndustryController()) ;

  dynamic industryID ;
  int page = 1 ;

  // void scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent &&
  //       !_scrollController.position.outOfRange) {
  //     if (kDebugMode) {
  //       print("step 1") ;
  //     }
  //     if(!forumDataController.loadingPage.value) {
  //       if (kDebugMode) {
  //         print("step 2") ;
  //       }
  //       if (forumDataController.forumData.value.isLast == false) {
  //         page++;
  //         if (kDebugMode) {
  //           print("step 3") ;
  //         }
  //         if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
  //           forumDataController.paginationForumApi(page: "$page");
  //           if (kDebugMode) {
  //             print("step 4") ;
  //           }
  //         }
  //       }
  //     }
  //   }
  // // }

  @override
  void initState() {
    _scrollController.addListener( () {

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
        if (kDebugMode) {
          print("step 1");
        }
        if (!forumDataController.loadingPage.value) {
          if (kDebugMode) {
            print("step 2");
          }
          if (forumDataController.forumData.value.isLast == false) {
            page++;
            if (kDebugMode) {
              print("step 3");
            }
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              forumDataController.paginationForumApi(page: "$page");
              if (kDebugMode) {
                print("step 4");
              }
            }
          }
        }
      }
    }
    ) ;
    super.initState();
  }

  TabBarController tabBarController = Get.put(TabBarController()) ;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (forumDataController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (forumDataController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  forumDataController.seekerForumListApi(page: "1");
                },
              ),);
          }  else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              forumDataController.seekerForumListApi(page: "1");
            }),);
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (industryController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),);
              case Status.ERROR:
                if (industryController.error.value ==
                    'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        industryController.industryApi();
                      },
                    ),);
                } else
                if (industryController.error.value == 'Request Time out') {
                  return Scaffold(body: RequestTimeoutWidget(onPress: () {
                    industryController.industryApi();
                  }),);
                } else {
                  return Scaffold(body: GeneralExceptionWidget(onPress: () {
                    industryController.industryApi();
                  }),);
                }
              case Status.COMPLETED:
                return Scaffold(
                  backgroundColor: AppColors.lightHomeGrey,
                  appBar: AppBar(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: AppColors.lightHomeGrey,
                    toolbarHeight: 50,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: GestureDetector(
                          onTap: () {
                            tabBarController.bottomTapped(0);
                          },
                          child: Image.asset('assets/images/icon_back_blue.png')),
                    ),
                    elevation: 0,
                    // title: Text("Forum", style: Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.black)),
                  ),
                  body: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      // scrollController: _scrollController,
                      child:   DefaultTabController(
                          length: 2,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const TabBar(
                                    isScrollable: true,
                                    labelColor: AppColors.blueThemeColor,
                                    unselectedLabelColor: AppColors.black,
                                    indicatorColor: AppColors.blueThemeColor,
                                    indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                                    tabs: [
                                      Tab(child: Text("FORUM"),),
                                      Tab(child: Text("MESSAGE"),),
                                    ]
                                ),
                                SizedBox(
                                  height: Get.height *.8 ,
                                  child: TabBarView(
                                      children: [
                                        SingleChildScrollView(
                                          controller: _scrollController,
                                          child: Column(
                                            children: [
                                              industryController.industryData.value.industryList == null ||
                                                  industryController.industryData.value.industryList?.length == 0 ?
                                              const SizedBox() :
                                              SizedBox(
                                                height: Get.height * .17,
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          industryID = null ;
                                                          forumDataController.forumList?.value = forumDataController.forumData.value.forumData ?? [] ;
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                padding: const EdgeInsets.all(3),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    border: Border.all(color: industryID == null ? AppColors.blueThemeColor : AppColors.black,width: 2)
                                                                ),
                                                                child: Container(
                                                                  height: 60,
                                                                  width: 60,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle ,
                                                                      image: DecorationImage(
                                                                          image: AssetImage("assets/images/icon_app_icon.png",),fit: BoxFit.cover
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: Get.height * .01,),
                                                              Text("All",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                                  color: industryID == null ? AppColors.blueThemeColor : AppColors.black,fontWeight: FontWeight.w700),),
                                                            ],
                                                          ),
                                                        )) ,
                                                    SizedBox(width: Get.width*.01,) ,
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: Get.width *.8,
                                                        child: ListView.builder(shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: industryController.industryData.value.industryList?.length,
                                                            itemBuilder: (BuildContext context, int index) {
                                                              var data = industryController.industryData.value.industryList?[index] ;
                                                              return Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: SizedBox( width: Get.width * 0.17,
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      industryID = data?.id.toString() ;
                                                                      // forumDataController.seekerForumListApi(industryID: "$industryID");
                                                                      if(forumDataController.forumData.value.forumData != null) {
                                                                        forumDataController.forumList?.value = forumDataController.forumData.value.forumData
                                                                        !.where((e) {
                                                                          return  e.industryId.toString() == data?.id.toString(); }).toList();
                                                                      }
                                                                    },
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.all(3),
                                                                              decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  border: Border.all(color: data?.id.toString() == industryID.toString() ?
                                                                                  AppColors.blueThemeColor : AppColors.black,width: 2)
                                                                              ),
                                                                              child: CachedNetworkImage(imageUrl: data?.industryImg ?? "" ,
                                                                                placeholder: (context, url) => const Center(
                                                                                  child: CircularProgressIndicator(),),
                                                                                imageBuilder: (context, imageProvider) => Container(
                                                                                  height: 60,
                                                                                  width: 60,
                                                                                  decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle ,
                                                                                      image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                                                                                  ),

                                                                                ),
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ) ,
                                                                        SizedBox(height: Get.height * .01,),
                                                                        Text(data?.industryPreferences ?? "", overflow: TextOverflow.ellipsis,
                                                                          style: Theme.of(context).textTheme.bodyMedium
                                                                              ?.copyWith(fontWeight: FontWeight.w700 ,
                                                                              color: data?.id.toString() == industryID.toString() ?
                                                                              AppColors.blueThemeColor : AppColors.black),),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: Get.height * .01,),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(right: Get.width*.04),
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: Get.width * .05,),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.white,
                                                          borderRadius: BorderRadius.circular(33.0),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.search, color: AppColors.blueThemeColor,
                                                              size: 30,),
                                                            SizedBox(width: Get.width * .03),
                                                            Expanded(
                                                              child: TextFormField(
                                                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                    color: AppColors.black, fontSize: 15),
                                                                onChanged: (query) {
                                                                  forumDataController.filterList(query) ;
                                                                },
                                                                decoration: InputDecoration(
                                                                  hintText: 'Let’s talk',
                                                                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                      color: Color(0xffA0A0A0)), border: InputBorder.none,),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(right: Get.width*.07),
                                                        height: Get.height * 0.06,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              Get.to(() => AddNewForum(list: industryController.industryData.value.industryList ,));
                                                            },
                                                            child: Image.asset('assets/images/icon_add_form.png',
                                                              fit: BoxFit.cover,))),
                                                    // GestureDetector(
                                                    //     onTap: () {
                                                    //       Get.to(() =>const SeekerMessagePage());
                                                    //     },
                                                    //     child: Image.asset("assets/images/icon_msg_blue.png",height: Get.height*.06,)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * .015,
                                              ),
                                              //************* list *((((((((((((((((((((((((((((((((
                                              Column(
                                                children: [
                                                  forumDataController.forumList == null || forumDataController.forumList?.length == 0 ?
                                                  Column(
                                                    children: [
                                                      SizedBox(height: Get.height*.2,) ,
                                                      const Text("No Data"),
                                                    ],
                                                  ) :
                                                  ListView.builder(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: forumDataController.forumList?.length,
                                                      itemBuilder: (context, index) {
                                                        var data = forumDataController.forumList?[index];
                                                        return Padding(padding: EdgeInsets.symmetric(vertical: Get.height * .01),
                                                          child: Stack(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.only(left: 7.0, top: 15),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.white,
                                                                      borderRadius: BorderRadius.circular(25),
                                                                    ),
                                                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                                                      children: [
                                                                        CachedNetworkImage(imageUrl: data?.seekerImg ?? "" ,
                                                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                                                          imageBuilder: (context, imageProvider) => Container(
                                                                            height: 60,
                                                                            width: 60,
                                                                            decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                                                                            ),
                                                                          ),),
                                                                        SizedBox(width: Get.width * 0.035,),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 8),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox( width : Get.width * 0.5,
                                                                                    child: Text(data?.industryPreference ?? "", overflow: TextOverflow.ellipsis,
                                                                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),
                                                                                      softWrap: true,),
                                                                                  ),
                                                                                  SizedBox(height: Get.height * 0.005,),
                                                                                  SizedBox( width : Get.width * 0.5,
                                                                                    child: Text(
                                                                                      data?.title ?? "",
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.silverColor),
                                                                                      softWrap: true,),
                                                                                  ),
                                                                                  SizedBox(height: Get.height * 0.005,),
                                                                                  Text(data?.seekerName ?? "",
                                                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                        color: AppColors.silverColor),),
                                                                                  SizedBox(height: Get.height * 0.01,),
                                                                                  SizedBox(width: Get.width * 0.60,
                                                                                    child:HtmlWidget( data?.titleDescription ?? "",textStyle:  Theme
                                                                                        .of(context).textTheme.bodySmall!.copyWith(
                                                                                        color: AppColors.silverColor, letterSpacing: 0.01),),
                                                                                  ),
                                                                                  SizedBox(height: Get.height * 0.15,),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  left: 0,
                                                                  right: 0,
                                                                  child: Container(
                                                                    decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomRight: Radius
                                                                              .circular(25),
                                                                          bottomLeft: Radius.circular(
                                                                              24)),
                                                                      color: Color(0xffE9E9E9),
                                                                    ),
                                                                    height: 70,
                                                                    child: Center(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.only(left: 18.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Image.asset('assets/images/viewicon.png', height: 25,),
                                                                            SizedBox(width: Get.width * 0.015,),
                                                                            Text("${data?.forumViewCount} Views",
                                                                              style: Get.theme.textTheme.bodySmall!
                                                                                  .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                                                            SizedBox(width: Get.width * 0.075,),
                                                                            GestureDetector(
                                                                              onTap : () {
                                                                                Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));} ,
                                                                              child: Row(
                                                                                children: [
                                                                                  Image.asset('assets/images/commenticons.png',height: 20,),
                                                                                  SizedBox(width: Get.width * 0.015,),
                                                                                  Text("${data?.forumCommentCount} Comments",
                                                                                    style: Get.theme.textTheme.bodySmall!
                                                                                        .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                          ),
                                                        );
                                                      }),
                                                  Obx( () => forumDataController.loadingPage.value ? const Center(child: CircularProgressIndicator(),) : SizedBox()) ,
                                                  SizedBox(height: Get.height *.15,)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SeekerMessagePage(type: "tabbar",)
                                      ]),
                                )
                              ],
                            ),
                          ))

                    // DefaultTabController(
                    //   length: 3,
                    //   child: SingleChildScrollView(
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 20.0,),
                    //       child: Column(
                    //         children: [
                    //           const TabBar(
                    //             isScrollable: true,
                    //             labelColor: AppColors.blueThemeColor,
                    //             unselectedLabelColor: Color(0xffCFCFCF),
                    //             indicatorColor: AppColors.blueThemeColor,
                    //             indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                    //             tabs: [
                    //               Tab(child: Text("FORUM"),),
                    //               Tab(child: Text("FRIENDS AND FAMILY"),),
                    //               Tab(child: Text("MESSAGE"),),
                    //             ],
                    //           ),
                    //           // SizedBox(
                    //           //   height: Get.height *.8 ,
                    //           //   child: TabBarView(
                    //           //       children: [
                    //           //         SingleChildScrollView(
                    //           //           controller: scrollController,
                    //           //           child: Column(
                    //           //             children: [
                    //           //               industryController.industryData.value.industryList == null ||
                    //           //                   industryController.industryData.value.industryList?.length == 0 ?
                    //           //               const SizedBox() :
                    //           //               SizedBox(
                    //           //                 height: Get.height * .18,
                    //           //                 child: Row(
                    //           //                   children: [
                    //           //                     GestureDetector(
                    //           //                         onTap: () {
                    //           //                           industryID = null ;
                    //           //                           forumDataController.forumList?.value = forumDataController.forumData.value.forumData ?? [] ;
                    //           //                         },
                    //           //                         child: Column(
                    //           //                           mainAxisAlignment: MainAxisAlignment.center,
                    //           //                           children: [
                    //           //                             Container(
                    //           //                               padding: const EdgeInsets.all(3),
                    //           //                               decoration: BoxDecoration(
                    //           //                                 shape: BoxShape.circle,
                    //           //                                 border: Border.all(color: industryID == null ? AppColors.blueThemeColor : AppColors.white,width: 2)
                    //           //                               ),
                    //           //                               child: Container(
                    //           //                                 height: 60,
                    //           //                                 width: 60,
                    //           //                                 decoration: const BoxDecoration(
                    //           //                                     shape: BoxShape.circle ,
                    //           //                                     image: DecorationImage(
                    //           //                                         image: AssetImage("assets/images/icon_app_icon.png",),fit: BoxFit.cover
                    //           //                                     )
                    //           //                                 ),
                    //           //                               ),
                    //           //                             ),
                    //           //                             SizedBox(height: Get.height * .01,),
                    //           //                             Text("All",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //           //                                 color: industryID == null ? AppColors.blueThemeColor : AppColors.white,fontWeight: FontWeight.w700),),
                    //           //                           ],
                    //           //                         )) ,
                    //           //                     SizedBox(width: Get.width*.01,) ,
                    //           //                     Flexible(
                    //           //                       child: SizedBox(
                    //           //                         width: Get.width *.8,
                    //           //                         child: ListView.builder(shrinkWrap: true,
                    //           //                             scrollDirection: Axis.horizontal,
                    //           //                             itemCount: industryController.industryData.value.industryList?.length,
                    //           //                             itemBuilder: (BuildContext context, int index) {
                    //           //                               var data = industryController.industryData.value.industryList?[index] ;
                    //           //                               return Padding(
                    //           //                                 padding: const EdgeInsets.all(8.0),
                    //           //                                 child: SizedBox( width: Get.width * 0.18,
                    //           //                                   child: GestureDetector(
                    //           //                                     onTap: () {
                    //           //                                       industryID = data?.id.toString() ;
                    //           //                                       // forumDataController.seekerForumListApi(industryID: "$industryID");
                    //           //                                       if(forumDataController.forumData.value.forumData != null) {
                    //           //                                         forumDataController.forumList?.value = forumDataController.forumData.value.forumData
                    //           //                                         !.where((e) {
                    //           //                                           return  e.industryId.toString() == data?.id.toString(); }).toList();
                    //           //                                       }
                    //           //                                     },
                    //           //                                     child: Column(
                    //           //                                       mainAxisAlignment: MainAxisAlignment.center,
                    //           //                                       children: [
                    //           //                                         Stack(
                    //           //                                         children: [
                    //           //                                           Container(
                    //           //                                             padding: const EdgeInsets.all(3),
                    //           //                                             decoration: BoxDecoration(
                    //           //                                               shape: BoxShape.circle,
                    //           //                                               border: Border.all(color: data?.id.toString() == industryID.toString() ?
                    //           //                                               AppColors.blueThemeColor : AppColors.white,width: 2)
                    //           //                                             ),
                    //           //                                             child: CachedNetworkImage(imageUrl: data?.industryImg ?? "" ,
                    //           //                                               placeholder: (context, url) => const Center(
                    //           //                                                 child: CircularProgressIndicator(),),
                    //           //                                               imageBuilder: (context, imageProvider) => Container(
                    //           //                                                 height: 60,
                    //           //                                                 width: 60,
                    //           //                                                 decoration: BoxDecoration(
                    //           //                                                     shape: BoxShape.circle ,
                    //           //                                                     image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                    //           //                                                 ),
                    //           //
                    //           //                                               ),
                    //           //                                             ),
                    //           //                                           ),
                    //           //
                    //           //                                         ],
                    //           //                                         ) ,
                    //           //                                         SizedBox(height: Get.height * .01,),
                    //           //                                         Text(data?.industryPreferences ?? "", overflow: TextOverflow.ellipsis,
                    //           //                                           style: Theme.of(context).textTheme.bodyMedium
                    //           //                                               ?.copyWith(fontWeight: FontWeight.w700 ,
                    //           //                                               color: data?.id.toString() == industryID.toString() ?
                    //           //                                               AppColors.blueThemeColor : AppColors.white),),
                    //           //                                       ],
                    //           //                                     ),
                    //           //                                   ),
                    //           //                                 ),
                    //           //                               );
                    //           //                             }),
                    //           //                       ),
                    //           //                     ),
                    //           //                   ],
                    //           //                 ),
                    //           //
                    //           //               ),
                    //           //               SizedBox(height: Get.height * .01,),
                    //           //               Row(
                    //           //                 children: [
                    //           //                   Expanded(
                    //           //                     child: Container(
                    //           //                       padding: EdgeInsets.symmetric(
                    //           //                           horizontal: Get.width * .05,),
                    //           //                       decoration: BoxDecoration(
                    //           //                         color: const Color(0xff373737),
                    //           //                         borderRadius: BorderRadius.circular(33.0),
                    //           //                       ),
                    //           //                       child: Row(
                    //           //                         children: [
                    //           //                           const Icon(
                    //           //                             Icons.search, color: AppColors.blueThemeColor,
                    //           //                             size: 30,),
                    //           //                           SizedBox(width: Get.width * .03),
                    //           //                           Expanded(
                    //           //                             child: TextFormField(
                    //           //                               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //           //                                   color: const Color(0xffCFCFCF), fontSize: 19),
                    //           //                               onChanged: (query) {
                    //           //                                 forumDataController.filterList(query) ;
                    //           //                               },
                    //           //                               decoration: InputDecoration(
                    //           //                                 hintText: 'Search',
                    //           //                                 hintStyle: Theme
                    //           //                                     .of(context)
                    //           //                                     .textTheme
                    //           //                                     .bodyLarge
                    //           //                                     ?.copyWith(
                    //           //                                     color: Color(0xffCFCFCF)),
                    //           //                                 border: InputBorder.none,
                    //           //                               ),
                    //           //                             ),
                    //           //                           ),
                    //           //                         ],
                    //           //                       ),
                    //           //                     ),
                    //           //                   ),
                    //           //                   SizedBox(
                    //           //                     width: Get.width * 0.015,
                    //           //                   ),
                    //           //                   Container(
                    //           //                       height: Get.height * 0.06,
                    //           //                       child: GestureDetector(
                    //           //                           onTap: () {
                    //           //                             Get.to(() => AddNewForum(list: industryController.industryData.value.industryList ,));
                    //           //                           },
                    //           //                           child: Image.asset('assets/images/icon_add_form.png',
                    //           //                             fit: BoxFit.cover,))),
                    //           //                 ],
                    //           //               ),
                    //           //               SizedBox(
                    //           //                 height: Get.height * .02,
                    //           //               ),
                    //           //               //************* list *((((((((((((((((((((((((((((((((
                    //           //
                    //           //               Column(
                    //           //                 children: [
                    //           //                   forumDataController.forumList == null || forumDataController.forumList?.length == 0 ?
                    //           //                   Column(
                    //           //                     children: [
                    //           //                       SizedBox(height: Get.height*.2,) ,
                    //           //                       const Text("No Data"),
                    //           //                     ],
                    //           //                   ) :
                    //           //                   ListView.builder(
                    //           //                       physics: const NeverScrollableScrollPhysics(),
                    //           //                       shrinkWrap: true,
                    //           //                       itemCount: forumDataController.forumList?.length,
                    //           //                       itemBuilder: (context, index) {
                    //           //                         var data = forumDataController.forumList?[index];
                    //           //                         return Padding(
                    //           //                           padding: EdgeInsets.symmetric(
                    //           //                               vertical: Get.height * .02),
                    //           //                           child: Stack(
                    //           //                               children: [
                    //           //                                 GestureDetector(
                    //           //                                   onTap: () {
                    //           //                                     Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));
                    //           //                                   },
                    //           //                                   child: Container(
                    //           //                                     padding: const EdgeInsets.only(left: 7.0, top: 15),
                    //           //                                     decoration: BoxDecoration(
                    //           //                                       color: const Color(0xff353535),
                    //           //                                       borderRadius: BorderRadius.circular(22),
                    //           //                                     ),
                    //           //                                     child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    //           //                                       mainAxisAlignment: MainAxisAlignment.start,
                    //           //                                       //crossAxisAlignment: CrossAxisAlignment.end,
                    //           //                                       children: [
                    //           //                                         CachedNetworkImage(imageUrl: data?.seekerImg ?? "" ,
                    //           //                                           placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                    //           //                                           imageBuilder: (context, imageProvider) => Container(
                    //           //                                             height: 60,
                    //           //                                             width: 60,
                    //           //                                             decoration: BoxDecoration(
                    //           //                                                 shape: BoxShape.circle,
                    //           //                                                 image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                    //           //                                             ),
                    //           //                                           ),),
                    //           //                                         SizedBox(width: Get.width * 0.035,),
                    //           //                                         Column(
                    //           //                                           children: [
                    //           //                                             Padding(
                    //           //                                               padding: const EdgeInsets.only(top: 8),
                    //           //                                               child: Column(
                    //           //                                                 crossAxisAlignment: CrossAxisAlignment.start,
                    //           //                                                 children: [
                    //           //                                                   SizedBox( width : Get.width * 0.5,
                    //           //                                                     child: Text(data?.industryPreference ?? "", overflow: TextOverflow.ellipsis,
                    //           //                                                       style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.blueThemeColor),
                    //           //                                                       softWrap: true,),
                    //           //                                                   ),
                    //           //                                                   SizedBox(height: Get.height * 0.005,),
                    //           //                                                   SizedBox( width : Get.width * 0.5,
                    //           //                                                     child: Text(
                    //           //                                                       data?.title ?? "",
                    //           //                                                       overflow: TextOverflow.ellipsis,
                    //           //                                                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                    //           //                                                       softWrap: true,),
                    //           //                                                   ),
                    //           //                                                   SizedBox(height: Get.height * 0.005,),
                    //           //                                                   Text(data?.seekerName ?? "",
                    //           //                                                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    //           //                                                         color: AppColors.ratingcommenttextcolor),),
                    //           //                                                   SizedBox(height: Get.height * 0.01,),
                    //           //                                                   SizedBox(width: Get.width * 0.60,
                    //           //                                                     child:HtmlWidget( data?.titleDescription ?? "",textStyle:  Theme
                    //           //                                                         .of(context).textTheme.bodySmall!.copyWith(
                    //           //                                                         color: AppColors.ratingcommenttextcolor, letterSpacing: 0.01),),
                    //           //                                                   ),
                    //           //                                                   SizedBox(height: Get.height * 0.15,),
                    //           //                                                 ],
                    //           //                                               ),
                    //           //                                             ),
                    //           //                                           ],
                    //           //                                         )
                    //           //                                       ],
                    //           //                                     ),
                    //           //                                   ),
                    //           //                                 ),
                    //           //                                 Positioned(
                    //           //                                   bottom: 0,
                    //           //                                   left: 0,
                    //           //                                   right: 0,
                    //           //                                   child: Container(
                    //           //                                     decoration: const BoxDecoration(
                    //           //                                       borderRadius: BorderRadius.only(
                    //           //                                           bottomRight: Radius
                    //           //                                               .circular(25),
                    //           //                                           bottomLeft: Radius.circular(
                    //           //                                               25)),
                    //           //                                       color: Color(0xff3F3F3F),
                    //           //                                     ),
                    //           //                                     height: 70,
                    //           //                                     child: Center(
                    //           //                                       child: Padding(
                    //           //                                         padding: const EdgeInsets.only(left: 18.0),
                    //           //                                         child: Row(
                    //           //                                           children: [
                    //           //                                             Image.asset('assets/images/viewicon.png', scale: 0.7,),
                    //           //                                             SizedBox(width: Get.width * 0.015,),
                    //           //                                             Text("${data?.forumViewCount} Views",
                    //           //                                               style: Get.theme.textTheme.bodySmall!
                    //           //                                                   .copyWith(color: AppColors.white),),
                    //           //                                             SizedBox(width: Get.width * 0.075,),
                    //           //                                             GestureDetector(
                    //           //                                               onTap : () {
                    //           //                                                 Get.to(() => ForumOnlyCommentPage(forumData: data,industryID: industryID,));} ,
                    //           //                                               child: Row(
                    //           //                                                 children: [
                    //           //                                                   Image.asset('assets/images/commenticons.png'),
                    //           //                                                   SizedBox(width: Get.width * 0.015,),
                    //           //                                                   Text("${data?.forumCommentCount} Comments",
                    //           //                                                     style: Get.theme.textTheme.bodySmall!
                    //           //                                                         .copyWith(color: AppColors.white),),
                    //           //                                                 ],
                    //           //                                               ),
                    //           //                                             )
                    //           //                                           ],
                    //           //                                         ),
                    //           //                                       ),
                    //           //                                     ),
                    //           //                                   ),
                    //           //                                 ),
                    //           //                               ]
                    //           //                           ),
                    //           //                         );
                    //           //                       }),
                    //           //                   Obx( () => forumDataController.loadingPage.value ? const Center(child: CircularProgressIndicator(),) : SizedBox()) ,
                    //           //                   SizedBox(height: Get.height *.1,)
                    //           //                 ],
                    //           //               )
                    //           //             ],
                    //           //           ),
                    //           //         ),
                    //           //         const FriendsFamily() ,
                    //           //         const ForumMessagePage() ,
                    //           //       ]),
                    //           // )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                );
            }
          }
          );
      }
    }
    );
  }
}
