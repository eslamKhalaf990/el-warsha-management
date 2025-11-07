import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/governorate_count.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';

class GovernorateCountList extends StatelessWidget {
  const GovernorateCountList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: FutureBuilder<List<GovernorateCountPerCustomer>>(
        future: Provider.of<CustomerVM>(context, listen: false).allCounts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No governorate data found.'));
          } else {
            final governorateCounts = snapshot.data!;
            return SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: governorateCounts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = governorateCounts[index];
                  final colorScheme = Theme.of(context).colorScheme;
                  return Container(
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.tertiary.withAlpha(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Governorate name
                          Text(
                            item.governorate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Divider line
                          Container(
                            height: 3,
                            width: 40,
                            decoration: BoxDecoration(
                              color: colorScheme.tertiary.withAlpha(50),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Orders count
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${item.count}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: colorScheme.tertiary.withAlpha(200),

                                ),
                              ),
                              const SizedBox(width: 6),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: Text(
                                  'Customer',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}