import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/sidebar.dart';
import 'history_view.dart';

class DashboardView extends StatelessWidget {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => HistoryView());
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() => Text(
                              'Total Transaksi: ${dashboardController.totalTransactions.value}',
                              style: TextStyle(fontSize: 16),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Grafik Penjualan',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Obx(() {
                  return SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        barGroups: dashboardController.salesData
                            .asMap()
                            .entries
                            .map(
                              (entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    toY: entry.value,
                                    color: Colors.primaries[
                                        entry.key % Colors.primaries.length],
                                    width: 20,
                                    borderRadius: BorderRadius.zero,
                                  )
                                ],
                              ),
                            )
                            .toList(),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                if (value %
                                        calculateDynamicInterval(
                                            dashboardController.salesData) ==
                                    0) {
                                  return Text(
                                    '${value.toInt()}',
                                    style: TextStyle(fontSize: 12),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index >= 0 &&
                                    index <
                                        dashboardController.salesData.length) {
                                  return Text(
                                    'Transaksi ${index + 1}',
                                    style: TextStyle(fontSize: 12),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                              reservedSize: 30,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: calculateDynamicInterval(
                              dashboardController.salesData),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        maxY: calculateMaxY(dashboardController.salesData),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(() => Text(
                          'Total Penjualan: Rp ${dashboardController.totalSales.value.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateMaxY(List<double> salesData) {
    if (salesData.isEmpty) return 1;
    double maxValue = salesData.reduce((a, b) => a > b ? a : b);
    return (maxValue * 1.2).ceilToDouble();
  }

  double calculateDynamicInterval(List<double> salesData) {
    if (salesData.isEmpty) return 1;
    double maxValue = calculateMaxY(salesData);
    return (maxValue / 5).ceilToDouble();
  }
}
