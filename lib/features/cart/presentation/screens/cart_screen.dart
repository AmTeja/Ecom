import 'package:ecom/core/extensions/context_extensions.dart';
import 'package:ecom/features/cart/domain/entities/cart_product.dart';
import 'package:ecom/features/cart/presentation/components/components.dart';
import 'package:ecom/features/cart/presentation/screens/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CartScreen(),
    );
  }

  int totalItems(List<CartProduct> items) =>
      items.fold(0, (prev, element) => prev + element.quantity);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Cart ${cartController.value!.isNotEmpty ? '(${totalItems(cartController.value!)})' : ''}'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(cartNotifierProvider.notifier).clearCart();
            },
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: cartController.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty!',
                style: context.headlineSmall,
                textAlign: TextAlign.center,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final product = data[index];
                    return CartProductTile(product.product);
                  },
                ),
              ),
              const _TotalPrice(),
              const _CheckoutButton(),
            ],
          );
        },
        error: (e, s) => Center(
          child: Text('Error: $e'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _TotalPrice extends ConsumerWidget {
  const _TotalPrice();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartNotifierProvider);

    return cartController.when(
      data: (data) {
        final totalPrice = data.fold<double>(0,
            (prev, element) => prev + element.product.price * element.quantity);
        final totalTax = taxPercentage * totalPrice;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Total Price'),
                  trailing: Text(totalPrice.toStringAsFixed(2)),
                ),
                ListTile(
                  title: const Text('GST (18%)'),
                  trailing: Text(totalTax.toStringAsFixed(2)),
                ),
                ListTile(
                  title: const Text('Total'),
                  trailing: Text((totalPrice + totalTax).toStringAsFixed(2)),
                ),
              ],
            ),
          ),
        );
      },
      error: (e, s) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  const _CheckoutButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {},
        child: const Text('Checkout'),
      ),
    );
  }
}
