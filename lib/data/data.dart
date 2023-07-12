import 'package:grocery_dribble/data/product.dart';

class Data {
  static final products = <Product>[
    for (int i = 0; i < 7; ++i)
      Product(
        id: i,
        price: 7.99,
        name: '$i Seggiano Organic Togliatelle',
        weight: 500,
        image: 'assets/rummo_fusilli.png',
      ),
  ];
}
