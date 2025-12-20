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
    // 1. Remove the outer Expanded if this widget is inside a SingleChildScrollView
    // or keep it if it is inside a Column with fixed height.
    // Assuming Dashboard usage, Flexible/Expanded is usually safer.
    return Expanded(
      child: SingleChildScrollView(
        child: Consumer<HomeVM>(
          builder: (context, value, child) {
            final revenue = value.revenueSummary;
            final topProducts = value.topProducts;

            return FadeInAnimation(
              delay: 100,
              child: Container(
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
                    ? const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator())
                )
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    // 2. Responsive Breakpoint
                    final isMobile = constraints.maxWidth < 800;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          txt: "Cash Flow Overview",
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 18,
                          bold: true,
                        ),
                        const SizedBox(height: 16),

                        // 3. Responsive Cash Cards Layout
                        if (isMobile)
                          Column(
                            children: [
                              _buildCashCard(
                                context,
                                title: "Actual Cash",
                                value: PriceHelper.formatNumber(revenue.actualCashReceived),
                                icon: Iconsax.money_copy,
                                color: Colors.green,
                              ),
                              const SizedBox(height: 8),
                              _buildCashCard(
                                context,
                                title: "Expected Cash",
                                value: PriceHelper.formatNumber(revenue.expectedCash),
                                icon: Iconsax.money_time_copy,
                                color: Colors.orange,
                              ),
                              const SizedBox(height: 8),
                              _buildCashCard(
                                context,
                                title: "Potential",
                                value: PriceHelper.formatNumber(revenue.potentialRevenue),
                                icon: Iconsax.trend_up_copy,
                                color: Colors.blue,
                              ),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildCashCard(
                                  context,
                                  title: "Actual Cash",
                                  value: PriceHelper.formatNumber(revenue.actualCashReceived),
                                  icon: Iconsax.money_copy,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8), // Spacing between items
                              Expanded(
                                child: _buildCashCard(
                                  context,
                                  title: "Expected Cash",
                                  value: PriceHelper.formatNumber(revenue.expectedCash),
                                  icon: Iconsax.money_time_copy,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCashCard(
                                  context,
                                  title: "Potential",
                                  value: PriceHelper.formatNumber(revenue.potentialRevenue),
                                  icon: Iconsax.trend_up_copy,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 24),

                        // Note: Removed Expanded around this list to prevent layout errors
                        // inside scrollable parents. It will take natural height.
                        TopSellingProductsList(products: topProducts),
                        const SizedBox(height: 100),

                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
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
    return Container(
      width: double.infinity, // Ensures full width in Column or Expanded
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 12),
          DefaultText(
            txt: title,
            color: Colors.black54,
            size: 14,
          ),
          const SizedBox(height: 8),
          FittedBox( // Prevents text overflow on small screens
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(
                  txt: value,
                  color: color,
                  size: 18,
                  bold: true,
                ),
                const SizedBox(width: 4),
                DefaultText(
                  txt: "EGP",
                  color: color,
                  size: 14,
                  bold: true,
                ),
              ],
            ),
          ),
        ],
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
              Expanded(
                child: DefaultText(
                  txt: "Top Selling: ${DateHelper.formatDate1(DateTime.now().toString())}",
                  size: 16,
                  bold: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Table Columns Header ---
          // Using Flex to ensure alignment with the rows below
          const Row(
            children: [
              SizedBox(width: 42), // Matches Rank Circle width + spacing
              Expanded(
                flex: 8,
                child: Text("Product", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              Expanded(
                flex: 1,
                child: Center(child: Text("Sold", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              ),
              Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Profit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade100, thickness:1),

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
              separatorBuilder: (c, i) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = products![index];
                // Staggered animation for list items
                return FadeInAnimation(
                    delay: 200 + (index * 100),
                    child: _buildProductRow(context, index + 1, item)
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, int rank, TopProduct product) {
    Color rankColor;
    if (rank == 1) rankColor = const Color(0xFFFFD700);
    else if (rank == 2) rankColor = const Color(0xFFC0C0C0);
    else if (rank == 3) rankColor = const Color(0xFFCD7F32);
    else rankColor = Colors.grey.shade300;

    return Row(
      children: [
        // 1. Rank (Fixed Width)
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
                  fontSize: 12
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // 2. Product Name (Matches Header Flex 4)
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              Text(
                "#${product.productId}",
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),

        // 3. Sold Count (Matches Header Flex 2)
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "${product.totalSold}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),

        // 4. Profit (Matches Header Flex 3)
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${PriceHelper.formatNumber((product.totalProfit.toDouble()))} EGP",
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Simple Animation Utility
class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final int delay;

  const FadeInAnimation({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)), // Slight slide up
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}