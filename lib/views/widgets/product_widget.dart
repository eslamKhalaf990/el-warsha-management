import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class ProductWidget extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String sku;
  final String category;
  final bool isOutOfStock;

  const ProductWidget({
    super.key,
    required this.title,
    required this.sku,
    required this.description,
    required this.price,
    this.isOutOfStock = false,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
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
                  child: const Icon(Iconsax.shopping_bag, size: 40,),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: sku,
                          bold: true,
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(width: 10,),
                        DefaultText(
                          txt: title,
                          bold: true,
                        ),

                      ],
                    ),
                    const SizedBox(height: 6),
                    // Message
                    Text(
                      description,

                    ),
                    const SizedBox(height: 6),
                    // Time
                    DefaultText(
                      txt: "$category  |  $price",
                      size: 14,
                    ),
                  ],
                ),
              ),
              // Dot indicator for new
              if (isOutOfStock)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}