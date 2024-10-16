import 'package:bloc/bloc.dart';
import 'package:craft_it/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

import '../state/cart_state.dart';

// it works
class CartCubit extends Cubit<CartState> {
  final Dio dio;

  CartCubit(this.dio) : super(CartState());


  Future<void> addToCart(String userId, String productId, int quantity) async {
    try {
      print(" userididi $userId");
      print(" idididi $productId");

      final response = await dio.post(
        '${ApiConstants.addToCart}$userId',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      if (response.statusCode == 200) {
        // Emit the updated cart state
        emit(response.data['data']['cart']);
      } else {
        print('Failed to add product to cart');
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> fetchCartItems(String userId) async {
    emit(CartState(isLoading: true)); // Set loading state

    try {
      final response = await dio.get('${ApiConstants.addToCart}$userId');
      final List<Map<String, dynamic>> cartItems =
          List<Map<String, dynamic>>.from(response.data['cart']);

      emit(CartState(cartItems: cartItems)); // Update with cart data
    } catch (e) {
      print('Error fetching cart items: $e');
      emit(CartState(error: 'Failed to fetch cart items'));
    }
  }
}
