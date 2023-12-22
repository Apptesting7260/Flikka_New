import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';

class UpcomingInterviewsHiring extends StatefulWidget {
  const UpcomingInterviewsHiring({super.key});

  @override
  State<UpcomingInterviewsHiring> createState() => _UpcomingInterviewsHiringState();
}

class _UpcomingInterviewsHiringState extends State<UpcomingInterviewsHiring> {
  final List<String> jobTypeItems = [
    'Upcoming','Rejected','Selected',
  ];
  String? jobTypeValues;

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
                    Text("Upcoming Interviews",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF))),
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
                                'Upcoming',
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
                  ],
                ),
                SizedBox(height: Get.height*.01,),

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height*.027),
                      child: Container(
                        height: Get.height*.45,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Color(0xff353535)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*.013,),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                minVerticalPadding: 12,
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                                ),
                                title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                                subtitle:  Column(
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
                                  ],
                                ),
                                trailing: Image.asset("assets/images/Edit.png",height: Get.height*.028,),
                              ),
                              SizedBox(height: Get.height*.025,),
                              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                              SizedBox(height: Get.height*.03,),
                              Row(
                                children: [
                                  Image.asset("assets/images/icon_calendar.png",height: Get.height*.026,color: Color(0xff56B8F6),),
                                  SizedBox(width: Get.width*.02,),
                                  Text("12, January 2022",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
                                ],
                              ),
                              SizedBox(height: Get.height*.02,),
                              Row(
                                children: [
                                  Image.asset("assets/images/icon_watch.png",height: Get.height*.026,color: Color(0xff56B8F6),),
                                  SizedBox(width: Get.width*.02,),
                                  Text("11: 30 PM",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                ],
                              ),
                              SizedBox(height: Get.height*.031,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyButton(
                                    height: Get.height*.066,
                                    width: Get.width*.38,
                                    title: "JOIN", onTap1: () {

                                  },),
                                  SizedBox(
                                    height: Get.height*.066,
                                    width: Get.width * 0.38,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                        padding: EdgeInsets.all(0), // Set padding to 0 to allow gradient to cover the entire button
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                          "CANCEL",
                                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.bold)
                                      ),
                                    ),
                                  )
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
