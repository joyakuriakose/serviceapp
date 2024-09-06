

import 'model/expenditure_hist_model.dart';
import 'model/get_amclist_model.dart';
import 'model/nonamc_feedback.dart';
import 'model/notification_model.dart';
import 'model/package_detail_model.dart';
import 'model/package_listing_model.dart';
import 'model/product_list_model.dart';
import 'model/service_history_model.dart';
import 'model/user_model.dart';

abstract class App{
  static const String appTitle = "Service App";
  static const String appVersionName = "1.0.0";
  static String token = '';
  static EmployeeDetails user = EmployeeDetails();
  static AmcDetail users = AmcDetail();
  static AmcList amcuser = AmcList(id: 42); // Initialize with a default id
  static List<AmcDetail> amcdatas = [];
  static List<Customer> custom = [];
  static List<Notificationss> notification = [];
  static List<ProductList> productLists = [];
  static List<NonamcServiceList> nonFeedLists = [];
  static List<ServiceHistory> serviceHistory = [];
  static List<ExpenditureHistory> expenditureHistory = [];


}