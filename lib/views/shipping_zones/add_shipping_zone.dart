import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/shipping_zone_v_m.dart';

class AddShippingZone extends StatefulWidget {
  const AddShippingZone({super.key});

  @override
  State<AddShippingZone> createState() => _AddShippingZoneState();
}

class _AddShippingZoneState extends State<AddShippingZone> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoneVM = Provider.of<ShippingZoneVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: const DefaultText(txt: "Add New Shipping Zone", bold: true, size: 20),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Zone Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 25),
              DefaultZoneForm(
                title: "City Name",
                controller: _cityController,
                icon: Iconsax.location_copy,
              ),
              const SizedBox(height: 20),
              DefaultZoneForm(
                title: "Shipping Price",
                controller: _priceController,
                icon: Iconsax.money_send_copy,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: DefaultButton(
                      onTap: () async {
                        if (_cityController.text.isEmpty || _priceController.text.isEmpty) return;
                        
                        Map<String, dynamic> zoneData = {
                          "cityName": _cityController.text,
                          "shippingFee": double.tryParse(_priceController.text) ?? 0.0,
                        };

                        String status = await zoneVM.addShippingZone(zoneData);

                        if (status == "zone_added") {
                          if (mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Shipping zone added successfully")),
                            );
                          }
                        }
                      },
                      isValid: !zoneVM.isLoading,
                      isLoading: zoneVM.isLoading,
                      title: "Save Zone",
                      margin: EdgeInsets.zero,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultZoneForm extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;

  const DefaultZoneForm({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: title,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1.5),
          borderRadius: BorderRadius.circular(25),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(icon, color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}
