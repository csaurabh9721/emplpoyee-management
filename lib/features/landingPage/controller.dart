import 'package:get/get.dart';

final class LandingPageController  extends GetxController{
  RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}