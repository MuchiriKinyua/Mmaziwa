import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mmaziwaapp/core/app_export.dart';
import 'package:mmaziwaapp/widgets/custom_button.dart';

import 'controller/homepage_controller.dart';

// ignore: must_be_immutable
class HomepageScreen extends GetWidget<HomepageController> {
  Stream<QuerySnapshot<Map<String, dynamic>>> recordsStream = FirebaseFirestore
      .instance
      .collection("data")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("records")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    left: 20, top: 7, right: 20, bottom: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: getHorizontalSize(82.00),
                                          margin: getMargin(
                                              left: 19,
                                              top: 13,
                                              right: 19,
                                              bottom: 19),
                                          child: Text("lbl_all_records".tr,
                                              maxLines: null,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtInterExtraBold20)))
                                ]))),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(left: 20, top: 29, right: 20, bottom: 20),
                child: Text("lbl_records".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtInterExtraBold20),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: recordsStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Loading",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Text(
                                "Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "Type",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "Output",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "Buyer",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "Amount",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                "Actions",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return TableRow(
                            children: [
                              TableCell(
                                child: Text("${data["name"]}"),
                              ),
                              TableCell(
                                child: Text("${data["type"]}"),
                              ),
                              TableCell(
                                child: Text("${data["output"]}"),
                              ),
                              TableCell(
                                child: Text("${data["buyer"]}"),
                              ),
                              TableCell(
                                child: Text("${data["amount"]}"),
                              ),
                              TableCell(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection("data")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("records")
                                            .doc(document.id)
                                            .delete();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              )),
              CustomButton(
                width: 185,
                text: "lbl_log_out".tr,
                margin: getMargin(left: 20, right: 20, bottom: 20),
                variant: ButtonVariant.FillRed200,
                fontStyle: ButtonFontStyle.InterExtraBold20,
                onTap: onTapBtnLogout,
              )
            ],
          ),
        ),
      ),
    );
  }

  onTapButton() {
    Get.toNamed(AppRoutes.recordsScreen);
  }

  onTapBtnLogout() {
    FirebaseAuth.instance.signOut();
    Get.offAndToNamed(AppRoutes.logInScreen);
  }
}
