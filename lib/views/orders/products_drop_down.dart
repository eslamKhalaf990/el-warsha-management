import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/product_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';

class ProductsDropdown extends StatefulWidget {
  const ProductsDropdown({super.key});

  @override
  State<ProductsDropdown> createState() => _ProductsDropdownState();
}

class _ProductsDropdownState extends State<ProductsDropdown> {
  ProductModel? product;
  List<ProductModel>? products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final data = await Provider.of<ProductVM>(context, listen: false).getAllProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      // handle error if needed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withAlpha(Constants.OPACITY_05),
        ),
        borderRadius: Constants.BORDER_RADIUS_15,
      ),
      child: DropdownMenu<ProductModel>(
        initialSelection: product,
        width: MediaQuery.of(context).size.width * 0.9,
        textStyle: const TextStyle(fontSize: 14),
        selectedTrailingIcon: Icon(
          Iconsax.arrow_circle_up,
          color: Theme.of(context).colorScheme.tertiary.withAlpha(Constants.OPACITY_08),
        ),
        trailingIcon: Icon(
          Iconsax.arrow_circle_down,
          color: Theme.of(context).colorScheme.tertiary.withAlpha(Constants.OPACITY_08),
        ),
        menuStyle: MenuStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: Constants.BORDER_RADIUS_20,
            ),
          ),
          elevation: WidgetStateProperty.all(1),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onSelected: (value) {
          setState(() {
            product = value;
          });
        },
        dropdownMenuEntries: isLoading
            ? [
          DropdownMenuEntry(
            value: ProductModel.get(name: "", id: "", productDescription: "", buyingPrice: "", sellingPrice: "", category: "", quantity: "", image: ""),
            label: 'Loading...',
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              foregroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            trailingIcon: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        ]
            : (products ?? [])
            .map((type) {
          return DropdownMenuEntry(
            value: type,
            label: type.name,
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 14),
              ),
            ),
          );
        })
            .toList(),
      ),
    );
  }
}

