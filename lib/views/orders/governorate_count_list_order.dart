import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/order_governorate_count.dart';
import 'package:warsha_app/view_models/add_order_v_m.dart';

class GovernorateCountList extends StatelessWidget {
  const GovernorateCountList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(bottom: 15),
      child: FutureBuilder<List<GovernorateCountPerOrder>>(
        future: Provider.of<AddOrderVM>(context, listen: false).allCounts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No governorate data found.'));
          } else {
            final governorateCounts = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: governorateCounts.length,
              itemBuilder: (context, index) {
                final item = governorateCounts[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary.withAlpha(50),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.governorate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              width: 5,
                              height: 5,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${item.count} ',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 3,),
                              const Text(
                                'Orders',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}