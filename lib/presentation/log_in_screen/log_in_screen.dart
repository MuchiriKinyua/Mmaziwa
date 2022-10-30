import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/core/utils/validation_functions.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mmaziwaapp/widgets/custom_text_form_field.dart';

import 'controller/log_in_controller.dart';

// ignore_for_file: must_be_immutable
class LogInScreen extends GetWidget<LogInController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      width: double.infinity,
                                      decoration: AppDecoration.fillCyan200,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    margin: getMargin(
                                                        left: 67,
                                                        top: 25,
                                                        right: 67),
                                                    child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text: "          "
                                                                  .tr,
                                                              style: TextStyle(
                                                                  color: ColorConstant
                                                                      .black900,
                                                                  fontSize:
                                                                      getFontSize(
                                                                          24),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          TextSpan(
                                                              text:
                                                                  "lbl_mmaziwa_app2"
                                                                      .tr,
                                                              style: TextStyle(
                                                                  color: ColorConstant
                                                                      .black900,
                                                                  fontSize:
                                                                      getFontSize(
                                                                          32),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))
                                                        ]),
                                                        textAlign:
                                                            TextAlign.left))),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                    padding: getPadding(
                                                        left: 27,
                                                        top: 17,
                                                        right: 27,
                                                        bottom: 14),
                                                    child: Text(
                                                        "msg_enter_your_deta"
                                                            .tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtInterSemiBold12)))
                                          ]))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 24, top: 99, right: 24),
                                      child: Text("msg_enter_your_emai".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtInterSemiBold16))),
                              CustomTextFormField(
                                  width: 219,
                                  focusNode: FocusNode(),
                                  controller: controller.emailInputController,
                                  hintText: "lbl_your_email".tr,
                                  margin:
                                      getMargin(left: 24, top: 4, right: 24),
                                  alignment: Alignment.centerLeft,
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidEmail(value,
                                            isRequired: true))) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  }),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 27, top: 6, right: 27),
                                      child: Text("msg_enter_your_pass".tr,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.txtInterSemiBold16))),
                              CustomTextFormField(
                                  width: 219,
                                  focusNode: FocusNode(),
                                  controller:
                                      controller.passwordInputController,
                                  hintText: "lbl_password".tr,
                                  margin:
                                      getMargin(left: 24, top: 10, right: 24),
                                  textInputAction: TextInputAction.done,
                                  alignment: Alignment.centerLeft,
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidPassword(value,
                                            isRequired: true))) {
                                      return "Please enter valid password";
                                    }
                                    return null;
                                  },
                                  isObscureText: true),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      height: getVerticalSize(22.00),
                                      width: getHorizontalSize(250.00),
                                      margin: getMargin(
                                          left: 28, top: 6, right: 28),
                                      child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                    height:
                                                        getVerticalSize(21.00),
                                                    width: getHorizontalSize(
                                                        250.00),
                                                    margin:
                                                        getMargin(bottom: 10),
                                                    decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .gray101))),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                    padding: getPadding(
                                                        left: 2,
                                                        top: 10,
                                                        right: 10),
                                                    child: Text(
                                                        "msg_did_you_forget".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtInterRegular16)))
                                          ]))),
                              CustomButton(
                                  width: 115,
                                  text: "lbl_log_in".tr,
                                  margin: getMargin(
                                      left: 39, top: 48, right: 39, bottom: 20),
                                  variant: ButtonVariant.FillGray500,
                                  onTap: onTapBtnLogin,
                                  alignment: Alignment.centerLeft)
                            ]))))));
  }

  onTapBtnLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: controller.emailInputController.text,
        password: controller.passwordInputController.text,
      )
          .then((userCredential) {
        if (userCredential.user != null) {
          Get.toNamed(AppRoutes.homepageScreen);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
