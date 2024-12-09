import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/cashier_controller.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CashierController());
    Get.lazyPut(() => LoginController());

    final LoginController loginController = Get.find<LoginController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 80, 159, 232)),
            child: Image.asset('lib/images/sui.png'),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Get.toNamed('/dashboard');
            },
          ),
          ListTile(
            title: Text('Kasir'),
            onTap: () {
              if (!Get.isRegistered<CashierController>()) {
                Get.lazyPut(() => CashierController());
              }
              Get.toNamed('/cashier');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              loginController.logout();
            },
          ),
        ],
      ),
    );
  }
}
