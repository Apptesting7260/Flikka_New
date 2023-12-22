import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyButton extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final VoidCallback onTap1;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Color? bgColor;
  final bool loading ;


  const MyButton({
    Key? key,
    required this.title,
    required this.onTap1,
    this.loading = false ,
    this.style,
    this.width,
    this.height,
    this.padding,
    this.textColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap1,
      child: Container(
        alignment: Alignment.center,
        width: width ?? 295,
        height: height ?? Get.height*.075,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          // gradient: const LinearGradient(
          //   colors: [
          //     Color(0xFF56B8F6),
          //     Color(0xFF4D6FED),
          //   ],
          //   begin: Alignment.topCenter, // Start from the top center
          //   end: Alignment.bottomCenter, // End at the bottom center
          // ),
          color: bgColor ?? AppColors.blueThemeColor
        ),
        child: Center(
          child: loading == false
              ? Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor ?? const Color(0xffFFFFFF),
            ),
          )
              : LoadingAnimationWidget.fallingDot(
            color: Colors.white,
            size: 38,
          ),
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: onTap1,
    //
    //   child: Container(
    //     alignment: Alignment.center,
    //     width: width ?? 295,
    //     height: height ?? 56,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(60.0),
    //       gradient: LinearGradient(
    //         colors: [
    //           Color(0xFF56B8F6),
    //           Color(0xFF4D6FED),
    //         ],
    //         begin: Alignment.topCenter, // Start from the top center
    //         end: Alignment.bottomCenter, // End at the bottom center
    //       ),
    //     ),
    //     child:
    //     Text(
    //       title,
    //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),
    //     ),
    //   ),
    // );
  }
}


