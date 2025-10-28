import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/filter_orders.dart';

class OrderFilter {
  static void showGovernorateBottomSheet(BuildContext context) {
    final provider = Provider.of<GovernorateProvider>(context, listen: false);
    final List<Map<String, dynamic>> paymentMethods = [
      {'name': 'Vodafone Cash', 'icon': Iconsax.wallet_copy},
      {'name': 'InstaPay', 'icon': Iconsax.money_send_copy},
      {'name': 'Cash', 'icon': Iconsax.money_copy},
    ];

    final List<Map<String, dynamic>> source = [
      {'name': 'Instagram', 'icon': Iconsax.instagram_copy},
      {'name': 'Tiktok', 'icon': Iconsax.music_copy},
      {'name': 'Facebook', 'icon': Iconsax.facebook_copy},
      {'name': 'E-Commerce', 'icon': Iconsax.shopping_cart_copy},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Consumer<GovernorateProvider>(
          builder: (context, govProvider, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Select Governorate",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(paymentMethods.length, (index) {
                        final method = paymentMethods[index];
                        return InkWell(
                          onTap: (){
                            provider.selectPayment(method['name'].toString().toLowerCase());
                            Navigator.pop(context);

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(method['icon'], size: 25, color: Colors.black87),
                                  const SizedBox(width: 8),
                                  Text(method['name']),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(source.length, (index) {
                        final sourcex = source[index];
                        return InkWell(
                          onTap: (){
                            provider.selectPayment(sourcex['name'].toString().toLowerCase());
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(sourcex['icon']),
                                  const SizedBox(width: 8),
                                  Text(sourcex['name']),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: govProvider.governorates.length,
                      itemBuilder: (context, index) {
                        final gov = govProvider.governorates[index];
                        final isSelected = gov == govProvider.selectedGovernorate;

                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(gov),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : null,
                          onTap: () {
                            provider.selectGovernorate(gov);
                            Navigator.pop(context); // close after selection
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}