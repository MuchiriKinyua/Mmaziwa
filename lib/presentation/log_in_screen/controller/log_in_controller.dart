import 'package:flutter/material.dart';
import 'package:mmaziwaapp/presentation/log_in_screen/models/log_in_model.dart';

import '/core/app_export.dart';

class LogInController extends GetxController {
  TextEditingController emailInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  Rx<LogInModel> logInModelObj = LogInModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailInputController.dispose();
    passwordInputController.dispose();
  }
}
