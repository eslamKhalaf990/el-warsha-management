import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class OrderWidget extends StatelessWidget {
  final String orderID;
  final String status;
  final String customerName;
  final String email;
  final String phone;
  final String address;
  final String orderDate;

  const OrderWidget({
    super.key,
    required this.address,
    required this.email,
    required this.phone,
    required this.orderID,
    required this.status,
    required this.customerName,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceTint,
                    borderRadius: Constants.BORDER_RADIUS_20,
                  ),
                  child: const Icon(
                    Iconsax.profile_circle,
                    size: 50,
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: orderID,
                          bold: true,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),
                        DefaultText(
                          txt: orderDate,
                          bold: true,
                        ),const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),
                        DefaultText(
                          txt: status,
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: customerName,
                          bold: true,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10),
                        DefaultText(
                          txt: email,
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Message
                    Text(address),
                    const SizedBox(height: 6),
                    // Time
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: Constants.BORDER_RADIUS_20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Row(
                            children: [
                              const DefaultText(
                                  txt: "Phone Number  ",
                                  size: 14,
                                  color: Colors.white),
                              DefaultText(
                                  txt: phone, size: 14, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Divider(
                      color:
                          Theme.of(context).colorScheme.onSurface.withAlpha(50),
                      thickness: 0.5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
