import '../controller/m_pesa_controller.dart';
import 'package:get/get.dart';

class MPesaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MPesaController());
  }
}
