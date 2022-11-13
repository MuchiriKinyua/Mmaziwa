import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';
import 'package:mmaziwaapp/widgets/custom_text_form_field.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import 'controller/records_controller.dart';

// ignore_for_file: must_be_immutable
class RecordsScreen extends GetWidget<RecordsController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: getMargin(top: 32),
                    child: Text("msg_fill_the_spaces".tr,
                        maxLines: null,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16),
                  ),
                  Padding(
                    padding: getPadding(top: 7),
                    child: Text("msg_enter_the_cows".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16Black900),
                  ),
                  CustomTextFormField(
                      focusNode: FocusNode(),
                      controller: controller.nameInputController,
                      hintText: "lbl_name".tr,
                      alignment: Alignment.topLeft,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid name";
                        }
                        return null;
                      }),
                  Padding(
                    padding: getPadding(top: 10),
                    child: Text("msg_enter_the_cows2".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16Black900),
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.typeInputController,
                    hintText: "lbl_type".tr,
                    validator: requiredValidator,
                  ),
                  Padding(
                    padding: getPadding(top: 10),
                    child: Text("msg_enter_the_days".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16Black900),
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.outputInputController,
                    hintText: "lbl_output".tr,
                    validator: requiredValidator,
                  ),
                  Padding(
                      padding: getPadding(top: 10),
                      child: Text("msg_enter_today_s_m".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterBold16Black900)),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.buyerInputController,
                    hintText: "lbl_buyer".tr,
                    validator: requiredValidator,
                  ),
                  Padding(
                    padding: getPadding(top: 10),
                    child: Text("msg_enter_amount_pa".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16Black900),
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.amountInputController,
                    hintText: "lbl_amount".tr,
                    textInputAction: TextInputAction.done,
                    validator: requiredValidator,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: getPadding(top: 10),
                    child: Text("Enter buyer's phone number",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtInterBold16Black900),
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: controller.buyersPhoneNoInputController,
                    hintText: "@phone no",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 12) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  CustomButton(
                      width: double.infinity,
                      text: "Save",
                      margin: getMargin(top: 37, bottom: 20),
                      variant: ButtonVariant.FillRed201,
                      padding: ButtonPadding.PaddingAll10,
                      fontStyle: ButtonFontStyle.InterBold24,
                      onTap: () {
                        onTapBtnSave(context);
                      },
                      alignment: Alignment.center)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> save(BuildContext context) async {
    dynamic transactionInitialisation;
    //Wrap it with a try-catch
    final amount = double.parse(controller.amountInputController.text);
    final phone = controller.buyersPhoneNoInputController.text;
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
          Fluttertoast.showToast(
              msg: customerMesssage, toastLength: Toast.LENGTH_LONG);
        }
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final recordRef = FirebaseFirestore.instance
              .collection("data")
              .doc(currentUser.uid)
              .collection("records")
              .doc();
          recordRef.set({
            "name": controller.nameInputController.text,
            "type": controller.typeInputController.text,
            "output": controller.outputInputController.text,
            "buyer": controller.buyerInputController.text,
            "amount": controller.amountInputController.text,
          });

          FirebaseFirestore.instance
              .collection("data")
              .doc(currentUser.uid)
              .collection("transactions")
              .add(
            {
              "amount": amount,
              "phone_no": phone,
              "record": recordRef.id,
              "timestamp": DateTime.now().millisecondsSinceEpoch,
            },
          );

          controller.nameInputController.clear();
          controller.typeInputController.clear();
          controller.outputInputController.clear();
          controller.buyerInputController.clear();
          controller.amountInputController.clear();
          Get.offAndToNamed(AppRoutes.homepageScreen);
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

  onTapBtnSave(BuildContext context) async {
    if (!_formKey.currentState!.validate() || controller.saving) {
      return;
    }
    controller
      ..saving = true
      ..update();
    save(context).then((value) => controller
      ..saving = false
      ..update());
  }
}
