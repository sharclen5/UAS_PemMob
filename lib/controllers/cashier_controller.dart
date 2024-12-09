import 'package:get/get.dart';
import 'package:uas_getx/models/product_model.dart';

class CashierController extends GetxController {
  var products = <Product>[].obs;
  var totalPrice = 0.0.obs;
  var history = <List<Product>>[].obs;
  var transactions = <double>[].obs;

  void addProduct(String name, double price) {
    if (name.isNotEmpty && price > 0) {
      products.add(Product(name: name, price: price));
      totalPrice.value += price;
    }
  }

  void editProduct(int index, String newName, double newPrice) {
    if (newName.isNotEmpty && newPrice > 0) {
      var product = products[index];
      totalPrice.value -= product.price;
      products[index] = Product(name: newName, price: newPrice);
      totalPrice.value += newPrice;
    }
  }

  void removeProduct(int index) {
    var product = products[index];
    totalPrice.value -= product.price;
    products.removeAt(index);
  }

  void completeTransaction() {
    if (products.isNotEmpty) {
      history.add(List.from(products));
      products.clear();
      totalPrice.value = 0.0;
      Get.snackbar('Transaction Completed', 'Data added to history',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'No products to complete the transaction',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeTransaction(int index) {
  history.removeAt(index);
}

  void cancelTransaction() {
    products.clear();
    totalPrice.value = 0.0;
    Get.snackbar('Transaction Canceled', 'All products have been removed',
        snackPosition: SnackPosition.BOTTOM);
  }
}
