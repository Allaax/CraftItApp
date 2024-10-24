import 'package:bloc/bloc.dart';
import '../../data/models/order.dart';
import '../../data/repo/order_repo.dart';
import '../state/order_state.dart';
import '../../data/repo/customer_repo.dart';
import '../../data/models/customer.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  final Map<String, Customer?> customerCache = {}; // Cache for customer data

  OrderCubit(this.orderRepository) : super(OrderInitial());

  Future<void> fetchOrdersByUserId(String userId) async {
    emit(OrderLoading());
    try {
      final List<Order> orders = await orderRepository.getOrdersByUserId(userId);
      if (orders.isNotEmpty) {
        // Fetch customer data for each order
        for (var order in orders) {
          final customer = await CustomerRepository().getCustomerById(order.customerId);
          customerCache[order.customerId] = customer; // Cache the customer info
        }
        emit(OrderLoaded(orders));
      } else {
        emit(OrderError('No orders available.'));
      }
    } catch (e) {
      emit(OrderError('Error: $e'));
    }
  }

  Customer? getCustomer(String customerId) {
    return customerCache[customerId]; // Retrieve cached customer info
  }

  Future<void> createOrder({
    required String customerId,
    required String storeId,
    required List<Map<String, dynamic>> products,
    required double totalAmount,
    required String shippingAddress,
    required String paymentMethod,
  }) async {
    emit(OrderLoading());
    try {
      // Call your repository's create order method
      final order = await orderRepository.createOrder(
        customerId: customerId,
        storeId: storeId,
        products: products,
        totalAmount: totalAmount,
        shippingAddress: shippingAddress,
        paymentMethod: paymentMethod,
      );
      emit(OrderLoaded([order])); // Assuming you want to emit the newly created order
    } catch (e) {
      emit(OrderError('Error creating order: $e'));
    }
  }

}
