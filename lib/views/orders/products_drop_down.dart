import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/category_model.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/view_models/add_product_v_m.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  CategoryModel? product;
  List<CategoryModel>? category;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final data = await Provider.of<ProductVM>(context, listen: false).getAllCategories();
      setState(() {
        category = data;
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
      child: DropdownMenu<CategoryModel>(
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
            value: CategoryModel(categoryId: category?[0].categoryId ?? 0, name:category?[0].name ?? "-"),
            label: 'Loading...',
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black),
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
            : (category ?? [])
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

