import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/export_orders.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/deafualt_form_field.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/views/orders/add_order/add_order_beta.dart';

class CRUDOrder extends StatelessWidget {
  const CRUDOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check available width
            if (constraints.maxWidth < 900) {
              // --- MOBILE / TABLET LAYOUT (Vertical Stack) ---
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search Bar takes full width
                  DefaultForm(
                    title: 'Search By Order Id or customer name',
                    controller: Provider.of<AddOrderVM>(context).searchController,
                    onChanged: (v) {},
                    numberOfLines: 1,
                  ),
                  const SizedBox(height: 15),
                  // Buttons wrap to next line if needed
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 10,
                    runSpacing: 10,
                    children: _buildActionButtons(context),
                  ),
                ],
              );
            } else {
              // --- DESKTOP LAYOUT (Horizontal Row) ---
              return Row(
                children: [
                  Expanded(
                    child: DefaultForm(
                      title: 'Search By Order Id or customer name or phone',
                      controller:
                      Provider.of<AddOrderVM>(context).searchController,
                      onChanged: (v) {},
                      numberOfLines: 1,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Spread the buttons in the row
                  ..._buildActionButtons(context),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Helper method to create the list of buttons
  List<Widget> _buildActionButtons(BuildContext context) {
    return [
      _buildCustomButton(
        context,
        label: "Add Order",
        icon: Iconsax.receipt_item,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddOrderBeta(),
            ),
          );
        },
      ),

      _buildCustomButton(
        context,
        label: "Export",
        icon: Iconsax.document_download_copy,
        iconColor: Colors.green,
        onTap: () {
          exportToExcel(Provider.of<OrderVM>(context, listen: false).orders);
        },
      ),
    ];
  }

  Widget _buildCustomButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required VoidCallback onTap,
        Color? iconColor,
      }) {
    // Determine if we are on a small screen for button sizing
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return InkWell(
      onTap: onTap,
      borderRadius: Constants.BORDER_RADIUS_50,
      child: Container(
        // Dynamic padding: smaller on mobile, larger on desktop
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: isSmallScreen ? 20 : 30,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4), // Margin for Row spacing
        decoration: BoxDecoration(
          borderRadius: Constants.BORDER_RADIUS_50,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Hug content
          children: [
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            DefaultText(
              txt: label,
              bold: true,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}