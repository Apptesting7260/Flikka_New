import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class JobAlertWiseJobListing extends StatefulWidget {
  const JobAlertWiseJobListing({super.key});

  @override
  State<JobAlertWiseJobListing> createState() => _JobAlertWiseJobListingState();
}

class _JobAlertWiseJobListingState extends State<JobAlertWiseJobListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark
        ),
        toolbarHeight: 40,
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back() ;
          },
          child: Image.asset(
            "assets/images/icon_back_blue.png",
          ),
        ),
        title: Text("Marketing intern In California",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: Get.height*.03,),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: Get.height*.2,
                      decoration:  BoxDecoration(
                        color: AppColors.homeGrey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            // horizontalTitleGap: 0,
                            leading: Image.asset("assets/images/icon_job_alert_logo.png",height: Get.height*.07,),
                            title: Text("Example Company Pvt. Ltd",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                            subtitle: Row(
                              children: [
                                Text("4.0",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: AppColors.black),),
                                SizedBox(width: 5,),
                                RatingBar(
                                  initialRating: 1.0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 1,
                                  itemSize: 20,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star, color: Colors.amber),
                                    half: const Icon(Icons.star_half, color: Colors.amber),
                                    empty: const Icon(Icons.star_border, color: Colors.amber),
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("marketing intern",style: Theme.of(context).textTheme.titleLarge,),
                                Text("California, USA",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: AppColors.silverColor),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("£60K/yr - £75K/yr",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),),
                                    Text("1d",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500,color: AppColors.black),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },)
          ],
        ),
      ),
    );
  }
}
