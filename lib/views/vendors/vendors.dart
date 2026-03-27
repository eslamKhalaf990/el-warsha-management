import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/vendor.dart';
import 'package:warsha_app/view_models/vendors_v_m.dart';
import 'package:warsha_app/views/vendors/crud_vendors.dart';
import 'package:warsha_app/views/vendors/vendor_widget.dart';

class Vendors extends StatelessWidget {
  const Vendors({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring the provider is active
    final vendorVM = Provider.of<VendorVM>(context);

    return Column(
      children: [
        const CRUDVendor(),
        Expanded(
          child: FutureBuilder<List<Vendor>>(
            // Using the getter from your VendorVM
            future: Future.value(vendorVM.allVendors ?? []),
            builder: (context, snapshot) {
              if (vendorVM.isLoading || snapshot.connectionState == ConnectionState.waiting || vendorVM.allVendors == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: SpinKitChasingDots(
                      color: Theme.of(context).colorScheme.tertiary, // Your brand color
                      size: 30,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (vendorVM.allVendors != null && vendorVM.allVendors!.isNotEmpty) {

                return ListView.builder(
                  itemCount: vendorVM.allVendors!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return VendorWidget(
                      vendor: vendorVM.allVendors![index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No vendors found!"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
