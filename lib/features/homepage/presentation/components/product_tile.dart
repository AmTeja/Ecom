import 'package:ecom/core/extensions/context_extensions.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});

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
          padding: const EdgeInsets.all(16),
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
                      AddToCartButton(product),
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
