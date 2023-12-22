import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rating_page_seeker.dart';

class CompanyRatting extends StatefulWidget {
  final int rating ;
  const CompanyRatting({super.key, required this.rating});

  @override
  State<CompanyRatting> createState() => _CompanyRattingState();
}

class _CompanyRattingState extends State<CompanyRatting> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*.035,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                        child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,)),
                    SizedBox(width: Get.width*.04,),
                    Text("Companies", style: Get.theme.textTheme.displayLarge),
                  ],
                ),
                SizedBox(height: Get.height*.03,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.007),
                  decoration: BoxDecoration(
                    color: Color(0xff373737),
                    borderRadius: BorderRadius.circular(33.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: AppColors.blueThemeColor,size: 30,),
                      SizedBox(width: Get.width*.03),
                      Expanded(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                          onChanged: (query){
                            // filterPositionNames(query);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search Company',
                            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 10),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.black, // Customize the background color
                //   ),
                //   //padding: EdgeInsets.all(8), // Adjust the padding as needed
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       IconButton(
                //         constraints: BoxConstraints(),
                //         onPressed: () {},
                //         icon: Image.asset('assets/images/addfileoncompany.png'),
                //       ),
                //       SizedBox(width: 8), // Add spacing between the icon and text
                //       Flexible( // Allow the text to wrap if necessary
                //         child: Text(
                //           "Add new company",
                //           style: Get.theme.textTheme.bodySmall!.copyWith(color: Colors.white),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: Get.height*0.01,),

                ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage('assets/images/companylogo.png')
                        ),
                        title: Text("Example Company",style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white)),
                        subtitle:  Text("California, USA",style:Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF))),
                        trailing: RichText(text: TextSpan(children: [
                          TextSpan(text: widget.rating.toString(),style:Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700,color: AppColors.blueThemeColor) ),
                          TextSpan(text: "/10",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700))
                        ]),)
                      ),
                      Divider(
                        height: 40,
                        color: Color(0xff414141),
                        thickness: 1,
                        indent : 15,
                        endIndent : 15,
                      ),
                    ],
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
