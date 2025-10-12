import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/home_v_m.dart';
import 'package:warsha_app/utils/price_helper.dart';

class HomeCashFlow extends StatelessWidget {
  const HomeCashFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<HomeVM>(
        builder: (context, value, child) {
          final revenue = value.revenueSummary;

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
