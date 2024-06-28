

import 'model/get_amclist_model.dart';
import 'model/notification_model.dart';
import 'model/package_listing_model.dart';
import 'model/user_model.dart';

abstract class App{
  static const String appTitle = "Service App";
  static const String appVersionName = "1.0.0";
  static String token = '';
  static EmployeeDetails user = EmployeeDetails();
  static AmcList amcuser = AmcList(id: 42); // Initialize with a default id
  static List<AmcDetail> amcdatas = [];
  static List<Customer> custom = [];
  static List<Notification> notification = [];

}