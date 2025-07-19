import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_text.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 3),
          width: 160,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: Constants.BORDER_RADIUS_100,
                  child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(width: 10,),
              const DefaultText(
                txt: "Home",
                bold: true,
              ),
            ],
          ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
