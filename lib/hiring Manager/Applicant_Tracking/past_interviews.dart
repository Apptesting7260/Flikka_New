import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';

class PastInterviews extends StatefulWidget {
  const PastInterviews({super.key});

  @override
  State<PastInterviews> createState() => _PastInterviewsState();
}

class _PastInterviewsState extends State<PastInterviews> {
  final List<String> pastInterviewItems = [
    'Upcoming','Rejected','Selected',
  ];
  String? pastInterviewValues;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height*.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Past Interviews",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF))),
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
                                'Past',
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: pastInterviewItems
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: pastInterviewValues,
                        onChanged: (String? value) {
                          setState(() {
                            pastInterviewValues = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: Get.height*.05,
                          width: Get.width*.26,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Color(0xff686868))
                            // color: Color(0xff353535),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData:  const IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          iconSize: 16,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
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
                  ],
                ),
                SizedBox(height: Get.height*.025,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Get.height*.03),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Color(0xff353535)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                          child: Column(
                            children: [
                              SizedBox(height: Get.height*.013,),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                minVerticalPadding: 12,
                                leading: const CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                                ),
                                title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                                subtitle:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Marketing Intern",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                                    ),
                                    SizedBox(height: Get.height*.003,),
                                    Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height*.025,),
                              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                              SizedBox(height: Get.height*.03,),
                              Row(
                                children: [
                                  Image.asset("assets/images/icon_calendar.png",height: Get.height*.026,color: AppColors.blueThemeColor,),
                                  SizedBox(width: Get.width*.02,),
                                  Text("12, January 2022",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
                                ],
                              ),
                              SizedBox(height: Get.height*.02,),
                              Row(
                                children: [
                                  Image.asset("assets/images/icon_watch.png",height: Get.height*.026,color: AppColors.blueThemeColor,),
                                  SizedBox(width: Get.width*.02,),
                                  Text("11: 30 PM",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                ],
                              ),
                              SizedBox(height: Get.height*.031,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },),
                SizedBox(height: Get.height*.1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
