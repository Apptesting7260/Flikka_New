
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'companies_ratting.dart';

class RattingPage extends StatefulWidget {
  const RattingPage({Key? key}) : super(key: key);

  @override
  State<RattingPage> createState() => _RattingPageState();
}

class _RattingPageState extends State<RattingPage> {


  void increment() {
    setState(() {
      if (value < 10) {
        value++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (value > 0) {
        value--;
      }
    });
  }
  var value = 1 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width*.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*.04,),
              Row(
                children: [
                  SizedBox(height: Get.height*.13,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,))),
                  SizedBox(width: Get.width*.04,),
                  Text("Rating",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: Get.height*.15),
                height: Get.height*.88,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xff353535),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height*.03,),
                    Image.asset("assets/images/companylogo.png",),
                    SizedBox(height: Get.height*.03,),
                    Text("Example Company",style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(height: Get.height*.01,),
                    Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                    SizedBox(height: Get.height*.05,),
                    Text("Rating And Review",style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(height: Get.height*.01,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.7,
                          child: Text("Lorem Ipsum is simply dummy text of the printing.",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)),
                    ),
                    SizedBox(height: Get.height*.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove,color: AppColors.blueThemeColor,),
                          onPressed: decrement,
                        ),
                        SizedBox(width: Get.width*.01),
                        Row(
                          children: [
                            Text(
                              value.toString(),
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.blueThemeColor),
                            ),
                            Text(
                             '/10',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        SizedBox(width: Get.width*.01),
                        IconButton(
                          icon: Icon(Icons.add,color: AppColors.blueThemeColor,),
                          onPressed: increment,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                      child: TextFormField(
                          maxLines: 4,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xff454545),
                            hintText: "Additional comments...",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(vertical: Get.height*.03,horizontal: Get.width*.07),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                               ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:BorderSide(
                                    color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                               borderSide: BorderSide(color: Color(0xff454545)),
                            ),

                          )
                      ),
                    ),
                    SizedBox(height: Get.height*.06,),
                    MyButton(title: "SUBMIT REVIEW", onTap1: () {
                      Get.to(() =>  CompanyRatting(rating: value,));
                    },),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
