import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:serviceapp/utils/my_extensions.dart';

import '../../app.dart';
import '../../model/api_resp.dart';
import '../../model/user_model.dart';
import '../../services/login_services.dart';
import '../../utils/err_m.dart';
import '../../utils/local_store.dart';
import '../../utils/routes.dart';

class LoginViewController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  final FocusNode userCtrlfocusNode = FocusNode();
  final FocusNode pswdCtrlfocusNode = FocusNode();
  RxBool isLoggingProgress = false.obs;

  Future<void> doLogin() async {
    LocalStore.clearData();
    isLoggingProgress.value = true;
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (!username.isValidEmail()) {
      userCtrlfocusNode.requestFocus();
      showMsg('Please provide a valid User Name', 'Invalid');
      isLoggingProgress.value = false;
    } else if (!password.isValidPassword()['isValid']) {
      pswdCtrlfocusNode.requestFocus();
      showMsg('Please provide a valid Password', 'Invalid');
      isLoggingProgress.value = false;
    } else {
      final ApiResp resp = await LoginServices.fetchUser(username, password);
      if (resp.ok == false) {
        Get.snackbar(
          "Incorrect credentials",
          "Please check your username and password",
          backgroundColor: Colors.red,
        );
        isLoggingProgress.value = false;
        return;
      }

      User user = User.fromJson(resp.rdata);
      LocalStore.setData('user_id', user.employeeDetails!.id);
      LocalStore.setData('token', user.employeeDetails!.apiToken);
      LocalStore.setData('name', user.employeeDetails!.name);
      LocalStore.setData('phone', user.employeeDetails!.phone);
      LocalStore.setData('email', user.employeeDetails!.email);
      isLoggingProgress.value = false;
      App.user = user.employeeDetails!;
      App.token = user.employeeDetails!.apiToken!;

      if (user.employeeDetails?.apiToken?.isEmpty == true ||
          user.employeeDetails?.name?.isEmpty == true) {
        Get.snackbar("Failed", "Login failed", backgroundColor: Colors.red);
        isLoggingProgress.value = false;
        return;
      } else {
        App.token = user.employeeDetails!.apiToken!;
        Get.offAllNamed(Routes.acListing);
      }
    }
  }
  //     isLoggingProgress.value = false;
  //     App.user = user.employeeDetails!;
  //     App.token = user.employeeDetails!.apiToken!;
  //
  //     if (user.employeeDetails?.apiToken?.isEmpty == true || user.employeeDetails?.name?.isEmpty == true) {
  //       Get.snackbar("Failed", "Login failed", backgroundColor: Colors.red);
  //       isLoggingProgress.value = false;
  //       return;
  //     } else {
  //       Get.offAllNamed(Routes.acListing);
  //     }
  //   }
  // }
}
