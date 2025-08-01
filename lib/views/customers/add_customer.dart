import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_customer.dart';
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const DefaultText(txt: "Add New Customer")),
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
                                title: "Customer name",
                                controller: value.name,
                                icon: Iconsax.bag,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Customer Email",
                                controller: value.email,
                                icon: Iconsax.document,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Customer Phone",
                                controller: value.phone,
                                icon: Iconsax.category,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                              child: DefaultCustomerForm(
                                title: "Customer Delivery Address",
                                controller: value.address,
                                icon: Iconsax.add,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Consumer<CustomerVM>(
                                builder: (context, customerVM, child) => Expanded(
                                  flex: 3,
                                  child: DefaultButton(
                                    onTap: () async {
                                      String status = await customerVM.addCustomer(
                                        value.name.text,
                                        value.email.text,
                                        value.phone.text,
                                        value.address.text,
                                      );
                                      if (status == "customer_added") {
                                        Navigator.pop(context);
                                        customerVM.initAllCustomers();
                                        customerVM.getAllCustomers();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Customer added successfully"),
                                          ),
                                        );
                                      }
                                    },
                                    title: "Add new Customer",
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                  ),
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
