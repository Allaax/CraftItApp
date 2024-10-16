import 'package:bloc/bloc.dart';
import 'package:craft_it/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
// it works
class CartCubit extends Cubit<List<dynamic>> {
  CartCubit() : super([]);

  final Dio _dio = Dio();


  Future<void> addToCart(String userId, String productId, int quantity) async {

    try {
      print( " userididi $userId");
      print( " idididi $productId");


      final response = await _dio.post(
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
}