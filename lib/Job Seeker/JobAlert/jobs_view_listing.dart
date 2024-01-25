import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class JobsViewListing extends StatefulWidget {
  const JobsViewListing({super.key});

  @override
  State<JobsViewListing> createState() => _JobsViewListingState();
}

class _JobsViewListingState extends State<JobsViewListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
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
      body: Column(
        children: [
          Container(
            height: Get.height*.2,
            decoration:  BoxDecoration(
              color: AppColors.homeGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset("assets/images/icon_job_alert_logo.png",height: Get.height*.04,),
                  title: Text("Example Company Pvt. Ltd",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                  subtitle: RatingBar(
                    initialRating: 1.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 3,
                    ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.amber),
                      half: const Icon(Icons.star_half, color: Colors.amber),
                      empty: const Icon(Icons.star_border, color: Colors.amber),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
