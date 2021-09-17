import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:provider/provider.dart';

class PopularBrandsDetail extends StatefulWidget {
  static const routeName = '/popular_brands_detail_screen';
  final int routeArgs;

  const PopularBrandsDetail({Key? key, required this.routeArgs})
      : super(key: key);
  @override
  _PopularBrandsDetailState createState() => _PopularBrandsDetailState();
}

class _PopularBrandsDetailState extends State<PopularBrandsDetail> {
  late int _selectedIndex = 0;
  final padding = 8.0;
  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.routeArgs;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            children: [
              LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (int index) {
                          setState(() {
                            print("$index");
                            _selectedIndex = index;
                          });
                        },
                        minWidth: 56,
                        groupAlignment: 1.0,
                        labelType: NavigationRailLabelType.all,
                        leading: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                              ),
                            ),
                            SizedBox(
                              height: 108,
                            ),
                            RotatedBox(
                              quarterTurns: -1,
                              child: IconButton(
                                icon: Icon(Icons.tune),
                                color: Color(0xffFCCFA8),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        selectedLabelTextStyle: TextStyle(
                          color: Color(0xFFFCCFA8),
                          fontSize: 13,
                          letterSpacing: 0.8,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                        ),
                        unselectedLabelTextStyle: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.8,
                        ),
                        destinations: [
                          buildRotatedTextRailDestination("Dell", padding),
                          buildRotatedTextRailDestination("Nike", padding),
                          buildRotatedTextRailDestination("Adidas", padding),
                          buildRotatedTextRailDestination("SamSung", padding),
                          buildRotatedTextRailDestination(
                              "Lamborghini", padding),
                          buildRotatedTextRailDestination("H&M", padding),
                          buildRotatedTextRailDestination("Gucci", padding),
                          buildRotatedTextRailDestination(
                              "Fear of God", padding),
                          buildRotatedTextRailDestination("Apple", padding),
                          buildRotatedTextRailDestination("All", padding),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              ContentSpace(
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentSpace extends StatelessWidget {
  ContentSpace({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;
  final List<String> _images = [
    "https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1538688525198-9b88f6f53126?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80",
    "https://images.unsplash.com/photo-1513161455079-7dc1de15ef3e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1544457070-4cd773b4d71e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=843&q=80",
    "https://images.unsplash.com/photo-1532323544230-7191fd51bc1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1549488344-cbb6c34cf08b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
  ];
  final List<String> titles = [
    "Dell",
    "Nike",
    "Adidas",
    "Samsung",
    "Lamborghini",
    "H&M",
    "Gucci",
    "Fear of God",
    "Apple",
    "All"
  ];
  @override
  Widget build(BuildContext context) {
    final Iterable<Product>? _products;
    if (selectedIndex == titles.length - 1) {
      _products = Provider.of<ProductRepositoryImpl>(context).products;
    } else {
      _products = Provider.of<ProductRepositoryImpl>(context)
          .getProductsByBrand(titles[selectedIndex]);
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titles[selectedIndex],
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
            Expanded(
              child: _products!.length <= 0
                  ? Center(
                      child: Text("There's no products"),
                    )
                  : Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final product = _products!.elementAt(index);
                          return Container(
                            width: double.infinity,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ImageCard(
                              url: product.imgUrl,
                              price: product.price,
                              productName: product.title,
                              categoryName: product.productCategoryName,
                            ),
                          );
                        },
                        itemCount: _products.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.url,
    required this.productName,
    required this.price,
    required this.categoryName,
  }) : super(key: key);
  final String url;
  final String productName;
  final double price;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: 120,
              width: 150,
              child: ClipRRect(
                // If we use Card, we will get a default padding
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => Container(
                    margin: EdgeInsets.only(left: 30),
                    padding: const EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Icon(Icons.error),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productName,
                      maxLines: 4,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).textSelectionColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FittedBox(
                      child: Text('US $price \$',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$categoryName',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}
