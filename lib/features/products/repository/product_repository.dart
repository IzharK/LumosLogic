import '../../../../core/error/app_exception.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  ProductRepository(this._remoteDataSource, this._localDataSource);

  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 20}) async {
    try {
      final remoteProducts = await _remoteDataSource.getProducts(
        skip: skip,
        limit: limit,
      );
      await _localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } catch (e) {
      if (e is NoInternetException ||
          e is FetchDataException ||
          e is AppException) {
        // Fallback to local
        try {
          final localProducts = await _localDataSource.getLastProducts();
          if (localProducts.isNotEmpty) {
            // Very basic pagination simulation for offline
            // In a real app, we'd query the DB with offset/limit
            return localProducts;
          }
        } catch (_) {} // Ignore local fetch error, return original error
      }
      rethrow;
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final remoteProduct = await _remoteDataSource.getProduct(id);
      await _localDataSource.cacheProduct(remoteProduct);
      return remoteProduct;
    } catch (e) {
      if (e is NoInternetException ||
          e is FetchDataException ||
          e is AppException) {
        final localProduct = await _localDataSource.getProduct(id);
        if (localProduct != null) {
          return localProduct;
        }
      }
      rethrow;
    }
  }
}
