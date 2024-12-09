import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cashier_controller.dart';
import '../widgets/sidebar.dart';
import 'history_view.dart';

class CashierView extends StatelessWidget {
  final CashierController cashierController = Get.find<CashierController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kasir'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: Sidebar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Harga Produk'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  cashierController.addProduct(
                    nameController.text,
                    double.tryParse(priceController.text) ?? 0.0,
                  );
                  nameController.clear();
                  priceController.clear();
                },
                child: Text('Tambah'),
              ),
              SizedBox(height: 16),
              Obx(() {
                return Column(
                  children: [
                    ...cashierController.products.asMap().entries.map((entry) {
                      int index = entry.key;
                      var product = entry.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text('Rp ${product.price.toStringAsFixed(0)}'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  nameController.text = product.name;
                                  priceController.text =
                                      product.price.toString();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Edit Produk'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                labelText: 'Nama Produk'),
                                          ),
                                          TextField(
                                            controller: priceController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: 'Harga Produk'),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            cashierController.editProduct(
                                              index,
                                              nameController.text,
                                              double.tryParse(
                                                      priceController.text) ??
                                                  0.0,
                                            );
                                            nameController.clear();
                                            priceController.clear();
                                            Get.back();
                                          },
                                          child: Text('Save'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  cashierController.removeProduct(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            'Rp ${cashierController.totalPrice.value.toStringAsFixed(0)}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      cashierController.completeTransaction();
                    },
                    child: Text('Selesai'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cashierController.cancelTransaction();
                    },
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => HistoryView());
                  },
                  child: Image.asset(
                    'lib/images/minisui.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
