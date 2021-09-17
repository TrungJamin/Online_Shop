import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/data/models/wish_list_model.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/services/global_methods.dart';
import 'package:provider/provider.dart';

import 'components/empty_wish_list.dart';
import 'components/full_wish_list.dart';

class WishList extends StatelessWidget {
  static const routeName = '/WishListScreen';
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListRepositoryImpl>(context);
    final List<WishListItem> _wishListItems =
        wishListProvider.getWishListItems.values.toList();
    return _wishListItems.isEmpty
        ? Scaffold(
            body: Scaffold(
              body: EmptyWishList(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('WishList (${_wishListItems.length})'),
              actions: [
                IconButton(
                  icon: Icon(
                    MyIcons.trash,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    GlobalMethods.showConfirmDialog(
                      'Clear wish list!',
                      'Your wish list will be cleared!',
                      wishListProvider.clearAllProductInWishList,
                      context,
                    );
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: _wishListItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                final wishListItem = _wishListItems[index];
                return WishListFull(
                  wishListItem: wishListItem,
                );
              },
            ),
          );
  }
}
