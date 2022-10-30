import 'controller/m_pesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';

class MPesaScreen extends GetWidget<MPesaController> {
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
                      CustomButton(
                          width: 305,
                          text: "lbl_m_pesa_services".tr,
                          margin: getMargin(left: 23, top: 23, right: 23),
                          variant: ButtonVariant.FillIndigoA200),
                      GestureDetector(
                          onTap: () {
                            onTapButton();
                          },
                          child: Container(
                              height: getVerticalSize(33.00),
                              width: getHorizontalSize(253.00),
                              margin: getMargin(
                                  left: 23, top: 263, right: 23, bottom: 20),
                              child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                            height: getVerticalSize(31.00),
                                            width: getHorizontalSize(253.00),
                                            margin: getMargin(top: 10),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.red301))),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                            padding: getPadding(
                                                left: 19,
                                                right: 19,
                                                bottom: 10),
                                            child: Text(
                                                "msg_back_to_homepag".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtInterRegular24Black900)))
                                  ])))
                    ])))));
  }

  onTapButton() {
    Get.toNamed(AppRoutes.homepageScreen);
  }
}
