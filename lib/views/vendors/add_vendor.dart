import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/default_button.dart';
import 'package:warsha_app/utils/default_text.dart';
import 'package:warsha_app/view_models/vendors_v_m.dart';

class AddVendor extends StatefulWidget {
  const AddVendor({super.key});

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  // Controllers for vendor data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _taxNumberController.dispose();
    _contactPersonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendorVM = Provider.of<VendorVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: const DefaultText(txt: "Add New Vendor", bold: true, size: 20),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT COLUMN: Identification & Contact (Flex 4)
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _buildSectionContainer(
                    context,
                    title: "Legal & Tax Info",
                    child: Column(
                      children: [
                        DefaultVendorForm(
                          title: "Tax Registration Number",
                          controller: _taxNumberController,
                          icon: Iconsax.document_text_copy,
                        ),
                        const SizedBox(height: 20),
                        DefaultVendorForm(
                          title: "Company Email",
                          controller: _emailController,
                          icon: Iconsax.sms_copy,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionContainer(
                    context,
                    title: "Location Details",
                    child: DefaultVendorForm(
                      title: "Business Address",
                      controller: _addressController,
                      icon: Iconsax.location_copy,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // RIGHT COLUMN: Vendor Details & Actions (Flex 6)
            Expanded(
              flex: 6,
              child: _buildSectionContainer(
                context,
                title: "Vendor Details",
                child: Column(
                  children: [
                    DefaultVendorForm(
                      title: "Vendor/Company Name",
                      controller: _nameController,
                      icon: Iconsax.shop_copy,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultVendorForm(
                            title: "Contact Person",
                            controller: _contactPersonController,
                            icon: Iconsax.user_octagon_copy,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DefaultVendorForm(
                            title: "Phone Number",
                            controller: _phoneController,
                            icon: Iconsax.call_calling_copy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DefaultVendorForm(
                      title: "Additional Notes",
                      controller: _notesController,
                      icon: Iconsax.note_2_copy,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 40),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              ),
                              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: DefaultButton(
                            onTap: () async {
                              Map<String, dynamic> vendorData = {
                                "name": _nameController.text,
                                "phone": _phoneController.text,
                                "email": _emailController.text,
                                "address": _addressController.text,
                                "taxNumber": _taxNumberController.text,
                                "contactPerson": _contactPersonController.text,
                                "notes": _notesController.text,
                                "isActive": true,
                              };

                              String status = await vendorVM.addVendor(vendorData);

                              if (status == "vendor_added") {
                                if (mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Vendor added successfully")),
                                  );
                                }
                              }
                            },
                            isValid: !vendorVM.isLoading,
                            isLoading: vendorVM.isLoading,
                            title: "Save Vendor",
                            margin: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer(BuildContext context, {required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
          const SizedBox(height: 25),
          child,
        ],
      ),
    );
  }
}

// Reusable Form Field to match your Product style
class DefaultVendorForm extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final int maxLines;

  const DefaultVendorForm({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: title,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1.5),
          borderRadius: BorderRadius.circular(25),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(icon, color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}