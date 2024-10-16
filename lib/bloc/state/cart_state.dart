class CartState {
  final List<Map<String, dynamic>> cartItems;
  final bool isLoading;
  final String error;

  CartState({this.cartItems = const [], this.isLoading = false, this.error = ''});
}