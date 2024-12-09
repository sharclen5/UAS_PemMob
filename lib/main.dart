import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_getx/controllers/cashier_controller.dart';
import 'routes/routes.dart';

void main() {
  Get.put(CashierController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: appPages,
    );
  }
}
