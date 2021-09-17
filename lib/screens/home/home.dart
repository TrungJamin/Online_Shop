import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/data/models/category_model.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/screens/home/components/popular_product.dart';
import 'package:online_shop_udemy/screens/popular_brands_detail/popular_brands_detail.dart';
import 'package:online_shop_udemy/screens/view_products_with_options/view_products_with_options.dart';
import 'package:online_shop_udemy/ultis/get_screen_size.dart';
import 'package:provider/provider.dart';

import 'components/specified_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExactAssetImage> _carouselList = [
    ExactAssetImage("assets/images/carousel1.jfif"),
    ExactAssetImage("assets/images/carousel2.jfif"),
    ExactAssetImage("assets/images/carousel3.jfif"),
    ExactAssetImage("assets/images/carousel4.jfif"),
  ];
  List<String> _popularImages = [
    "assets/images/dell_brand.jpg",
    "assets/images/nike_brand.png",
    "assets/images/adidas_brand.png",
    "assets/images/samsung_brand.png",
    "assets/images/lamborghini_brand.jfif",
    "assets/images/hm_brand.jpg",
    "assets/images/gucci_brand.png",
    "assets/images/fog_brand.jpg",
    "assets/images/apple_brand.jfif",
  ];
  late List<Category> _categoryList;
  List<Category> _generateCategoryList() {
    return <Category>[
      const Category(
          categoryName: "Book", categoryPath: "assets/images/Book.jfif"),
      const Category(
          categoryName: "Food", categoryPath: "assets/images/FreshFood.jfif"),
      const Category(
          categoryName: "Photo",
          categoryPath: "assets/images/PhotoDevices.jfif"),
      const Category(
          categoryName: "Technology",
          categoryPath: "assets/images/Technology.jfif"),
      const Category(
          categoryName: "Clothes", categoryPath: "assets/images/clothes.jfif"),
      const Category(
          categoryName: "Furniture",
          categoryPath: "assets/images/furniture.jfif"),
      const Category(
          categoryName: "Laptops", categoryPath: "assets/images/latops.jfif"),
      const Category(
          categoryName: "Phones", categoryPath: "assets/images/phones.jfif"),
      const Category(
          categoryName: "Shoes", categoryPath: "assets/images/shoes.jfif"),
      const Category(
          categoryName: "Watches", categoryPath: "assets/images/watches.jfif"),
      const Category(
          categoryName: "Beauty & Health",
          categoryPath: "assets/images/beauty_and_health.jfif"),
      const Category(
          categoryName: "Woman", categoryPath: "assets/images/Woman.jfif"),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryList = _generateCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = GetScreenSize.getScreenSize(context);
    final _popularProducts =
        Provider.of<ProductRepositoryImpl>(context).getPopularProducts;
    return SafeArea(
      child: BackdropScaffold(
        headerHeight: size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorsConsts.starterColor,
              ColorsConsts.endColor
            ])),
          ),
          actions: <Widget>[
            IconButton(
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                    ),
                  ),
                ),
                onPressed: () {})
          ],
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        frontLayer: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 190.0,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Color(0xFFFFFFFF),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotColor: Colors.grey,
                  dotVerticalPadding: 10.0,
                  dotSpacing: 25,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: _carouselList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 190,
                padding: EdgeInsets.only(right: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryList.length,
                    itemBuilder: (context, index) {
                      final category = _categoryList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ViewProductWithOptions.routeName,
                              arguments: category.categoryName);
                        },
                        child: SpecifiedCategory(
                          name: category.categoryName,
                          imgSrc: category.categoryPath,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Popular Brands",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PopularBrandsDetail.routeName,
                          arguments: _popularImages.length,
                        );
                      },
                      child: Text(
                        "View all...",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                width: size.width * 0.95,
                child: new Swiper(
                  onTap: (index) {
                    Navigator.of(context).pushNamed(
                        PopularBrandsDetail.routeName,
                        arguments: index);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        _popularImages[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: _popularImages.length,
                  control: new SwiperControl(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Popular Products",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ViewProductWithOptions.routeName,
                          arguments: "popular",
                        );
                      },
                      child: Text(
                        "View all...",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 285,
                child: ListView.builder(
                  itemCount: _popularProducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final popularProduct = _popularProducts[index];
                    return ChangeNotifierProvider.value(
                      value: popularProduct,
                      child: PopularProduct(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
