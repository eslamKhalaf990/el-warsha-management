import 'package:flutter/material.dart';
import 'package:warsha_app/views/customers/crud_customer.dart';
import 'customer_list.dart';
import 'governorate_counts_list.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .colorScheme
            .onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CRUDCustomer(),
          ),
          GovernorateCountList(),
          SizedBox(height: 20),
          CustomerList()
        ],
      ),
    );
  }
}

