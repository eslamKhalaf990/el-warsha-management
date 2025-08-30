import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'customer_widget.dart';

class CustomerToAdd extends StatelessWidget {
  const CustomerToAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomerVM>(context);

    return FutureBuilder<List<CustomerModel>>(
      future: Provider.of<CustomerVM>(context).allCustomers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          final filteredCustomers = snapshot.data!.where((customer) {
            final name = customer.customerName.toLowerCase();
            final phone = customer.phone.toLowerCase();
            final query = Provider.of<CustomerVM>(context).searchController.text.toLowerCase();
            return name.contains(query) || phone.contains(query);
          }).toList();
          return Expanded(
            child: ListView.builder(
              itemCount: filteredCustomers.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Provider.of<OrderVM>(context, listen: false).addCustomer =
                        filteredCustomers[index];
                    },
                  child: CustomerWidget(
                    index: index,
                    name: filteredCustomers[index].customerName,
                    email: filteredCustomers[index].email,
                    address:filteredCustomers[index].address,
                    phone: filteredCustomers[index].phone, customerID: filteredCustomers[index].customerID,
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("no products yet!"),
          );
        }
      },
    );
  }
}
