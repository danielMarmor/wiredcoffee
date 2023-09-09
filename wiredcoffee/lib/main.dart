import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:wiredcoffee/providers/cartAsyncProvider.dart';
import 'package:wiredcoffee/providers/userProvider.dart';
import 'package:wiredcoffee/providers/categoryProvider.dart';
import 'package:wiredcoffee/providers/productProvider.dart';
import 'package:wiredcoffee/screens/business/authWrapper.dart';
import 'package:wiredcoffee/services/localStorageService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorageService().saveStringToStorage('cartId', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartAsyncProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
        // ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: Builder(builder: (context) {
        Provider.of<CartAsyncProvider>(context).initCart();
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthWrapper(),
        );
      }),
    );
  }
}
