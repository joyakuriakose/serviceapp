import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/ac_listing/ac_listing_binding.dart';
import '../screens/ac_listing/ac_listing_view.dart';
import '../screens/detail_page/detail_page_bindings.dart';
import '../screens/detail_page/detail_page_view.dart';
import '../screens/feedback/feedback_binding.dart';
import '../screens/feedback/feedback_view.dart';
import '../screens/login/login_bindings.dart';
import '../screens/login/login_view.dart';
import '../screens/notifications/notif_bindings.dart';
import '../screens/notifications/notif_view.dart';
import '../screens/service_request/request_binding.dart';
import '../screens/service_request/request_view.dart';
import '../screens/splash_screen.dart';



class Routes {
  static const splash = '/';
  static const login = '/login';
  static const acListing = '/acListing';
  static const dashBoard = '/dashboard';
  static const detailPage = '/detailPage';
  static const notificationsPage = '/notification';
  static const feedback = '/feedback';
  static const service = '/service';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      binding: LoginViewBindings(),
      name: login,
      page: () =>  LoginView(),
    ),
    GetPage(
      binding: AcListingBindings(),
      name: acListing,
      page: () =>
          AcListingView(),
    ),
    GetPage(
      binding: DetailPageBindings(),
      name: detailPage,
      page: () => DetailView(),

    ),
    GetPage(
      binding: NotificationBindings(),
      name: notificationsPage,
      page: () =>  NotificationView(),
    ),
    GetPage(
      binding: FeedbackBindings(),
      name: feedback,
      page: () =>  FeedbackView(),
    ),
    GetPage(
      binding: RequestBindings(1),
      name: service,
      page: () =>  RequestView(),
    ),
  ];

}