import 'package:dio/dio.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 20});
  Future<ProductModel> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 20}) async {
    try {
      final response = await _dioClient.get(
        '/products',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      if (response.statusCode == 200) {
        final productResponse = ProductResponse.fromJson(response.data);
        return productResponse.products;
      } else {
        throw FetchDataException(
          'Error occurred while fetching products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw NoInternetException();
      }
      throw FetchDataException('Network Error: ${e.message}');
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dioClient.get('/products/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw FetchDataException(
          'Error occurred while fetching product: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw NoInternetException();
      }
      throw FetchDataException('Network Error: ${e.message}');
    } catch (e) {
      throw FetchDataException(e.toString());
    }
  }
}
