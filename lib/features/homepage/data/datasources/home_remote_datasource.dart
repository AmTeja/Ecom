import 'package:ecom/core/network/network_client.dart';
import 'package:ecom/shared/data/models/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_remote_datasource.g.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl({
    required NetworkClient client,
  }) : _client = client;

  final NetworkClient _client;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _client.get('products');
    final body = response.data as Map;
    final List<ProductModel> products = (body['products'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    return products;
  }
}

@riverpod
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  return HomeRemoteDataSourceImpl(client: NetworkClient());
}
