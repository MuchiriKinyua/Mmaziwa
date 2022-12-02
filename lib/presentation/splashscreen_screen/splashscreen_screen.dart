import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';

import 'controller/splashscreen_controller.dart';

class SplashscreenScreen extends GetWidget<SplashscreenController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: double.infinity,
                              decoration: AppDecoration.fillCyan200,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(
                                            left: 20, top: 7, right: 20),
                                        child: CommonImageView(
                                            imagePath: ImageConstant.imgCows1,
                                            height: getVerticalSize(135.00),
                                            width: getHorizontalSize(320.00))),
                                    Container(
                                        margin: getMargin(
                                            left: 20, top: 43, right: 75),
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "          ".tr,
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .black900,
                                                      fontSize: getFontSize(24),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              TextSpan(
                                                  text: "lbl_mmaziwa_app2".tr,
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .black900,
                                                      fontSize: getFontSize(32),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ]),
                                            textAlign: TextAlign.left)),
                                    Container(
                                        width: getHorizontalSize(317.00),
                                        margin: getMargin(
                                            left: 20,
                                            top: 16,
                                            right: 20,
                                            bottom: 23),
                                        child: Text("msg_mmaziwa_is_an_a".tr,
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtInterRegular20))
                                  ]))),
                      CustomButton(
                          width: 213,
                          text: "lbl_get_started".tr,
                          margin: getMargin(
                              left: 79, top: 30, right: 68, bottom: 20),
                          padding: ButtonPadding.PaddingAll10,
                          fontStyle: ButtonFontStyle.InterRegular24,
                          onTap: onTapBtnGetstarted)
                    ])))));
  }

  onTapBtnGetstarted() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.offAndToNamed(AppRoutes.registrationScreen);
      return;
    }

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        final data = value.data() ?? {};
        Get.offAndToNamed(data["type"] == "farmer"
            ? AppRoutes.homepageScreen
            : AppRoutes.buyerHomePageScreen);
      }
    });
  }
}
