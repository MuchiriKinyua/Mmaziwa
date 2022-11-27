import 'package:get/get.dart';
import 'package:mmaziwaapp/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:mmaziwaapp/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:mmaziwaapp/presentation/buyer_homepage_screen/binding/buyer_homepage_binding.dart';
import 'package:mmaziwaapp/presentation/buyer_homepage_screen/buyer_homepage_screen.dart';
import 'package:mmaziwaapp/presentation/homepage_screen/binding/homepage_binding.dart';
import 'package:mmaziwaapp/presentation/homepage_screen/homepage_screen.dart';
import 'package:mmaziwaapp/presentation/log_in_screen/binding/log_in_binding.dart';
import 'package:mmaziwaapp/presentation/log_in_screen/log_in_screen.dart';
import 'package:mmaziwaapp/presentation/m_pesa_screen/binding/m_pesa_binding.dart';
import 'package:mmaziwaapp/presentation/m_pesa_screen/m_pesa_screen.dart';
import 'package:mmaziwaapp/presentation/records_screen/binding/records_binding.dart';
import 'package:mmaziwaapp/presentation/records_screen/records_screen.dart';
import 'package:mmaziwaapp/presentation/registration_screen/binding/registration_binding.dart';
import 'package:mmaziwaapp/presentation/registration_screen/registration_screen.dart';
import 'package:mmaziwaapp/presentation/splashscreen_screen/binding/splashscreen_binding.dart';
import 'package:mmaziwaapp/presentation/splashscreen_screen/splashscreen_screen.dart';

class AppRoutes {
  static String splashscreenScreen = '/splashscreen_screen';

  static String registrationScreen = '/registration_screen';

  static String logInScreen = '/log_in_screen';

  static String homepageScreen = '/homepage_screen';

  static String mPesaScreen = '/m_pesa_screen';

  static String recordsScreen = '/records_screen';

  static String appNavigationScreen = '/app_navigation_screen';

  static String initialRoute = '/initialRoute';

  static String buyerHomePageScreen = '/buyer_homepage_screen';

  static List<GetPage> pages = [
    GetPage(
      name: splashscreenScreen,
      page: () => SplashscreenScreen(),
      bindings: [
        SplashscreenBinding(),
      ],
    ),
    GetPage(
      name: registrationScreen,
      page: () => RegistrationScreen(),
      bindings: [
        RegistrationBinding(),
      ],
    ),
    GetPage(
      name: logInScreen,
      page: () => LogInScreen(),
      bindings: [
        LogInBinding(),
      ],
    ),
    GetPage(
      name: homepageScreen,
      page: () => HomepageScreen(),
      bindings: [
        HomepageBinding(),
      ],
    ),
    GetPage(
      name: mPesaScreen,
      page: () => MPesaScreen(),
      bindings: [
        MPesaBinding(),
      ],
    ),
    GetPage(
      name: recordsScreen,
      page: () => RecordsScreen(),
      bindings: [
        RecordsBinding(),
      ],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding(),
      ],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashscreenScreen(),
      bindings: [
        SplashscreenBinding(),
      ],
    ),
    GetPage(
      name: buyerHomePageScreen,
      page: () => BuyerHomepageScreen(),
      bindings: [
        BuyerHomepageBinding(),
      ],
    )
  ];
}
