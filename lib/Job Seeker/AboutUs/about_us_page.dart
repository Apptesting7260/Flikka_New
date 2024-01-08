import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({super.key});

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
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
        title: Text(
          "About Us",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),

      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
