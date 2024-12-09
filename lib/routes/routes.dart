import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/cashier_view.dart';

final List<GetPage> appPages = [
  GetPage(name: '/login', page: () => LoginView()),
  GetPage(name: '/dashboard', page: () => DashboardView()),
  GetPage(name: '/cashier', page: () => CashierView()),
];
