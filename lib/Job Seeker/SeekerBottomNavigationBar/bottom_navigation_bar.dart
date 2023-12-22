import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Bottom extends StatefulWidget {
  final int bottomSelectedIndex;
  final Function bottomTapped;

  const Bottom(
      {Key? key, required this.bottomSelectedIndex, required this.bottomTapped})
      : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  List<BottomNavigationBarItem> buildBottomNavBarItems = [
     BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_home.svg",height: Get.height*.035,),
        activeIcon: Image.asset("assets/images/icon_select_home.png",height: Get.height*.035)),


     BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_location.png",height: Get.height*.035) ,
        activeIcon: Image.asset("assets/images/icon_Select_location.png",height: Get.height*.035,) ,
     ),


     BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_search.png",height: Get.height*.045),
        ),

     BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_forum_unselect.png",height: Get.height*.035),
        activeIcon: Image.asset("assets/images/icon_forum_select.png",height: Get.height*.035,)
        ),

     BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_person.svg",height: Get.height*.035),
        activeIcon: Image.asset("assets/images/icon_select_person.png",height: Get.height*.035),
        ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25), // Adjust the radius as needed
        topRight: Radius.circular(24), // Adjust the radius as needed
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: buildBottomNavBarItems,
        selectedItemColor: const Color(0xff56B8F6),
        unselectedItemColor: Color(0xffC4C4C4),
        selectedIconTheme: const IconThemeData(
          color: const Color(0xff56B8F6),
        ),
        unselectedIconTheme: const IconThemeData(
          color: const Color(0xffC4C4C4),
        ),

        elevation: 8,
        backgroundColor: Color(0xff353535),
        currentIndex: widget.bottomSelectedIndex,
        onTap: (index) => widget.bottomTapped(index),
        selectedFontSize: 1,
        unselectedFontSize: 1,
      ),
    );
  }
}
