class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;

  const Cart(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imgUrl});
  Cart copyWith(
          {String? id,
          String? title,
          int? quantity,
          double? price,
          String? imgUrl}) =>
      Cart(
          id: id ?? this.id,
          title: title ?? this.title,
          quantity: quantity ?? this.quantity,
          price: price ?? this.price,
          imgUrl: imgUrl ?? this.imgUrl);
}

/*class Customer {
  // ...
  String name = "";
  int age = 0;
  String location = "";

  Customer(String name, int age, String location) {
    this.name = name;
    this.age = age;
    this.location = location;
  }

  // Named constructor - for multiple constructors
  Customer.withoutLocation(this.name, this.age) {
    this.name = name;
    this.age = age;
  }

  Customer.empty() {
    name = "";
    age = 0;
    location = "";
  }

  @override
  String toString() {
    return "Customer [name=${this.name},age=${this.age},location=${this.location}]";
  }
}*/
