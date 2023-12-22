import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
         Get.offAll(TabScreen(index: 0)) ;
        }, icon: Image.asset("assets/images/icon_back_blue.png",)),
        title: Text("Map",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
        toolbarHeight: 90,
      ),
     body: Stack(
       children: [
        Center(child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Image.asset("assets/images/icon_location.png",fit: BoxFit.cover,))),
         Positioned(
            top: 30,
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
             alignment: Alignment.center,
             width: Get.width,
             child: TextFormField(
               style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
               onChanged: (query){
               },
               decoration: InputDecoration(
                 prefixIcon: Icon(Icons.search),
                 filled: true,
                 fillColor: Color(0xff373737),
                 hintText: 'Search',
                 hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(33)
                 ),
               ),
             ),
           ),
         ),
       ],
     ),
    ));
  }
}
