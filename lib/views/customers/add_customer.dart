import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_order/add_customer.dart'; // Ensure this path is correct
import 'package:warsha_app/utils/const_values.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/utils/navigator.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Determine screen size for responsiveness
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 800;

    return Consumer2<CustomerProvider, CustomerVM>(
      builder: (context, value, customerVM, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_2_copy, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: const DefaultText(
            txt: "Add New Customer",
            bold: true,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.yellow.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // 2. Animation: Slide up and Fade in
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            builder: (context, double val, child) {
              return Opacity(
                opacity: val,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - val)),
                  child: child,
                ),
              );
            },
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 100, // Space for AppBar
                  horizontal: isDesktop ? 0 : 20,
                ),
                child: Container(
                  // 3. Constrain width on Desktop
                  width: isDesktop ? 800 : double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Iconsax.profile_add_copy, color: Theme.of(context).colorScheme.tertiary),
                            const SizedBox(width: 10),
                            const DefaultText(
                              txt: "Customer Details",
                              size: 18,
                              bold: true,
                            ),
                          ],
                        ),
                        const Divider(height: 30, color: Colors.grey),

                        // 4. Adaptive Layout Builder
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // If constrained width is wide enough, use Row (Desktop Grid), else Column (Mobile)
                            return Column(
                              children: [
                                _buildResponsiveRow(
                                  isDesktop: isDesktop,
                                  children: [
                                    DefaultCustomerForm(
                                      title: "Full Name",
                                      controller: value.name,
                                      icon: Iconsax.profile_circle_copy,
                                    ),
                                    DefaultCustomerForm(
                                      title: "Primary Phone",
                                      controller: value.phone,
                                      icon: Iconsax.call_copy,
                                      inputType: TextInputType.phone,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _buildResponsiveRow(
                                  isDesktop: isDesktop,
                                  children: [
                                    DefaultCustomerForm(
                                      title: "Secondary Phone",
                                      controller: value.secondaryPhone,
                                      icon: Iconsax.call_add_copy,
                                      inputType: TextInputType.phone,
                                    ),
                                    _buildGovernorateDropdown(context, value),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _buildResponsiveRow(
                                  isDesktop: isDesktop,
                                  children: [
                                    DefaultCustomerForm(
                                      title: "City / Area",
                                      controller: value.city,
                                      icon: Iconsax.buildings_copy,
                                    ),
                                    DefaultCustomerForm(
                                      title: "Detailed Address",
                                      controller: value.address,
                                      icon: Iconsax.location_copy,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: DefaultButton(
                            onTap: () async {
                              // Basic Validation
                              if (value.name.text.isEmpty || value.phone.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill in Name and Phone"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              String status = await customerVM.addCustomer(
                                value.name.text,
                                value.governorate.text,
                                value.phone.text,
                                value.address.text,
                                value.secondaryPhone.text,
                                value.city.text,
                              );

                              if (status == "customer_added") {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  value.clearCustomer();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("Customer added successfully"),
                                      backgroundColor: Colors.green.shade600,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            },
                            isValid: !customerVM.isLoading,
                            isLoading: customerVM.isLoading,
                            title: "Save Customer",
                            margin: EdgeInsets.zero,
                            // Add styling to DefaultButton if possible in your utils
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to build rows on desktop and columns on mobile
  Widget _buildResponsiveRow({required bool isDesktop, required List<Widget> children}) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((w) => Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: w,
        ))).toList(),
      );
    } else {
      return Column(
        children: children.map((w) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: w,
        )).toList(),
      );
    }
  }

  Widget _buildGovernorateDropdown(BuildContext context, dynamic value) {
    return DropdownButtonFormField<String>(
      value: value.governorate.text.isNotEmpty ? value.governorate.text : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceTint,
        labelText: "Governorate",
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Iconsax.map_1_copy,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      icon: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.arrow_drop_down_rounded),
      ),
      items: [
        "القاهرة", "الجيزة", "الإسكندرية", "بورسعيد", "السويس", "الدقهلية",
        "الشرقية", "القليوبية", "كفر الشيخ", "الغربية", "المنوفية", "البحيرة",
        "الإسماعيلية", "المنيا", "بني سويف", "الفيوم", "أسيوط", "سوهاج",
        "قنا", "الأقصر", "أسوان", "البحر الأحمر", "الوادي الجديد", "مطروح",
        "شمال سيناء", "جنوب سيناء", "دمياط",
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
    );
  }
}

class DefaultCustomerForm extends StatelessWidget {
  const DefaultCustomerForm({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    this.onChange,
    this.inputType,
  });

  final String title;
  final TextEditingController controller;
  final Function(String)? onChange;
  final IconData? icon;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      keyboardType: inputType,
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceTint,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: icon != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
            : null,
        labelText: title,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}