import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/screens/wish_list/wish_list.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;
  var top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    //    print(_scrollController.offset);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200,
                pinned: true,
                elevation: 5,
                // Use FlexibleSpace with "ExpandedHeight"
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
//                  print("top: $top");
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
//                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      // Make use of AnimatedOpacity
                      title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top <= 110 ? 1.0 : 0.0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage("assets/images/crush.jpg")),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              // 'top.toString()',
                              'Guest',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      background: Image(
                        image: AssetImage("assets/images/cat.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 8.0, bottom: 15),
                      child: UserTitle(
                        title: "User Bag",
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, WishList.routeName);
                      },
                      splashColor: Colors.red,
                      child: ListTile(
                        leading: Icon(Feather.heart),
                        title: Text("Wish List"),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                    _userLisTile(
                        title: "Cart",
                        leading: Icon(Icons.shopping_cart),
                        trailing: Icon(Icons.chevron_right),
                        context: context),
                    _userLisTile(
                        title: "My Orders",
                        leading: Icon(Icons.assignment_turned_in_rounded),
                        trailing: Icon(Icons.chevron_right),
                        context: context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 15),
                      child: UserTitle(
                        title: "User Information",
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    _userLisTile(
                        title: 'Email',
                        subTitle: 'Email sub',
                        leading: Icon(Icons.email),
                        context: context),
                    _userLisTile(
                        title: 'Phone number',
                        subTitle: '4555',
                        leading: Icon(Icons.phone),
                        context: context),
                    _userLisTile(
                        title: 'Shipping address',
                        subTitle: '',
                        leading: Icon(Icons.local_shipping),
                        context: context),
                    _userLisTile(
                        title: 'joined date',
                        subTitle: 'date',
                        leading: Icon(Icons.watch_later),
                        context: context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 15),
                      child: UserTitle(
                        title: "User Settings",
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      leading: Icon(Ionicons.md_moon),
                      onChanged: (value) {
                        setState(() {
//                          print("${themeChange.darkTheme}");
                          themeChange.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: Text('Dark Theme'),
                    ),
                    _userLisTile(
                      title: 'Logout',
                      subTitle: '',
                      onTap: () {
                        // ignore: unnecessary_statements
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      leading: Icon(
                        Icons.exit_to_app_rounded,
                      ),
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
//      print("offset: $offset");
      if (offset < defaultTopMargin - scaleStart) {
        // 36
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        // 116
        //offset between scaleStart and scaleEnd => scale down
//        print("if 2: ${(defaultTopMargin - scaleEnd - offset) / scaleEnd}");
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "camera",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  Widget _userLisTile({
    required String title,
    String subTitle = '',
    required Widget leading,
    required BuildContext context,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: subTitle.length == 0 ? null : Text(subTitle),
        // ignore: unnecessary_null_comparison
        trailing: trailing,
      ),
    );
  }
}

class UserTitle extends StatelessWidget {
  const UserTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    );
  }
}
