import 'package:ecom/features/homepage/domain/repositories/home_repository.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_usecases.g.dart';

class HomeUsecases {
  final HomeRepository repository;

  HomeUsecases(this.repository);

  Future<List<Product>> fetchProducts() async {
    return await repository.getProducts();
  }
}

@riverpod
HomeUsecases homeUsecases(HomeUsecasesRef ref) =>
    HomeUsecases(ref.read(homeRepositoryProvider));

@riverpod
Future<List<Product>> fetchProducts(FetchProductsRef ref) {
  return ref.read(homeUsecasesProvider).fetchProducts();
}
