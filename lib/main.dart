import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serviceapp/screens/demolist.dart';
import 'package:serviceapp/services/package_listing_services.dart';
import 'package:serviceapp/utils/my_theme.dart';
import 'package:serviceapp/utils/routes.dart';

import 'app.dart';

void main() async{
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: App.appTitle,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: MyTheme.primaryColor1,
        unselectedWidgetColor: Colors.blue,
      ),
      initialRoute: Routes.splash,
      getPages: Routes.routes,
    ),
  );
}