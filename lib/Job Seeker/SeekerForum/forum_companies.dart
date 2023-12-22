
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forum_only_comment_page.dart';
class ForunCompanies extends StatefulWidget {
  const ForunCompanies({super.key});

  @override
  State<ForunCompanies> createState() => _ForunCompaniesState();
}

class _ForunCompaniesState extends State<ForunCompanies> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: Get.height*.03,),
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
              SizedBox(height: Get.height*.05,),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
                  decoration: BoxDecoration(
                    color: Color(0xff373737),
                    borderRadius: BorderRadius.circular(33.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Color(0xff56B8F6),size: 27,),
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
              ),
              SizedBox(height: Get.height*.05,),
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    leading: Image.asset("assets/images/icon_demo.png"),
                    title: Text("Example Company",style: Theme.of(context).textTheme.labelMedium,),
                    subtitle: Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                    trailing: GestureDetector(
                      onTap: () {
                         Get.to(() =>const ForumOnlyCommentPage());
                      },
                        child: Text("View",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff56B8F6)),)),
                  ),
                );
              },)
            ],
          ),
        ),
      ),
    ));
  }
}
