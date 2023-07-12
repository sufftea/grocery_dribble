import 'package:grocery_dribble/data/product.dart';

class CartState {
  const CartState({
    this.products = const [],
  });

  final List<Product> products;

  CartState copyWith({
    List<Product>? products,
  }) {
    return CartState(
      products: products ?? this.products,
    );
  }
}
