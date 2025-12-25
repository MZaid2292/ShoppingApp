
import 'package:e_commerce/features/authetication/screens/login_screen/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController{

  static OnBoardingController get instance => Get.find();

  final storage = GetStorage();

  ///Variable
  final pageController = PageController();
  RxInt currentIndex = 0.obs;


  ///Update current index when page scroll
  void updatePageIndicator(index){
    //If I Navigate Our indicator also should changed
    currentIndex.value = index;
  }

  ///Jump to specific dot selected page
  void dotNavigationClick(index){
    currentIndex.value = index;
    pageController.jumpToPage(index);

  }

  ///Update current index and jump to the next page
  void nextPage(){
    if(currentIndex.value == 2){
      storage.write("isFirstTime", false); //means user ka first time nh hai next time
      // jab app open kare to wo login screen par ajae

      Get.offAll(()=>LoginScreen());
      return;
    }
    currentIndex.value++;
    //Or we can write it also like this
    //currentIndex.value = currentIndex.value + 1
    pageController.jumpToPage(currentIndex.value);
  }

  ///Update current index and jump to the last page
  void skipPage(){
    currentIndex.value = 2;
    pageController.jumpToPage(currentIndex.value);
  }
}