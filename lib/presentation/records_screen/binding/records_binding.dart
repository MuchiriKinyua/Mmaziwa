import '../controller/records_controller.dart';
import 'package:get/get.dart';

class RecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecordsController());
  }
}
