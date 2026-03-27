import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/shipping_zone.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/shipping_zone_v_m.dart';

class ShippingZoneWidget extends StatelessWidget {
  final ShippingZone zone;

  const ShippingZoneWidget({
    super.key,
    required this.zone,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 700;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isDesktop
                    ? _buildDesktopLayout(context)
                    : _buildMobileLayout(context),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Row(
      children: [
        _buildZoneIcon(context),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                txt: zone.cityName,
                size: 16,
                bold: true,
                center: false,
              ),
              const SizedBox(height: 4),
              DefaultText(
                txt: "Price: ${zone.shippingPrice} EGP",
                size: 14,
                color: Colors.grey,
                center: false,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildEditButton(context),
            _buildDeleteButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        _buildZoneIcon(context),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: DefaultText(txt: zone.cityName, size: 18, bold: true, center: false),
        ),
        Expanded(
          child: DefaultText(
            txt: "${zone.shippingPrice} EGP",
            size: 16,
            bold: true,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Row(
          children: [
            _buildEditButton(context),
            const SizedBox(width: 8),
            _buildDeleteButton(context),
          ],
        )
      ],
    );
  }

  Widget _buildZoneIcon(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Iconsax.truck_fast_copy,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return IconButton(
      onPressed: () => _showUpdateDialog(context),
      icon: Icon(Iconsax.edit, color: Theme.of(context).colorScheme.primary, size: 24),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    final zoneVM = Provider.of<ShippingZoneVM>(context, listen: false);

    return IconButton(
      onPressed: () async {
        final confirm = await _showDeleteDialog(context);
        if (confirm == true && zone.id != null) {
          await zoneVM.deleteShippingZone(zone.id!);
        }
      },
      icon: const Icon(Iconsax.trash, color: Colors.red, size: 24),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final TextEditingController priceController = TextEditingController(text: zone.shippingPrice.toString());
    final zoneVM = Provider.of<ShippingZoneVM>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Price for ${zone.cityName}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Shipping Price",
                prefixIcon: const Icon(Iconsax.money_send_copy),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (priceController.text.isNotEmpty && zone.id != null) {
                Map<String, dynamic> zoneData = {
                  "id": zone.id,
                  "shippingFee": double.tryParse(priceController.text) ?? zone.shippingPrice,
                };
                await zoneVM.updateShippingZone(zone.id!, double.tryParse(priceController.text) ?? zone.shippingPrice);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Shipping Zone"),
        content: Text("Are you sure you want to delete the zone for ${zone.cityName}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
