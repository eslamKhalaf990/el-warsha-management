import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/models/shipping_zone.dart';
import 'package:warsha_app/view_models/shipping_zone_v_m.dart';
import 'package:warsha_app/views/shipping_zones/crud_shipping_zones.dart';
import 'package:warsha_app/views/shipping_zones/shipping_zone_widget.dart';

class ShippingZones extends StatelessWidget {
  const ShippingZones({super.key});

  @override
  Widget build(BuildContext context) {
    final zoneVM = Provider.of<ShippingZoneVM>(context);

    return Column(
      children: [
        const CRUDShippingZone(),
        Expanded(
          child: FutureBuilder<List<ShippingZone>>(
            future: Future.value(zoneVM.allZones ?? []),
            builder: (context, snapshot) {
              if (zoneVM.isLoading || snapshot.connectionState == ConnectionState.waiting || zoneVM.allZones == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: SpinKitChasingDots(
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (zoneVM.allZones != null && zoneVM.allZones!.isNotEmpty) {
                return ListView.builder(
                  itemCount: zoneVM.allZones!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ShippingZoneWidget(
                      zone: zoneVM.allZones![index],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No shipping zones found!"),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
