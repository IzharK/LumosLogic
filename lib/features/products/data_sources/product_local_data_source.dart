import 'package:sembast/sembast.dart';

import '../../../../core/error/app_exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getLastProducts();
  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel?> getProduct(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Database _database;

  // Store factory with integer keys
  final _store = intMapStoreFactory.store('products');

  ProductLocalDataSourceImpl(this._database);

  Future<Database> get _db async => _database;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final db = await _db;
    await db.transaction((txn) async {
      // Clear old data if strict "cache replacement" is needed,
      // OR merge. For pagination, we might want to keep adding?
      // Requirement: "cache last successful response", "Offline-first".
      // Usually for pagination offline, we might want to store all fetched products.
      for (var product in products) {
        await _store.record(product.id).put(txn, product.toJson());
      }
    });
  }

  @override
  Future<List<ProductModel>> getLastProducts() async {
    try {
      final db = await _db;
      final snapshots = await _store.find(
        db,
        finder: Finder(sortOrders: [SortOrder('id')]), // Basic sorting
      );

      return snapshots.map((snapshot) {
        return ProductModel.fromJson(snapshot.value);
      }).toList();
    } catch (e) {
      throw CacheException('Failed to load cached products');
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final db = await _db;
    await _store.record(product.id).put(db, product.toJson());
  }

  @override
  Future<ProductModel?> getProduct(int id) async {
    try {
      final db = await _db;
      final record = await _store.record(id).get(db);
      if (record != null) {
        return ProductModel.fromJson(record);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to load cached product');
    }
  }
}
