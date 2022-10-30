import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';

import 'controller/homepage_controller.dart';

class HomepageScreen extends GetWidget<HomepageController> {
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
                              height: getVerticalSize(159.00),
                              width: size.width,
                              decoration: AppDecoration.fillCyan200,
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                        padding: getPadding(
                                            left: 20,
                                            top: 7,
                                            right: 20,
                                            bottom: 10),
                                        child: CommonImageView(
                                            imagePath: ImageConstant.imgCows1,
                                            height: getVerticalSize(135.00),
                                            width: getHorizontalSize(320.00))))
                              ]))),
                      Padding(
                          padding: getPadding(left: 20, top: 27, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      onTapButton();
                                    },
                                    child: Container(
                                        decoration: AppDecoration.fillRed300,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                      width: getHorizontalSize(
                                                          82.00),
                                                      margin: getMargin(
                                                          left: 19,
                                                          top: 13,
                                                          right: 19,
                                                          bottom: 19),
                                                      child: Text(
                                                          "lbl_all_records".tr,
                                                          maxLines: null,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: AppStyle
                                                              .txtInterExtraBold20)))
                                            ]))),
                                GestureDetector(
                                    onTap: () {
                                      onTapButton1();
                                    },
                                    child: Container(
                                        margin: getMargin(left: 14),
                                        decoration: AppDecoration.fillGray601,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:
                                                      getHorizontalSize(95.00),
                                                  margin: getMargin(
                                                      left: 29,
                                                      top: 9,
                                                      right: 29,
                                                      bottom: 13),
                                                  child: Text(
                                                      "msg_m_pesa_service".tr,
                                                      maxLines: null,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtInterRegular24Black900))
                                            ])))
                              ])),
                      Padding(
                          padding: getPadding(left: 20, top: 29, right: 20),
                          child: Text("lbl_records".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterExtraBold20)),
                      CustomButton(
                          width: 185,
                          text: "lbl_log_out".tr,
                          margin: getMargin(
                              left: 20, top: 195, right: 20, bottom: 20),
                          variant: ButtonVariant.FillRed200,
                          fontStyle: ButtonFontStyle.InterExtraBold20,
                          onTap: onTapBtnLogout)
                    ])))));
  }

  onTapButton() {
    Get.toNamed(AppRoutes.recordsScreen);
  }

  onTapButton1() {
    Get.toNamed(AppRoutes.mPesaScreen);
  }

  onTapBtnLogout() {
    Get.toNamed(AppRoutes.logInScreen);
  }
}
