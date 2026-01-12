import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart';
import 'features/products/screens/product_list_screen.dart';
import 'features/products/viewmodels/product_detail_viewmodel.dart';
import 'features/products/viewmodels/product_list_viewmodel.dart';
import 'core/database/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  // Initialize Database just to be sure, though DI does it too
  await DatabaseService().database; // Ensure DB is ready

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<ProductListViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<ProductDetailViewModel>()),
      ],
      child: MaterialApp(
        title: 'Product Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const ProductListScreen(),
      ),
    );
  }
}
