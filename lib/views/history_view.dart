import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cashier_controller.dart';

class HistoryView extends StatelessWidget {
  final CashierController cashierController = Get.find<CashierController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('History')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (cashierController.history.isEmpty) {
              return Center(child: Text('No Transactions Yet'));
            }
            return ListView.builder(
              itemCount: cashierController.history.length,
              itemBuilder: (context, index) {
                final transaction = cashierController.history[index];
                return Dismissible(
                  key: Key(transaction.hashCode.toString()),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text(
                              'Are you sure you want to delete Transaction ${index + 1}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    cashierController.removeTransaction(index);
                    Get.snackbar(
                      'Transaction Deleted',
                      'Transaction ${index + 1} has been removed',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Transaction ${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          ...transaction.map((product) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.name),
                                Text('Rp ${product.price.toStringAsFixed(0)}'),
                              ],
                            );
                          }).toList(),
                          Divider(),
                          Text(
                            'Total: Rp ${transaction.fold<double>(0.0, (sum, product) => sum + product.price).toStringAsFixed(0)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
