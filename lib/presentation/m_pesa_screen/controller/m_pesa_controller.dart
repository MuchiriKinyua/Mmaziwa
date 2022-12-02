import 'package:flutter/cupertino.dart';
import 'package:mmaziwaapp/presentation/m_pesa_screen/models/m_pesa_model.dart';

import '/core/app_export.dart';

class MPesaController extends GetxController {
  Rx<MPesaModel> mPesaModelObj = MPesaModel().obs;

  final quantityInputController = TextEditingController();
  final amountInputController = TextEditingController();
  final phoneInputController = TextEditingController();

  bool transactionInProgress = false;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
