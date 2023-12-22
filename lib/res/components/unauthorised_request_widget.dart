
import 'package:flikka/utils/app_color.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';



class UnauthorisedRequestWidget extends StatefulWidget {
  final VoidCallback onPress ;
  const UnauthorisedRequestWidget({Key? key , required this.onPress}) : super(key: key);

  @override
  State<UnauthorisedRequestWidget> createState() => _UnauthorisedRequestWidget();
}

class _UnauthorisedRequestWidget extends State<UnauthorisedRequestWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [

          Column( mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.2,
                alignment: Alignment.center,
                child: Text("Unauthorised Request",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white ,fontSize: 18 ),),
              ),
              Flexible(child: Center(child: Lottie.asset('assets/images/unauthorised_request.json' ,width: Get.width * .5))),
              SizedBox(height: height * .05 ,),
              Center(
                child: MyButton( width: 160,height: 44,
                    title: 'Retry', onTap1:  widget.onPress),
              ) ,
              // Center(
              //   child: InkWell(
              //     onTap: widget.onPress,
              //     child: Container(
              //       height: 44,
              //       width: 160,
              //       decoration: BoxDecoration(
              //           color: AppColor.primaryColor ,
              //           borderRadius: BorderRadius.circular(50)
              //       ),
              //       child: Center(child: Text('Retry' , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
              //     ),
              //   ),
              // ) ,
              SizedBox(height: height * .05 ,),
            ],
          ),
        ],
      ),
    );
  }
}
