import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/services/products_service.dart';
import 'package:warsha_app/view_models/product_v_m.dart';
import 'package:warsha_app/views/home.dart';

void main() {
    runApp(
      MultiProvider(
        providers: [

          //providers used for dependency injection
          Provider<ProductService>(create: (_) => ProductService()),

          //injecting user with api services
          ChangeNotifierProvider<ProductVM>(
            create: (context) => ProductVM(
              context.read<ProductService>(),
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
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'cairo',
        colorScheme: ColorScheme.light(
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
