import 'package:get/get.dart';
import '../controllers/cashier_controller.dart';

class DashboardController extends GetxController {
  var totalTransactions = 0.obs;
  var totalSales = 0.0.obs;
  var salesData = <double>[].obs;

  final CashierController cashierController = Get.find<CashierController>();

  @override
  void onInit() {
    super.onInit();

    cashierController.history.listen((history) {
      totalTransactions.value = history.length;

      totalSales.value = history.fold(
        0.0,
        (sum, transaction) =>
            sum +
            transaction.fold(0.0, (subSum, product) => subSum + product.price),
      );

      salesData.value = history.map((transaction) {
        return transaction.fold(
          0.0,
          (sum, product) => sum + product.price,
        );
      }).toList();
    });
  }
}