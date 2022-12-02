import 'package:flutter/material.dart';
import 'package:mmaziwaapp/presentation/registration_screen/models/registration_model.dart';

import '/core/app_export.dart';

class RegistrationController extends GetxController {
  TextEditingController nameInputController = TextEditingController();

  TextEditingController emailInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController confirmpasswordInputController =
      TextEditingController();

  Rx<RegistrationModel> registrationModelObj = RegistrationModel().obs;

  void setAccountType(String? type) {
    registrationModelObj
      ..update((val) {
        val?.type = type ?? "farmer";
      });
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameInputController.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    confirmpasswordInputController.dispose();
  }
}
