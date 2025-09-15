import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/services/base_url.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/utils/image_helper.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';
import 'package:warsha_app/views/products/update_product.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({
    super.key,
    required this.product,
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
                child: Image.network(
                  "${Baseurl.baseURLImages}${ImageHelper.extractFileId(product.image)}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  // Show a loading spinner while the image is loading
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                  // Show a fallback if the image fails to load
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Iconsax.shopping_bag,
                      size: 40,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        DefaultText(
                          txt: product.sku!,
                          bold: true,
                        ),
                        const SizedBox(
                          width: 10
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(
                          width: 10
                        ),
                        DefaultText(
                          txt: product.name,
                          bold: true,
                        ),
                        const SizedBox(
                            width: 10
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          width: 5,
                          height: 5,
                        ),
                        const SizedBox(
                            width: 10
                        ),
                        // Dot indicator for new
                        if (int.parse(product.quantity) < 1)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red.shade300,
                                borderRadius: Constants.BORDER_RADIUS_20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            // margin: const EdgeInsets.only(top: 4, right: 12),
                            child: const DefaultText(
                              txt: 'Out of stock',
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Message
                    Text(product.productDescription),
                    const SizedBox(height: 6),

                    // Time
                    Row(
                      children: [
                        DefaultText(
                          txt: "${product.category}    |  ",
                          size: 14,
                        ),
                        DefaultText(
                          txt: " ${product.quantity} Pieces",
                          size: 14,
                        ),
                        const SizedBox(width: 15),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: Constants.BORDER_RADIUS_20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Row(
                            children: [
                              const DefaultText(
                                  txt: "Buying  ",
                                  size: 14,
                                  color: Colors.white),
                              DefaultText(
                                  txt: "${product.buyingPrice} EGP",
                                  size: 14,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: Constants.BORDER_RADIUS_20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Row(
                            children: [
                              const DefaultText(
                                  txt: "Selling  ",
                                  size: 14,
                                  color: Colors.white),
                              DefaultText(
                                  txt: "${product.sellingPrice} EGP",
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

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct(productModel: product)));
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
                                const SizedBox(width: 5,),
                                DefaultText(txt: "Update Product", color: Theme.of(context).colorScheme.secondary,
                                ),
                              ],
                            )
                        ),
                      ),
                      IconButton(
                        onPressed: !Provider.of<ProductVM>(context).isLoading ? () async {
                          final productVM = Provider.of<ProductVM>(context, listen: false);
                          final state = await productVM.deleteProduct(product.id);
                          if (state == "product_deleted"){
                            productVM.initAllProducts();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Product deleted successfully"),
                              ),
                            );
                          }
                        }: null,
                        icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceTint,
                              borderRadius: Constants.BORDER_RADIUS_50,
                            ),
                            child: !Provider.of<ProductVM>(context).isLoading || (product.id) != Provider.of<ProductVM>(context).deletedProduct ? Row(
                              children: [
                                Icon(
                                  Iconsax.trash,
                                  color: Colors.red.shade300,
                                ),
                                const SizedBox(width: 5,),
                                DefaultText(txt: "Delete Product", color: Colors.red.shade300,
                                ),
                              ],
                            ): Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              child: SpinKitThreeBounce(color: Colors.red.shade300, size: 20),
                            )
                        ),
                      ),
                    ],
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
