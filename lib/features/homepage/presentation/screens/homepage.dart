import 'package:ecom/core/extensions/context_extensions.dart';
import 'package:ecom/features/cart/domain/entities/cart_product.dart';
import 'package:ecom/features/cart/presentation/screens/cart_controller.dart';
import 'package:ecom/features/homepage/presentation/components/components.dart';
import 'package:ecom/features/homepage/presentation/screens/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const Homepage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecom'),
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
                onPressed: () {
                  ref.read(homepageControllerProvider.notifier).toggleView();
                },
                icon: const Icon(Icons.list));
          }),
          const _CartWithBadge(),
        ],
      ),
      body: const Catalogue(),
    );
  }
}

class _CartWithBadge extends ConsumerWidget {
  const _CartWithBadge();

  int totalItems(List<CartProduct> items) =>
      items.fold(0, (prev, element) => prev + element.quantity);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartWatcher = ref.watch(cartNotifierProvider).value;
    return Badge(
      backgroundColor: context.theme.colorScheme.tertiary,
      offset: const Offset(5, 3),
      isLabelVisible: cartWatcher?.isNotEmpty ?? false,
      alignment: Alignment.topCenter,
      label: Text(totalItems(cartWatcher!).toString()),
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
      ),
    );
  }
}
