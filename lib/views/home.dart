import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/navigation.dart';
import 'package:warsha_app/utils/const_values.dart';
import '../utils/default_text.dart';
import '../utils/app_bar_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.yellow.shade200
            ], // Replace with your colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Consumer<Navigation>(
                        builder: ( context, value,child) => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: Constants.BORDER_RADIUS_100,
                                    child: Image.asset("assets/images/logo.jpg", width: 40,),
                                  ),
                                  const SizedBox(width: 10,),
                                  const DefaultText(
                                    txt: "ELWARSHA",
                                    bold: true,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value.updatePage(0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: value.page == 0 ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(50) : null,
                                    borderRadius: Constants.BORDER_RADIUS_20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.home,
                                      color:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 15),
                                    const DefaultText(
                                      txt: "Home",
                                      bold: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value.updatePage(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: value.page == 1 ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(50) : null,
                                    borderRadius: Constants.BORDER_RADIUS_20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.category,
                                      color:
                                          Theme.of(context).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 15),
                                    const DefaultText(
                                      txt: "Products",
                                      bold: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value.updatePage(2);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: value.page == 2 ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(50) : null,
                                    borderRadius: Constants.BORDER_RADIUS_20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.receipt_item,
                                      color:
                                          Theme.of(context).colorScheme.secondary,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const DefaultText(
                                      txt: "Orders",
                                      bold: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                value.updatePage(3);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: value.page == 3 ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withAlpha(50) : null,
                                    borderRadius: Constants.BORDER_RADIUS_20),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.profile_2user,
                                      color:
                                          Theme.of(context).colorScheme.secondary,
                                    ),
                                    const SizedBox(width: 15),
                                    const DefaultText(
                                      txt: "Customers",
                                      bold: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: Constants.BORDER_RADIUS_20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.document_text,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 15),
                                  const DefaultText(
                                    txt: "Invoices",
                                    bold: true,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    Provider.of<Navigation>(context, listen: false).pages[
                      Provider.of<Navigation>(context).page],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
