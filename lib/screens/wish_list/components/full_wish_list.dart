import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/data/models/wish_list_model.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/services/global_methods.dart';
import 'package:provider/provider.dart';

class WishListFull extends StatefulWidget {
  final WishListItem wishListItem;

  const WishListFull({Key? key, required this.wishListItem}) : super(key: key);
  @override
  _WishListFullState createState() => _WishListFullState();
}

class _WishListFullState extends State<WishListFull> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: 90,
                      child: CachedNetworkImage(
                        imageUrl: widget.wishListItem.imgUrl,
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 25),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.wishListItem.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${widget.wishListItem.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(context),
      ],
    );
  }

  Widget positionedRemove(BuildContext context) {
    final wishListProvider = Provider.of<WishListRepositoryImpl>(context);

    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: ColorsConsts.favColor,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            GlobalMethods.showConfirmDialog(
                'Remove product from wish list!',
                'Your wish product will be removed!',
                () => wishListProvider.removeProductFromWishList(
                    id: widget.wishListItem.id),
                context);
          },
        ),
      ),
    );
  }
}
