import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import '../../order_upgrading/models/customerModel.dart' show CustomerModel;
import 'customer_widget.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomerVM>(context);

    return FutureBuilder<List<CustomerModel>>(
      future: Provider.of<CustomerVM>(context).allCustomers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: SpinKitChasingDots(color: Theme.of(context).colorScheme.secondary, size: 30,),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          final filteredCustomers = snapshot.data!.where((customer) {
            final name = customer.fullName.toLowerCase();
            final phone = customer.phone.toLowerCase();
            final query = Provider.of<CustomerVM>(context).searchController.text.toLowerCase();
            return name.contains(query) || phone.contains(query);
          }).toList();
          return Expanded(
            child: ListView.builder(
              itemCount: filteredCustomers.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return CustomerWidget(
                   customerModel: filteredCustomers[index],
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("No customers yet!"),
          );
        }
      },
    );
  }
}
