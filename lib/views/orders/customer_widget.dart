import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class CustomerWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final int index;

  const CustomerWidget({
    super.key,
    required this.name,
    required this.address,
    required this.email,
    required this.phone, 
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: index == 0 ? Theme.of(context).colorScheme.tertiary.withAlpha(30): Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        borderRadius: Constants.BORDER_RADIUS_20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceTint,
                            borderRadius: Constants.BORDER_RADIUS_20,
                          ),
                          child: const Icon(
                            Iconsax.profile_circle,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              txt: name,
                              bold: true,
                            ),
                            const SizedBox(height: 5,),
                            DefaultText(
                              txt: email,
                              bold: true,
                            ),
                          ],
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
                                  txt: "Phone:  ",
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
