import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freebie/providers/cart_provider.dart';
import 'package:freebie/providers/liked_item_provider.dart';
import 'package:freebie/providers/order_provider.dart';
import 'package:freebie/providers/price_provider.dart';
import 'package:freebie/providers/selected_address_provider.dart';
import 'package:freebie/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikedItemProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProxyProvider<CartProvider, PriceProvider>(
          create: (context) =>
              PriceProvider(cartProvider: context.read<CartProvider>()),
          update: (context, cartProvider, priceProvider) =>
              PriceProvider(cartProvider: cartProvider),
        ),
        ChangeNotifierProvider(create: (context) => SelectedAddressProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
