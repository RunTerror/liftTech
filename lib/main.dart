import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech/View%20Model/products_provider.dart';
import 'package:tech/view/screens/home_scree.dart';
import 'package:tech/view/widgets/product_grid.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ProductProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        // ),
      ),
    );
  }
}
