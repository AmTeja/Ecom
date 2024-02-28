import 'package:ecom/features/homepage/data/datasources/home_remote_datasource.dart';
import 'package:ecom/features/homepage/data/repositories/home_repository_impl.dart';
import 'package:ecom/shared/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

abstract class HomeRepository {
  Future<List<Product>> getProducts();
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(
    remoteDataSource: ref.read(homeRemoteDataSourceProvider),
  );
}
