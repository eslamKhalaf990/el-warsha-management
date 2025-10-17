import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/daily_cash.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/home_v_m.dart';
import 'package:warsha_app/utils/price_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeCashFlow extends StatelessWidget {
  const HomeCashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<HomeVM>(
        builder: (context, value, child) {
          final revenue = value.revenueSummary;
          final dailyCashFlow = value.dailyCashFlow;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: revenue == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  txt: "Cash Flow Overview",
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCashCard(
                      context,
                      title: "Actual Cash Received",
                      value: PriceHelper.formatNumber(revenue.actualCashReceived),
                      icon: Iconsax.money_copy,
                      color: Colors.green,
                    ),
                    _buildCashCard(
                      context,
                      title: "Expected Cash",
                      value: PriceHelper.formatNumber(revenue.expectedCash),
                      icon: Iconsax.money_time_copy,
                      color: Colors.orange,
                    ),
                    _buildCashCard(
                      context,
                      title: "Potential Revenue",
                      value: PriceHelper.formatNumber(revenue.potentialRevenue),
                      icon: Iconsax.trend_up_copy,
                      color: Colors.blue,
                    ),
                  ],
                ),
                DailyCashFlowChart(data: dailyCashFlow,)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCashCard(
      BuildContext context, {
        required String title,
        required String value,
        required IconData icon,
        required Color color,
      }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 15),
            DefaultText(
              txt: title,
              color: Colors.black54,
              size: 16,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  txt: value,
                  color: color,
                  size: 20,
                  bold: true,
                ),
                const SizedBox(width: 5),
                DefaultText(
                  txt: "EGP",
                  color: color,
                  size: 20,
                  bold: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DailyCashFlowChart extends StatelessWidget {
  final List<DailyCashFlowModel>? data;

  const DailyCashFlowChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(
        child: Text(
          "No cash flow data available",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        title: const ChartTitle(
          text: 'Daily Cash Flow Overview',
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Day'),
          labelRotation: 45,
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          title: const AxisTitle(text: 'Amount (EGP)'),
          numberFormat: NumberFormat.compactCurrency(symbol: 'EGP ', decimalDigits: 0),
        ),
        series: <CartesianSeries<DailyCashFlowModel, String>>[
          // 🟢 Cash Received
          ColumnSeries<DailyCashFlowModel, String>(
            name: 'Cash Received',
            color: Colors.green,
            dataSource: data,
            xValueMapper: (DailyCashFlowModel d, _) =>
                DateFormat('MM/dd').format(DateTime.parse(d.day)),
            yValueMapper: (DailyCashFlowModel d, _) => d.dailyCashReceived,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          // 🟠 Shipped Value
          ColumnSeries<DailyCashFlowModel, String>(
            name: 'Shipped Value',
            color: Colors.orange,
            dataSource: data,
            xValueMapper: (DailyCashFlowModel d, _) =>
                DateFormat('MM/dd').format(DateTime.parse(d.day)),
            yValueMapper: (DailyCashFlowModel d, _) => d.dailyShippedValue,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          // 🔴 Delivery Charges
          ColumnSeries<DailyCashFlowModel, String>(
            name: 'Delivery Charges',
            color: Colors.red,
            dataSource: data,
            xValueMapper: (DailyCashFlowModel d, _) =>
                DateFormat('MM/dd').format(DateTime.parse(d.day)),
            yValueMapper: (DailyCashFlowModel d, _) => d.dailyDeliveryCharges,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}


