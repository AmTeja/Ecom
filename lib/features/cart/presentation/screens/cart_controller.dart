import 'package:ecom/features/cart/domain/entities/cart_product.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

// Should be replaced with local storage

const taxPercentage = 0.18;

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  FutureOr<List<CartProduct>> build() {
    return cart;
  }

  List<CartProduct> cart = [];

  // Should use repository manipulate cart

  void incrementQuantity(Product product) {
    final index =
        state.value?.indexWhere((element) => element.product.id == product.id);
    if (index != -1 && index != null) {
      final newVal = CartProduct(
        quantity: state.value![index].quantity + 1,
        product: state.value![index].product,
      );
      state = AsyncValue.data(
        [
          ...state.value!.sublist(0, index),
          newVal,
          ...state.value!.sublist(index + 1),
        ],
      );
    }
  }

  void decrementQuantity(Product product) {
    final index =
        state.value?.indexWhere((element) => element.product.id == product.id);
    if (index != -1 && index != null) {
      if (state.value![index].quantity == 1) {
        removeProduct(product);
        return;
      }

      final newVal = CartProduct(
        quantity: state.value![index].quantity - 1,
        product: state.value![index].product,
      );
      state = AsyncValue.data(
        [
          ...state.value!.sublist(0, index),
          newVal,
          ...state.value!.sublist(index + 1),
        ],
      );
    }
  }

  void addProduct(Product product) async {
    if (state.value != null) {
      final index = state.value!
          .indexWhere((element) => element.product.id == product.id);
      if (index != -1) {
        incrementQuantity(product);
        return;
      }
    }
    state = AsyncValue.data(
        [...state.value!, CartProduct(quantity: 1, product: product)]);

    try {
      final aNotification = AndroidNotificationDetails(
        product.id.toString(),
        'Ecom',
      );

      final notificationDetails = NotificationDetails(android: aNotification);

      await FlutterLocalNotificationsPlugin().show(
          0, '${product.title} is added to cart', '', notificationDetails,
          payload: 'product_id=${product.id}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // Should use repository to add product to cart
  }

  void removeProduct(Product product) {
    state = AsyncValue.data(
      state.value!
          .where((element) => element.product.id != product.id)
          .toList(),
    );
  }

  void clearCart() {
    state = const AsyncValue.data([]);
  }
}
