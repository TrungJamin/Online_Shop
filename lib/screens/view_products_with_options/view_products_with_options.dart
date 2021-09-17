import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/screens/feeds/components/feed_product.dart';
import 'package:provider/provider.dart';

class ViewProductWithOptions extends StatelessWidget {
  static const String routeName = "/ViewProductsWithOptions";
  const ViewProductWithOptions({Key? key, required this.optionName})
      : super(key: key);
  final String optionName;

  @override
  Widget build(BuildContext context) {
    List<Product>? _products;
    switch (optionName) {
      case "popular":
        _products =
            Provider.of<ProductRepositoryImpl>(context).getPopularProducts;
        break;
      default:
        _products = Provider.of<ProductRepositoryImpl>(context)
            .getProductsByCategory(optionName);
    }
    return SafeArea(
      child: Scaffold(
        body: _products!.length <= 0
            ? Center(
                child: Text("There's no products with $optionName category"),
              )
            : new StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(10),
                crossAxisCount: 6,
                // Get the warning if put "!" in the _products
                itemCount: _products.length,
                itemBuilder: (BuildContext context, int index) => FeedProduct(
                  product: _products![index],
                ),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(3, index.isEven ? 5 : 5),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 6.0,
              ),
      ),
    );
  }
}
