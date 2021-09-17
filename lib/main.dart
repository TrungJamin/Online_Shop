import 'package:flutter/material.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/provider/dark_theme_provider.dart';
import 'data/repository/cart_repository_impl.dart';
import 'data/repository/products_repository_impl.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DarkThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductRepositoryImpl(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartRepositoryImpl(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishListRepositoryImpl(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
