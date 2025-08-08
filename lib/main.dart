import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/controllers/add_customer.dart';
import 'package:warsha_app/controllers/add_product.dart';
import 'package:warsha_app/controllers/drag_drop_controller.dart';
import 'package:warsha_app/controllers/navigation.dart';
import 'package:warsha_app/models/order_model.dart';
import 'package:warsha_app/services/customers_services.dart';
import 'package:warsha_app/services/orders_service.dart';
import 'package:warsha_app/services/products_service.dart';
import 'package:warsha_app/view_models/customers_v_m.dart';
import 'package:warsha_app/view_models/order_v_m.dart';
import 'package:warsha_app/view_models/product_v_m.dart';
import 'package:warsha_app/views/home.dart';

void main() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> DragDropController()),
          ChangeNotifierProvider(create: (_)=> ProductProvider()),
          ChangeNotifierProvider(create: (_)=> Navigation()),
          ChangeNotifierProvider(create: (_)=> CustomerProvider()),

          //providers used for dependency injection
          Provider<ProductService>(create: (_) => ProductService()),
          Provider<OrdersService>(create: (_) => OrdersService()),
          Provider<CustomerService>(create: (_) => CustomerService()),

          //injecting product with api services
          ChangeNotifierProvider<ProductVM>(
            create: (context) => ProductVM(
              context.read<ProductService>(),
            ),
          ),

          //injecting product with api services
          ChangeNotifierProvider<OrderVM>(
            create: (context) => OrderVM(
              context.read<OrdersService>(),
              OrderModel()
            ),
          ),

          //injecting customer with api services
          ChangeNotifierProvider<CustomerVM>(
            create: (context) => CustomerVM(
              context.read<CustomerService>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Warsha ERP',
      theme: ThemeData(
        fontFamily: 'cairo',
        colorScheme: ColorScheme.light(
          onPrimary: Colors.white.withAlpha(200),
          secondary: Colors.blue.shade400,
          onSurface: Colors.grey.shade700,
          onSecondary: Colors.grey.shade400,
          surface: Colors.white,
          primary: Colors.grey.shade100,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
