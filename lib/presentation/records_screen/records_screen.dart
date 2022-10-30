import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/core/utils/validation_functions.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mmaziwaapp/widgets/custom_text_form_field.dart';

import 'controller/records_controller.dart';

// ignore_for_file: must_be_immutable
class RecordsScreen extends GetWidget<RecordsController> {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: getHorizontalSize(274.00),
                                  margin:
                                      getMargin(left: 19, top: 32, right: 19),
                                  child: Text("msg_fill_the_spaces".tr,
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterBold16)),
                              Padding(
                                  padding:
                                      getPadding(left: 24, top: 7, right: 24),
                                  child: Text("msg_enter_the_cows".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterBold16Black900)),
                              Container(
                                  height: getVerticalSize(60.00),
                                  width: getHorizontalSize(219.00),
                                  margin:
                                      getMargin(left: 24, top: 8, right: 24),
                                  child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 10, right: 10),
                                                child: Text(
                                                    "msg_enter_the_cows2".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtInterBold16Black900))),
                                        CustomTextFormField(
                                            width: 219,
                                            focusNode: FocusNode(),
                                            controller:
                                                controller.emailInputController,
                                            hintText: "lbl_email".tr,
                                            margin: getMargin(bottom: 10),
                                            alignment: Alignment.topLeft,
                                            validator: (value) {
                                              if (value == null ||
                                                  (!isValidEmail(value,
                                                      isRequired: true))) {
                                                return "Please enter valid email";
                                              }
                                              return null;
                                            })
                                      ])),
                              Container(
                                  height: getVerticalSize(102.00),
                                  width: getHorizontalSize(220.00),
                                  margin:
                                      getMargin(left: 23, top: 1, right: 23),
                                  child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                                padding: getPadding(
                                                    left: 1,
                                                    top: 40,
                                                    right: 9,
                                                    bottom: 40),
                                                child: Text(
                                                    "msg_enter_the_days".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtInterBold16Black900))),
                                        CustomTextFormField(
                                            width: 219,
                                            focusNode: FocusNode(),
                                            controller:
                                                controller.typeInputController,
                                            hintText: "lbl_type".tr,
                                            margin:
                                                getMargin(right: 1, bottom: 10),
                                            alignment: Alignment.topCenter),
                                        CustomTextFormField(
                                            width: 219,
                                            focusNode: FocusNode(),
                                            controller: controller
                                                .outputInputController,
                                            hintText: "lbl_output".tr,
                                            margin: getMargin(left: 1, top: 10),
                                            alignment: Alignment.bottomCenter)
                                      ])),
                              Padding(
                                  padding:
                                      getPadding(left: 24, top: 1, right: 24),
                                  child: Text("msg_enter_today_s_m".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterBold16Black900)),
                              CustomTextFormField(
                                  width: 219,
                                  focusNode: FocusNode(),
                                  controller: controller.buyerInputController,
                                  hintText: "lbl_buyer".tr,
                                  margin: getMargin(left: 25, right: 25)),
                              Padding(
                                  padding:
                                      getPadding(left: 31, top: 5, right: 31),
                                  child: Text("msg_enter_amount_pa".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterBold16Black900)),
                              CustomTextFormField(
                                  width: 219,
                                  focusNode: FocusNode(),
                                  controller: controller.amountInputController,
                                  hintText: "lbl_amount".tr,
                                  margin: getMargin(left: 25, right: 25),
                                  textInputAction: TextInputAction.done),
                              CustomButton(
                                  width: 162,
                                  text: "lbl_save_update".tr,
                                  margin: getMargin(
                                      left: 19, top: 37, right: 19, bottom: 20),
                                  variant: ButtonVariant.FillRed201,
                                  padding: ButtonPadding.PaddingAll10,
                                  fontStyle: ButtonFontStyle.InterBold24,
                                  onTap: onTapBtnSaveupdate,
                                  alignment: Alignment.center)
                            ]))))));
  }

  onTapBtnSaveupdate() async {
    Get.toNamed(AppRoutes.homepageScreen);
    // ignore: unused_local_variable
    final storage = FirebaseStorage.instance;
  }
}
