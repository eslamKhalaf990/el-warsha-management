import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/top_products.dart';
import 'package:warsha_app/utils/date.dart';
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
          final topProducts = value.topProducts;

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
                            value: PriceHelper.formatNumber(
                                revenue.actualCashReceived),
                            icon: Iconsax.money_copy,
                            color: Colors.green,
                          ),
                          _buildCashCard(
                            context,
                            title: "Expected Cash",
                            value:
                                PriceHelper.formatNumber(revenue.expectedCash),
                            icon: Iconsax.money_time_copy,
                            color: Colors.orange,
                          ),
                          _buildCashCard(
                            context,
                            title: "Potential Revenue",
                            value: PriceHelper.formatNumber(
                                revenue.potentialRevenue),
                            icon: Iconsax.trend_up_copy,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                          child: TopSellingProductsList(
                        products: topProducts,
                      ))
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

class TopSellingProductsList extends StatelessWidget {
  final List<TopProduct>? products;

  const TopSellingProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header ---
          Row(
            children: [
              Icon(Iconsax.award_copy,
                  color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(width: 8),
              DefaultText(
                txt:
                    "Top Selling Products in ${DateHelper.formatDate1(DateTime.now().toString())}",
                size: 18,
                bold: true,
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Row(
            children: [
              // Empty space for Rank
              SizedBox(width: 15),

              // Product Name
              Expanded(
                flex: 4, // Gives more space to the name
                child: Text("Product",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
              ),

              // Sold
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Sold",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              // Profit
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Profit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
              ),
              // Stock
              // Text("Stock", textAlign: TextAlign.center),
            ],
          ),

          const SizedBox(height: 16),

          // --- List ---
          if (products == null || products!.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("No sales data yet"),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products!.length,
              separatorBuilder: (c, i) => Divider(
                height: 20,
                thickness: 0.5,
                color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
              ),
              itemBuilder: (context, index) {
                final item = products![index];
                return _buildProductRow(context, index + 1, item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, int rank, TopProduct product) {
    // Determine Medal/Rank Color
    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700); // Gold
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0); // Silver
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32); // Bronze
    } else {
      rankColor = Colors.grey.shade300;
    }

    return Row(
      children: [
        // Rank Circle
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: rankColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: rankColor, width: 1.5),
          ),
          child: Center(
            child: Text(
              "$rank",
              style: TextStyle(
                color: rank <= 3 ? Colors.black87 : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Product Name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "ID: #${product.productId}",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),

        // Total Sold Count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultText(
            txt: "${product.totalSold} Sold",
            color: Theme.of(context).colorScheme.tertiary,
            size: 14,
            bold: true,
          ),
        ),

        // Total Sold Count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultText(
            txt: "${product.totalProfit} EGP",
            color: Colors.green.shade300,
            size: 14,
            bold: true,
          ),
        ),
      ],
    );
  }
}
