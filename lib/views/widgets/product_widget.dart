import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class ProductWidget extends StatelessWidget {
  final String title;
  final String description;
  final String bPrice;
  final String sPrice;
  final String sku;
  final String category;
  final String quantity;

  const ProductWidget({
    super.key,
    required this.title,
    required this.sku,
    required this.description,
    required this.bPrice,
    required this.sPrice,
    required this.quantity,
    required this.category,
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

                        const Expanded(child: SizedBox()),

                        // Dot indicator for new
                        if (int.parse(quantity) < 1)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: Constants.BORDER_RADIUS_20
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                            // margin: const EdgeInsets.only(top: 4, right: 12),
                            child: const DefaultText(txt: 'Out of stock',color: Colors.white,),
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
                    Row(
                      children: [
                        DefaultText(
                          txt: "$category    |  ",
                          size: 14,
                        ),

                        DefaultText(
                          txt: " $quantity Pieces",
                          size: 14,
                        ),

                        const SizedBox(width: 15,),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: Constants.BORDER_RADIUS_20
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),

                          child: Row(
                            children: [
                              const DefaultText(
                                txt: "Buying Price  ",
                                size: 14,
                                color: Colors.white
                              ),
                              DefaultText(
                                txt: "$bPrice EGP",
                                size: 14,
                                color: Colors.white
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15,),

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: Constants.BORDER_RADIUS_20
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                          child: Row(
                            children: [
                              const DefaultText(
                                  txt: "Selling Price  ",
                                  size: 14,
                                  color: Colors.white
                              ),
                              DefaultText(
                                  txt: "$sPrice EGP",
                                  size: 14,
                                  color: Colors.white
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Divider(color: Theme.of(context).colorScheme.onSurface.withAlpha(50),thickness: 0.5,)
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