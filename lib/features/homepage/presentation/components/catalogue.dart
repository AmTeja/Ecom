import 'package:ecom/features/homepage/domain/usecases/home_usecases.dart';
import 'package:ecom/features/homepage/presentation/components/product_grid_tile.dart';
import 'package:ecom/features/homepage/presentation/components/product_tile.dart';
import 'package:ecom/features/homepage/presentation/screens/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Catalogue extends ConsumerWidget {
  const Catalogue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(fetchProductsProvider);
    final isList = ref.watch(homepageControllerProvider).asData?.value ?? true;
    return productsAsync.when(
      data: (data) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isList
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ProductTile(data[index]);
                  },
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ProductGridTile(data[index]);
                  },
                )),
      error: (e, s) => Text('Something went wrong!$e'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
