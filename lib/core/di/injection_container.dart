import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import '../../features/products/data_sources/product_local_data_source.dart';
import '../../features/products/data_sources/product_remote_data_source.dart';
import '../../features/products/repository/product_repository.dart';
import '../../features/products/viewmodels/product_detail_viewmodel.dart';
import '../../features/products/viewmodels/product_list_viewmodel.dart';
import '../database/database_service.dart';
import '../network/dio_client.dart';

// Service Locator
final sl = GetIt.instance;

Future<void> setupLocator() async {
  // ! Core
  // Database
  final databaseService = DatabaseService();
  final database = await databaseService.database;
  sl.registerSingleton<Database>(database);

  // Network
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  // ! Features - Products
  // ViewModels
  sl.registerFactory(() => ProductListViewModel(sl()));
  sl.registerFactory(() => ProductDetailViewModel(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(sl(), sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sl()),
  );
}
