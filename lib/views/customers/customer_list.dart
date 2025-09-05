import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/customer_model.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
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
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary,),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return CustomerWidget(
                  name: snapshot.data![index].name,
                  email: snapshot.data![index].email,
                  address:snapshot.data![index].address,
                  phone: snapshot.data![index].phone,
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
