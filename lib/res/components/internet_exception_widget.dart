
import 'package:flikka/utils/app_color.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';



class InterNetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress ;
  const InterNetExceptionWidget({Key? key , required this.onPress}) : super(key: key);

  @override
  State<InterNetExceptionWidget> createState() => _InterNetExceptionWidgetState();
}

class _InterNetExceptionWidgetState extends State<InterNetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column( mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.2,
                  alignment: Alignment.center,
                  child: Text("No Internet",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white ,fontSize: 18 ),),
                ),
                Center(child: Lottie.asset('assets/images/no_internet.json' , height: Get.height *.4,width: Get.width * .5)),
                SizedBox(height: height * .05 ,),
                Center(
                  child: MyButton( width: 160,height: 44,
                      title: 'Retry', onTap1:  widget.onPress),
                ),
                SizedBox(height: height * .05 ,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
