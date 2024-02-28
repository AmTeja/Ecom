import 'package:ecom/core/extensions/context_extensions.dart';
import 'package:ecom/features/cart/domain/entities/cart_product.dart';
import 'package:ecom/features/cart/presentation/screens/cart_controller.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProductTile extends StatelessWidget {
  const CartProductTile(this.product, {super.key});

  final Product product;

  final double _imageSize = 125;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(right: 0),
          child: Row(
            children: [
              SizedBox(
                width: _imageSize,
                height: _imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(product.thumbnail, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      CupertinoIcons.exclamationmark_triangle,
                      size: 32,
                    );
                  }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              product.title,
                              style: context.bodyLarge,
                            ),
                          ),
                          Text('${product.rating} / 5'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: context.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.price.toString(),
                        style: context.bodyLarge?.bold,
                      ),
                      AddOrRemoveCart(product),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddOrRemoveCart extends ConsumerWidget {
  const AddOrRemoveCart(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ref.read(cartNotifierProvider.notifier).decrementQuantity(product);
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          ref.watch(cartNotifierProvider).maybeWhen(
                data: (data) {
                  final cartProduct = data.firstWhere(
                    (element) => element.product.id == product.id,
                    orElse: () => CartProduct(quantity: 0, product: product),
                  );
                  return cartProduct.quantity.toString();
                },
                orElse: () => '0',
              ),
        ),
        IconButton(
          onPressed: () {
            ref.read(cartNotifierProvider.notifier).incrementQuantity(product);
          },
          icon: const Icon(Icons.add),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            ref.read(cartNotifierProvider.notifier).removeProduct(product);
          },
          icon: const Icon(Icons.delete_outline_rounded),
        ),
      ],
    );
  }
}
