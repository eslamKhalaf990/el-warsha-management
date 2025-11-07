import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/views/customers/update_customer.dart';

import '../../models/customerModel.dart' show CustomerModel;

class CustomerWidget extends StatelessWidget {
  final CustomerModel customerModel;

  const CustomerWidget({
    super.key,
    required this.customerModel,
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
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: customerModel.fullName,
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
                          txt: customerModel.governorate,
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Message
                    Text(customerModel.address),
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
                                  txt: customerModel.phone,
                                  size: 14,
                                  color: Colors.white),
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateCustomer(customerModel: customerModel),
                        ),
                      );
                    },
                    icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: Constants.BORDER_RADIUS_50,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.edit,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            DefaultText(
                              txt: "Update Customer",
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        )),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: Constants.BORDER_RADIUS_50,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.trash,
                              color: Colors.red.shade300,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            DefaultText(
                              txt: "Delete Customer",
                              color: Colors.red.shade300,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
