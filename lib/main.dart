import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecpmmerce_api/controller/addtocartcontroller.dart';
import 'package:simple_ecpmmerce_api/controller/homescreenproductcontroller.dart';
import 'package:simple_ecpmmerce_api/controller/product_detail.dart';
import 'package:simple_ecpmmerce_api/view/splash%20page/spalshscreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MyCartController().initDb();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Homescreenproductcontroller(),
    ),
    ChangeNotifierProvider(create: (context) => ProductDetailController()),
    ChangeNotifierProvider(create: (context) => MyCartController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:loginscreen(),
    );
  }
}
