import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import 'controller/m_pesa_controller.dart';

///  RESULT: {MerchantRequestID: 11219-83067435-1, CheckoutRequestID: ws_CO_13112022101707170713030677, ResponseCode: 0, ResponseDescription: Success. Request accepted for processing, CustomerMessage: Success. Request accepted for processing}

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
                                controller: controller.quantityInputController,
                                decoration: InputDecoration(
                                  hintText: "Enter Milk Quantity",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a value";
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
                                  pay(context);
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
    Get.toNamed(AppRoutes.buyerHomePageScreen);
  }

  Future<dynamic> startTransaction(BuildContext context,
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

      final merchantRequestId = transactionInitialisation["MerchantRequestID"];
      if (merchantRequestId != null) {
        final customerMesssage = transactionInitialisation["CustomerMessage"];
        if (customerMesssage != null) {
          // show toast message
        }
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          FirebaseFirestore.instance
              .collection("data")
              .doc(currentUser.uid)
              .collection("transactions")
              .add(
            {
              "quantity": controller.quantityInputController.text,
              "amount": amount,
              "phone_no": phone,
              "timestamp": DateTime.now().millisecondsSinceEpoch,
            },
          );
          Get.toNamed(AppRoutes.buyerHomePageScreen);

          // send data to firebase
        } else {
          //user is not logged in
        }
      }

      final errorMessage = transactionInitialisation["errorMessage"];
      if (errorMessage != null) {
        showCupertinoDialog(
            context: context,
            builder: (_) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                ),
              );
            });
      }
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

  void pay(BuildContext context) {
    if (controller.transactionInProgress) {
      return;
    }
    print("pay clicked");
    controller
      ..transactionInProgress = true
      ..update();
    startTransaction(
      context,
      amount: double.parse(controller.amountInputController.text),
      phone: controller.phoneInputController.text,
    ).then((value) => controller
      ..transactionInProgress = false
      ..update());
    //pay
  }
}
