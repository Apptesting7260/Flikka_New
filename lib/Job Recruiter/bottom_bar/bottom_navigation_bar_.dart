import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomEmployer extends StatefulWidget {
  final int bottomSelectedIndex;
  final Function bottomTapped;

  const BottomEmployer(
      {Key? key, required this.bottomSelectedIndex, required this.bottomTapped})
      : super(key: key);

  @override
  _BottomEmployerState createState() => _BottomEmployerState();
}

class _BottomEmployerState extends State<BottomEmployer> {
  List<BottomNavigationBarItem> buildBottomNavBarItems = [
    BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_home.svg",height: 25,),
        activeIcon: Image.asset("assets/images/icon_select_home.png",height: 25)),

    BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset("assets/images/icon_unselect_applicant.svg",height: 25),
        activeIcon: Image.asset("assets/images/icon_select_applicant.png",height: 25)
    ),


    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_Add_job.png",height: 25),
      activeIcon: Image.asset("assets/images/icon_Add_job.png",height: 25),
    ),

    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_msg.png",height: 25),
        activeIcon: Image.asset("assets/images/icon_select_msg.png",height: 25)
    ),

    BottomNavigationBarItem(
      label: "",
      icon: SvgPicture.asset("assets/images/icon_unselect_person.svg",height:25),
      activeIcon: Image.asset("assets/images/icon_select_person.png",height: 25),
    ),
  ];

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
        unselectedItemColor: const Color(0xffC4C4C4),
        selectedIconTheme: const IconThemeData(
          color: Color(0xff56B8F6),
        ),
        unselectedIconTheme: const IconThemeData(
          color: Color(0xffC4C4C4),
        ),

        elevation: 8,
        backgroundColor: const Color(0xff353535),
        currentIndex: widget.bottomSelectedIndex,
        onTap: (index) => widget.bottomTapped(index),
        selectedFontSize: 1,
        unselectedFontSize: 1,
      ),
    );
  }
}
