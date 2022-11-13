import 'package:get/get.dart';

import '../controller/buyer_homepage_controller.dart';

class BuyerHomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuyerHomepageController());
  }
}
