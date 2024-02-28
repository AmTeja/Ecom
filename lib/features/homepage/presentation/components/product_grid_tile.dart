import 'package:ecom/core/extensions/context_extensions.dart';
import 'package:ecom/features/homepage/presentation/components/components.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: context.bodyMedium?.copyWith(
                color: context.theme.colorScheme.secondary,
              ),
            ),
            AddToCartButton(product),
          ],
        ),
      ),
    );
  }
}
