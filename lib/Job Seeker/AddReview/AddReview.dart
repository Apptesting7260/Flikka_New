import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/SeekerPostReviewController/SeekerPostReviewController.dart';

class AddReview extends StatefulWidget {
  final String? recruiterID ;
  const AddReview({super.key, this.recruiterID});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController controller = TextEditingController() ;
  SeekerPostReviewController reviewController = Get.put(SeekerPostReviewController()) ;
  double ratingValue = 0 ;
  final formKey = GlobalKey<FormState>();

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
        title: Text("Add Review", style: Get.theme.textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: Get.width * .04, vertical: Get.height * .02),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.textFieldHeading(context, "How was your experience?") ,
            SizedBox(height: Get.height *0.01,) ,
            Form( key: formKey,
                child: CommonWidgets.textFieldMaxLines(context, controller, "Describe your experience", onFieldSubmitted: (value) {})),
            SizedBox(height: Get.height *0.02,) ,
            const Text("What are your ratings?") ,
            SizedBox(height: Get.height *0.01,) ,
            RatingBar.builder(
              initialRating: ratingValue,
              minRating: 0,
              direction: Axis.horizontal,
              tapOnlyMode: true,
              glow: false,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,),
              onRatingUpdate: (rating) {
                setState(() {
                  ratingValue = rating ;
                });
                if (kDebugMode) {
                  print(rating);
                }
              },
            ),
            SizedBox(height: Get.height *0.05,) ,
            Center(child:
            Obx( () =>
                MyButton(title: "SUBMIT REVIEW",
                    loading: reviewController.loading.value,
                    onTap1: (){
                  if(reviewController.loading.value){}else {
                    if (ratingValue == 0) {
                      Utils.showMessageDialog(context, "Please add rating to submit your review");
                    } else {
                      if (formKey.currentState!.validate()) {
                        var review = CommonFunctions.changeToHTML(
                            controller.text);
                        reviewController.postReview(widget.recruiterID, review,
                            ratingValue.toString());
                      }
                    }
                  }
                    })),)
          ],
        ),
      ),
    );
  }
}
