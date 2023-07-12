import 'package:bloc/bloc.dart';
import 'package:grocery_dribble/base/cart_cubit/cart_state.dart';
import 'package:grocery_dribble/base/extensions.dart';
import 'package:grocery_dribble/data/data.dart';
import 'package:grocery_dribble/data/product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(CartState(
          products: Data.products.sublist(0, 4),
        ));

  void onAddToCart(Product product) {
    emit(state.copyWith(
      products: state.products.added(product),
    ));
  }
}
