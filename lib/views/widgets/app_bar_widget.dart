import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/default_text.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const DefaultText(
            txt: "Home",
            bold: true,
          )),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(Iconsax.home, color: Theme.of(context).colorScheme.secondary,),
                  const SizedBox(
                      width: 15
                  ),
                  const DefaultText(txt: "Home", bold: true,)
                ],
              ),
              const SizedBox(width: 100),
              Row(
                children: [
                  Icon(
                    Iconsax.category,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 15),
                  const DefaultText(txt: "Products", bold: true,)
                ],
              ),
              SizedBox(width: 100),
              Row(
                children: [
                  Icon(
                    Iconsax.house,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const DefaultText(txt: "Inventory", bold: true,)
                ],
              ),
              const SizedBox(width: 100),
              Row(
                children: [
                  Icon(
                    Iconsax.profile_2user,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 15),
                  const DefaultText(txt: "Customers", bold: true,)
                ],
              ),
              const SizedBox(width: 100),
              Row(
                children: [
                  Icon(
                    Iconsax.document,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 15),
                  const DefaultText(txt: "Invoices", bold: true,)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
