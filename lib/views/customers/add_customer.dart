import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_customer.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/utils/navigator.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<CustomerProvider, CustomerVM>(
      builder: (context, value, customerVM, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const DefaultText(txt: "Add New Customer"),
        ),
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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 50, right: 15, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: Constants.BORDER_RADIUS_15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [DefaultText(txt: "Customer Info")],
                            ),
                          ),
                          const SizedBox(height: 20),

                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Name",
                                controller: value.name,
                                icon: Iconsax.profile_circle_copy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Primary Phone",
                                controller: value.phone,
                                icon: Iconsax.call_copy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Secondary Phone",
                                controller: value.secondaryPhone,
                                icon: Iconsax.call_copy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DropdownButtonFormField<String>(
                                value: value.governorate.text.isNotEmpty ? value.governorate.text : null,
                                borderRadius: Constants.BORDER_RADIUS_20,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  labelText: "Governorate",
                                  labelStyle:
                                  const TextStyle(color: Colors.grey, fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: Constants.BORDER_RADIUS_15,
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                                    child: Icon(
                                      Iconsax.building_3_copy,
                                      color: Theme.of(context).colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                                items: [
                                  "القاهرة",
                                  "الجيزة",
                                  "الإسكندرية",
                                  "بورسعيد",
                                  "السويس",
                                  "الدقهلية",
                                  "الشرقية",
                                  "القليوبية",
                                  "كفر الشيخ",
                                  "الغربية",
                                  "المنوفية",
                                  "البحيرة",
                                  "الإسماعيلية",
                                  "المنيا",
                                  "بني سويف",
                                  "الفيوم",
                                  "أسيوط",
                                  "سوهاج",
                                  "قنا",
                                  "الأقصر",
                                  "أسوان",
                                  "البحر الأحمر",
                                  "الوادي الجديد",
                                  "مطروح",
                                  "شمال سيناء",
                                  "جنوب سيناء",
                                  "دمياط",
                                ].map((gov) {
                                  return DropdownMenuItem(
                                    value: gov,
                                    child: Text(gov),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    value.governorate.text = newValue;
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Delivery Address",
                                controller: value.address,
                                icon: Iconsax.location_copy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "City",
                                controller: value.city,
                                icon: Iconsax.buildings_copy,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: DefaultButton(
                                  onTap: () async {
                                    String status = await customerVM.addCustomer(
                                      value.name.text,
                                      value.governorate.text,
                                      value.phone.text,
                                      value.address.text,
                                      value.secondaryPhone.text,
                                      value.city.text,
                                    );
                                    if (status == "customer_added") {

                                      Navigator.pop(navigatorKey.currentContext!);
                                      value.clearCustomer();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Customer added successfully"),
                                        ),
                                      );
                                    }
                                  },
                                  isValid: !Provider.of<CustomerVM>(context)
                                      .isLoading,
                                  isLoading: Provider.of<CustomerVM>(context)
                                      .isLoading,
                                  title: "Add new Customer",
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultCustomerForm extends StatelessWidget {
  const DefaultCustomerForm(
      {super.key,
        required this.title,
        required this.icon,
        required this.controller, this.onChange});
  final String title;
  final TextEditingController controller;
  final Function(String)? onChange;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      cursorColor: Theme.of(context)
          .colorScheme
          .tertiary
          .withAlpha(Constants.OPACITY_05),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceTint,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: icon != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
            : null,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: Constants.BORDER_RADIUS_15),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: Constants.BORDER_RADIUS_15),
        labelText: title,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
