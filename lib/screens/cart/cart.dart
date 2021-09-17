import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/data/models/cart_model.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/screens/cart/components/cart_full.dart';
import 'package:online_shop_udemy/services/global_methods.dart';
import 'package:provider/provider.dart';

import 'components/cart_empty.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartRepositoryImpl>(context);
    final cartItems = cartProvider.getCartItems;
/*    final List<Cart> _products = cartItems.entries.map((e) {
      Cart productInCart = e.value.copyWith();
      return productInCart;
    }).toList();*/
    final List<Cart> _products = cartItems.values.toList();
    return Scaffold(
      body: _products.isEmpty
          ? Scaffold(body: CartEmpty())
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  "Cart (${cartItems.length})",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      MyIcons.trash,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      GlobalMethods.showConfirmDialog(
                          'Clear cart!',
                          'Your cart will be cleared!',
                          cartProvider.clearAllProductFromCart,
                          context);
                    },
                  )
                ],
              ),
              body: Container(
                margin: EdgeInsets.only(bottom: 65),
                child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final productInCart = _products[index];
                    return CartFull(
                      productInCart: productInCart,
                    );
                  },
                ),
              ),
              bottomSheet: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              ColorsConsts.gradiendLStart,
                              ColorsConsts.gradiendLEnd,
                            ],
                            stops: [0.0, 0.7],
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Checkout",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Total: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "US \$${cartProvider.totalAmount}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
