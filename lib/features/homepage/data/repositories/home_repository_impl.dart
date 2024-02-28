import 'package:ecom/features/homepage/data/datasources/home_remote_datasource.dart';
import 'package:ecom/features/homepage/domain/repositories/home_repository.dart';
import 'package:ecom/shared/domain/entities/product.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<List<Product>> getProducts() async {
    return remoteDataSource.getProducts();
  }
}
