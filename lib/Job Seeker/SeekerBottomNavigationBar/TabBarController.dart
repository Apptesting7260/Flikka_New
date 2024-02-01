import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  RxBool showBottomBar = true.obs ;
  RxBool showBottomBarRecruiter = true.obs ;
  RxBool showListView = true.obs ;
  RxInt bottomSelectedIndex = 0.obs ;
  Rx<PageController>? pageController = PageController().obs ;

  void bottomTapped(int index) {
    if(index == 0) {
      showListView(true) ;
    }
      bottomSelectedIndex.value = index;
      pageController?.value.animateToPage(index,
          duration: const Duration(microseconds: 1), curve: Curves.ease);
  }

  void pageChanged(int index) {

      bottomSelectedIndex.value = index;

  }
}