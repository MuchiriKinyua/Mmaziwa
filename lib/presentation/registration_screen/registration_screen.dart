import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/core/utils/validation_functions.dart';
import 'package:mmaziwaapp/presentation/registration_screen/models/registration_model.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mmaziwaapp/widgets/custom_text_form_field.dart';

import 'controller/registration_controller.dart';

// ignore_for_file: must_be_immutable
class RegistrationScreen extends GetWidget<RegistrationController> {
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding:
                                        getPadding(left: 20, top: 7, right: 20),
                                    child: CommonImageView(
                                        imagePath: ImageConstant.imgCows1,
                                        height: getVerticalSize(135.00),
                                        width: getHorizontalSize(320.00))),
                                Container(
                                    margin: getMargin(top: 5, right: 60),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "          ".tr,
                                              style: TextStyle(
                                                  color: ColorConstant.black900,
                                                  fontSize: getFontSize(24),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400)),
                                          TextSpan(
                                              text: "lbl_mmaziwa_app2".tr,
                                              style: TextStyle(
                                                  color: ColorConstant.black900,
                                                  fontSize: getFontSize(24),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400))
                                        ]),
                                        textAlign: TextAlign.left)),
                                Container(
                                    width: getHorizontalSize(317.00),
                                    margin: getMargin(
                                        left: 20,
                                        top: 1,
                                        right: 20,
                                        bottom: 10),
                                    child: Text("msg_mmaziwa_is_an_a2".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtInterRegular20))
                              ]))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text("Account Type: "),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: StreamBuilder<RegistrationModel>(
                        stream: controller.registrationModelObj.stream,
                        builder: (context, snapshot) => DropdownButton<String>(
                          value: snapshot.data?.type ?? "farmer",
                          items: ["farmer", "buyer"]
                              .map((accountType) => DropdownMenuItem<String>(
                                    value: accountType,
                                    child: Text(
                                        accountType.capitalize ?? accountType),
                                  ))
                              .toList(),
                          onChanged: controller.setAccountType,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: getPadding(left: 19, top: 7, right: 19),
                          child: Text("msg_enter_your_full".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold16))),
                  CustomTextFormField(
                      width: 219,
                      focusNode: FocusNode(),
                      controller: controller.nameInputController,
                      hintText: "lbl_your_name".tr,
                      margin: getMargin(left: 20, top: 7, right: 20),
                      alignment: Alignment.centerLeft,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid text";
                        }
                        return null;
                      }),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: getPadding(left: 20, top: 7, right: 20),
                          child: Text("msg_enter_your_emai".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold16))),
                  CustomTextFormField(
                      width: 219,
                      focusNode: FocusNode(),
                      controller: controller.emailInputController,
                      hintText: "lbl_your_email".tr,
                      margin: getMargin(left: 20, top: 6, right: 20),
                      alignment: Alignment.centerLeft,
                      validator: (value) {
                        if (value == null ||
                            (!isValidEmail(value, isRequired: true))) {
                          return "Please enter valid email";
                        }
                        return null;
                      }),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: getPadding(left: 20, top: 3, right: 20),
                          child: Text("msg_enter_your_pass".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold16))),
                  CustomTextFormField(
                      width: 219,
                      focusNode: FocusNode(),
                      controller: controller.passwordInputController,
                      hintText: "lbl_password".tr,
                      margin: getMargin(left: 20, top: 3, right: 20),
                      alignment: Alignment.centerLeft,
                      validator: (value) {
                        if (value == null ||
                            (!isValidPassword(value, isRequired: true))) {
                          return "Please enter valid password";
                        }
                        return null;
                      },
                      isObscureText: true),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: getPadding(left: 19, top: 4, right: 19),
                          child: Text("msg_pass".tr,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold12))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: getPadding(left: 19, top: 4, right: 19),
                          child: Text("msg_confirm_passwor".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold16))),
                  CustomTextFormField(
                      width: 219,
                      focusNode: FocusNode(),
                      controller: controller.confirmpasswordInputController,
                      hintText: "lbl_password".tr,
                      margin: getMargin(left: 19, right: 19),
                      textInputAction: TextInputAction.done,
                      alignment: Alignment.centerLeft,
                      validator: (value) {
                        if (value == null ||
                            (!isValidPassword(value, isRequired: true))) {
                          return "Please enter valid password";
                        }
                        return null;
                      },
                      isObscureText: true),
                  CustomButton(
                    width: 164,
                    text: "lbl_register".tr,
                    margin: getMargin(left: 30, top: 18, right: 30),
                    variant: ButtonVariant.FillIndigo300,
                    onTap: onTapBtnRegister,
                    alignment: Alignment.centerLeft,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.logInScreen);
                            },
                            child: Text("Login"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapBtnRegister() async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: controller.emailInputController.text,
      password: controller.passwordInputController.text,
    );
    final user = userCredential.user;
    final userData = {
      "name": controller.nameInputController.text,
      "type": controller.registrationModelObj.value.type,
    };
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(userData);
    }
    Get.toNamed(userData["type"] == "farmer"
        ? AppRoutes.homepageScreen
        : AppRoutes.buyerHomePageScreen);
  }
}
