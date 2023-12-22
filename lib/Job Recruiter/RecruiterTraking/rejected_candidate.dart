import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class RejectedCandidate extends StatefulWidget {
  const RejectedCandidate({super.key});

  @override
  State<RejectedCandidate> createState() => _RejectedCandidateState();
}

class _RejectedCandidateState extends State<RejectedCandidate> {
  final List<String> jobTypeItems = [
    'Social Marketing','Programming','Health Finance','Content Manager'
  ];
  String? jobTypeValues;

  final List<String> allTypeItems = [
    'Selected','Rejected',
  ];
  String? allTypeValues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height*.04,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
              decoration: BoxDecoration(
                color: Color(0xff373737),
                borderRadius: BorderRadius.circular(33.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColors.blueThemeColor,size: 27,),
                  SizedBox(width: Get.width*.03),
                  Expanded(
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                      onChanged: (query){
                        // filterPositionNames(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Rejected candidate",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF))),
                  ],
                ),
                Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Job Type',
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: jobTypeItems
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: jobTypeValues,
                        onChanged: (String? value) {
                          setState(() {
                            jobTypeValues = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*0.060,
                          width: Get.width*.26,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Color(0xff686868))
                            // color: Color(0xff353535),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData:  IconStyleData(
                          icon: Image.asset('assets/images/arrowdown.png'),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: Get.height*0.35,
                          width: Get.width*0.902,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff353535),
                          ),
                          offset: const Offset(5, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius:  Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width*.02,),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint:  Row(
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Rejected',
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: allTypeItems
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: allTypeValues,
                        onChanged: (String? value) {
                          setState(() {
                            allTypeValues = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*0.060,
                          width: Get.width*.26,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Color(0xff686868))
                            // color: Color(0xff353535),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData:  IconStyleData(
                          icon: Image.asset('assets/images/arrowdown.png'),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: Get.height*0.35,
                          width: Get.width*0.902,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff353535),
                          ),
                          offset: const Offset(5, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius:  Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: Get.height*.035,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: Get.height*.02),
                  child:   Container(
                    height: Get.height*.40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Color(0xff353535),
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height*.013,),
                          // Align(
                          //     alignment: Alignment.topRight,
                          //     child: Padding(
                          //       padding:  EdgeInsets.only(right: Get.width*.05),
                          //       child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                          //     )),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            minVerticalPadding: 15,
                            leading: CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                            ),
                            title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Software engineer ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                                ),
                                SizedBox(height: Get.height*.003,),
                                Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                SizedBox(height: Get.height*.001,),
                                Text("REJECTED",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff42D396)),),

                              ],
                            ),
// trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                          ),
                          SizedBox(height: Get.height*.024,),
                          MyButton(
                            height: Get.height*.066,
                            title: "VIEW PROFILE", onTap1: () {
                          },),
                          SizedBox(height: Get.height*.024,),
                          SizedBox(
                            width:   295,
                            height: Get.height*.066,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff353535),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Color(0xffFFFFFF))),
                              ),
                              child: Text("TALENT POOL",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
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
