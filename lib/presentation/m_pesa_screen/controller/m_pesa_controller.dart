import 'package:flutter/cupertino.dart';
import 'package:mmaziwaapp/presentation/m_pesa_screen/models/m_pesa_model.dart';

import '/core/app_export.dart';

class MPesaController extends GetxController {
  Rx<MPesaModel> mPesaModelObj = MPesaModel().obs;

  final amountInputController = TextEditingController();
  final phoneInputController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
