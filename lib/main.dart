// ignore: unused_import
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmaziwaapp/firebase_options.dart';
import 'package:mmaziwaapp/keys.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);

  MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool initialized = false;
  String initialRoute = AppRoutes.initialRoute;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          initialized = true;
        });
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get()
            .then((value) {
          if (value.exists) {
            final data = value.data() ?? {};
            setState(() {
              initialRoute = data["type"] == "farmer"
                  ? AppRoutes.homepageScreen
                  : AppRoutes.buyerHomePageScreen;
              initialized = true;
            });
          }
        });
      }
    });
  }

  // This widget is the root of your application.
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
              callBackURL: Uri(
                  scheme: "https",
                  host: "us-central1-MY_PROJECT.cloudfunctions.net/addMessage"),
              accountReference: "payment",
              phoneNumber: phone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "demo  ",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
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

  @override
  Widget build(BuildContext context) {
    startTransaction(amount: 10.0, phone: "254713030677");

    return initialized
        ? GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: AppLocalization(),
            locale: Get.deviceLocale, //for setting localization strings
            fallbackLocale: Locale('en', 'US'),
            title: 'mmaziwaapp',
            initialBinding: InitialBindings(),
            initialRoute: initialRoute,
            getPages: AppRoutes.pages,
          )
        : MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
