import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/theme_data.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/screens/auth/login/login.dart';
import 'package:online_shop_udemy/screens/auth/sign_up/sign_up.dart';
import 'package:online_shop_udemy/screens/cart/cart.dart';
import 'package:online_shop_udemy/screens/components/bottom_bar.dart';
import 'package:online_shop_udemy/screens/feeds/feeds.dart';
import 'package:online_shop_udemy/screens/landing_page/landing_page.dart';
import 'package:online_shop_udemy/screens/popular_brands_detail/popular_brands_detail.dart';
import 'package:online_shop_udemy/screens/product_details/product_details.dart';
import 'package:online_shop_udemy/screens/view_products_with_options/view_products_with_options.dart';
import 'package:online_shop_udemy/screens/wish_list/wish_list.dart';
import 'package:provider/provider.dart';

import 'data/provider/dark_theme_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getCurrentAppTheme(BuildContext context) async {
    // Tai sao phai co  listen: false? Ngay mai nghien cuu!

//    The error clearly says your declaring it out side of the Widget tree.
//    If you want to set listen to true then you must declare it inside
//    the Widget tree so that the provider knows which Widget tree has to be rebuilt when changes occur.
//
//    Setting listen to true makes the whole widget as a listener and leads to rebuilding the whole widget tree.
//    But setting listen to false will help you to rebuild a particular widget which you declared as a Consumer
//      (a consumer is a widget which listen for changes).
    final darkThemeProvider =
        Provider.of<DarkThemeProvider>(context, listen: false);
    darkThemeProvider.darkTheme =
        (await darkThemeProvider.darkThemePreferences.getTheme());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(Duration.zero, () {
      getCurrentAppTheme(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuild widget!");
    return Consumer<DarkThemeProvider>(
      builder: (context, themeData, child) {
        print("Rebuild in consumer!");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Online',
          theme: Styles.themeData(themeData.darkTheme, context),
          home: LandingPage(),
          onGenerateRoute: (routeSettings) {
            switch (routeSettings.name) {
              case PopularBrandsDetail.routeName:
                final selectedIndex = routeSettings.arguments as int;
                return MaterialPageRoute(
                  builder: (context) => PopularBrandsDetail(
                    routeArgs: selectedIndex,
                  ),
                );
              case FeedsScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => FeedsScreen(),
                );
              case WishList.routeName:
                return MaterialPageRoute(
                  builder: (context) => WishList(),
                );
              case CartScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => CartScreen(),
                );
              case ProductDetails.routeName:
                final chosenProduct = routeSettings.arguments as Product;
                return MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    chosenProduct: chosenProduct,
                  ),
                );
              case ViewProductWithOptions.routeName:
                final productCategoryName = routeSettings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => ViewProductWithOptions(
                    optionName: productCategoryName,
                  ),
                );
              case LoginScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                );
              case SignUpScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                );
              case BottomBarScreen.routeName:
                return MaterialPageRoute(
                  builder: (context) => BottomBarScreen(),
                );
            }
          },
        );
      },
    );
  }
}
