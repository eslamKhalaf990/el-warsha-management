import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/category_model.dart';
import 'package:warsha_app/view_models/category_v_m.dart';
import 'package:warsha_app/views/categories/category_widget.dart';
import 'package:warsha_app/views/categories/crud_categories.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryVM = Provider.of<CategoryVM>(context);

    return Column(
      children: [
        const CRUDCategory(),
        Expanded(
          child: FutureBuilder<List<CategoryModel>>(
            future: Future.value(categoryVM.allCategories ?? []),
            builder: (context, snapshot) {
              if (categoryVM.isLoading || snapshot.connectionState == ConnectionState.waiting || categoryVM.allCategories == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: SpinKitChasingDots(
                      color: Theme.of(context).colorScheme.primary, // Using primary for consistency
                      size: 30,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (categoryVM.allCategories != null && categoryVM.allCategories!.isNotEmpty) {
                return ListView.builder(
                  itemCount: categoryVM.allCategories!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return CategoryWidget(
                      category: categoryVM.allCategories![index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No categories found!"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
