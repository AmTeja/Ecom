import 'package:ecom/features/cart/presentation/components/components.dart';
import 'package:ecom/features/cart/presentation/screens/cart_controller.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartButton extends ConsumerWidget {
  const AddToCartButton(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.watch(cartNotifierProvider);

    return cartController.when(
        data: (data) {
          final isProductInCart =
              data.any((element) => element.product == product);
          if (isProductInCart) {
            return AddOrRemoveCart(product);
          } else {
            return _AddButton(product);
          }
        },
        error: (_, __) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink());
  }
}

class _AddButton extends ConsumerWidget {
  const _AddButton(this.product);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      onPressed: () {
        try {
          ref.read(cartNotifierProvider.notifier).addProduct(product);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: const Text('Add to cart'),
    );
  }
}
