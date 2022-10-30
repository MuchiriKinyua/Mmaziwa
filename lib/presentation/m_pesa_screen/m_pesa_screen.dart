import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import 'controller/m_pesa_controller.dart';

class MPesaScreen extends GetWidget<MPesaController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneInputController,
                                decoration: InputDecoration(
                                  hintText: "Enter Phone No",
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 12) {
                                    return "Please enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.amountInputController,
                                decoration: InputDecoration(
                                  hintText: "Enter Amount",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter an amount";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  pay();
                                }
                              },
                              child: Text("Pay"),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            onTapButton();
                          },
                          child: Container(
                              height: getVerticalSize(33.00),
                              width: getHorizontalSize(253.00),
                              margin: getMargin(
                                  left: 23, top: 40, right: 23, bottom: 20),
                              child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                            height: getVerticalSize(31.00),
                                            width: getHorizontalSize(253.00),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.red301))),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                            padding: getPadding(
                                              left: 19,
                                              right: 19,
                                            ),
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

  Future<dynamic> startTransaction(
      {required double amount, required String phone}) async {
    // ignore: unused_local_variable
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode:
                  "174379", //use your store number if the transaction type is CustomerBuyGoodsOnline
              transactionType: TransactionType
                  .CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
              amount: amount,
              partyA: phone,
              partyB: "174379",
              callBackURL: Uri.parse(
                  "https://us-central1-mmaziwa-686b2.cloudfunctions.net/mpesaCallback"),
              accountReference: "mmaziwa",
              phoneNumber: phone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "demo  ",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      print("mpesa error");
      print(e);
      //you can implement your exception handling here.
      //Network un-reachability is a sure exception.

      /*
    Other 'throws':
    1. Amount being less than 1.0
    2. Consumer Secret/Key not set
    3. Phone number is less than 9 characters
    4. Phone number not in international format(should start with 254 for KE)
     */

    }
  }

  void pay() {
    print("pay clicked");
    startTransaction(
      amount: double.parse(controller.amountInputController.text),
      phone: controller.phoneInputController.text,
    );
    //pay
  }
}
