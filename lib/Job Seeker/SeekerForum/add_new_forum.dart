import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/SeekerForumController/ForumIndustryListController.dart';
import 'package:flikka/controllers/SeekerForumController/SeekerAddForum.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/SeekerForumIndustryListModel/SeekerForumIndustryListModel.dart';
import '../../widgets/app_colors.dart';

class AddNewForum extends StatefulWidget {
 final List<IndustryList>? list ;
  const AddNewForum({Key? key, this.list}) : super(key: key);

  @override
  State<AddNewForum> createState() => _AddNewForumState();
}

class _AddNewForumState extends State<AddNewForum> {

  SeekerForumIndustryController industryController = Get.put(SeekerForumIndustryController()) ;
  TextEditingController titleController = TextEditingController() ;
  TextEditingController descriptionController = TextEditingController() ;
  SeekerAddForumController forumController = Get.put(SeekerAddForumController()) ;


  var formKey = GlobalKey<FormState>() ;
  String? industryValue ;
  String? industryId ;
  
  @override
  void initState() {
   // industryController.industryApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/icon_back_blue.png')),
          ),
          elevation: 0,
          title: Text("Add New Forum", style: Get.theme.textTheme.displayLarge),
        ),
         body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                      child: Column(
                        children: [
                          // SizedBox(height: Get.height * .04,),
                          // Row(
                          //   children: [
                          //     SizedBox(height: Get.height * .13,),
                          //     Align(
                          //         alignment: Alignment.topLeft,
                          //         child: InkWell(
                          //             onTap: () {
                          //               Get.back();
                          //             },
                          //             child: Image.asset("assets/images/icon_back_blue.png",
                          //               height: Get.height * .055,))),
                          //     SizedBox(width: Get.width * .04,),
                          //     Text("Add New Forum", style: Theme
                          //         .of(context).textTheme.headlineSmall
                          //         ?.copyWith(fontWeight: FontWeight.w700),),
                          //   ],
                          // ),
                          SizedBox(height: Get.height * .01,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Text(industryValue ?? 'Select Industry',
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.white, fontSize: 12),
                                overflow: TextOverflow.ellipsis,),
                              items: widget.list?.map((item) =>
                                  DropdownMenuItem(
                                    value: item.id,
                                    child: Text(item.industryPreferences.toString(),
                                      style: Get.theme.textTheme.bodyLarge!
                                          .copyWith(color: AppColors.white,
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,),
                                    onTap: () {
                                        setState(() {
                                          industryValue = item.industryPreferences ;
                                          industryId = item.id.toString() ;
                                        });
                                    },)).toList(),
                              // value: jobTitleValue,
                              onChanged: (value) {},
                              buttonStyleData: ButtonStyleData(
                                height: Get.height * 0.085,
                                width: Get.width ,
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                  color: const Color(0xff454545),
                                ),
                                elevation: 2,
                              ),

                              dropdownStyleData: DropdownStyleData(
                                maxHeight: Get.height * 0.35,
                                width: Get.width*.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xff353535),
                                ),
                                offset: const Offset(5, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<
                                      double>(6),
                                  thumbVisibility: MaterialStateProperty.all<
                                      bool>(true),
                                ),
                              ),

                            ),
                          ),
                          SizedBox(height: Get.height * .025,),
                          Form( key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: titleController,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xff454545),
                                      hintText: "Add tittle",
                                      hintStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Color(0xffCFCFCF),
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(vertical: Get
                                          .height * .03, horizontal: Get.width * .06),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(35),
                                        borderSide: BorderSide(color: Color(0xff454545)),
                                      ),

                                    ) ,
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Please add a title" ;
                                    }
                                  },
                                ),
                                SizedBox(height: Get.height * .025,),
                                TextFormField(
                                  controller: descriptionController,
                                    maxLines: 5,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xff454545),
                                      hintText: "Add description...",
                                      hintStyle: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Color(0xffCFCFCF),
                                          fontWeight: FontWeight.w400),
                                      contentPadding: EdgeInsets.symmetric(vertical: Get
                                          .height * .03, horizontal: Get.width * .07),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0xff454545)),
                                      ),

                                    ) ,
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Please add a description" ;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * .04,),
                          Obx( () => MyButton(
                            loading: forumController.loading.value,
                              width: Get.width * .75,
                              title: "SUBMIT", onTap1: () {
                              if(forumController.loading.value) {}
                              else {
                                if (industryValue == null || industryValue?.length == 0) {
                                  Utils.showMessageDialog(
                                      context, "Please select a industry");
                                } else {
                                  if (formKey.currentState!.validate()) {
                                    var description = CommonFunctions
                                        .changeToHTML(
                                        descriptionController.text);
                                    forumController.seekerAddForum(context,
                                        industryId, titleController.text,
                                        description);
                                  }
                                }
                              }
                            },),
                          )
                        ],
                      ),
                    ),

                )
    );
  }
}
