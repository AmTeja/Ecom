import 'package:ecom/shared/domain/entities/product.dart';

class CartProduct {
  const CartProduct({
    required this.quantity,
    required this.product,
  });

  final int quantity;
  final Product product;
}
