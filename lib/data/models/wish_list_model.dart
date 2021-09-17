class WishListItem {
  final String id;
  final String title;
  final double price;
  final String imgUrl;
  WishListItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.imgUrl});
  WishListItem copyWith(
          {String? id, String? title, double? price, String? imgUrl}) =>
      WishListItem(
          id: id ?? this.id,
          title: title ?? this.title,
          price: price ?? this.price,
          imgUrl: imgUrl ?? this.imgUrl);
}
