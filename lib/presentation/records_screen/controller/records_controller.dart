import 'package:flutter/material.dart';
import 'package:mmaziwaapp/presentation/records_screen/models/records_model.dart';

import '/core/app_export.dart';

class RecordsController extends GetxController {
  TextEditingController emailInputController = TextEditingController();

  TextEditingController typeInputController = TextEditingController();

  TextEditingController outputInputController = TextEditingController();

  TextEditingController buyerInputController = TextEditingController();

  TextEditingController amountInputController = TextEditingController();

  Rx<RecordsModel> recordsModelObj = RecordsModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailInputController.dispose();
    typeInputController.dispose();
    outputInputController.dispose();
    buyerInputController.dispose();
    amountInputController.dispose();
  }
}
