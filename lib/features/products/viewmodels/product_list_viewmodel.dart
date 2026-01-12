import 'package:flutter/foundation.dart';
import '../../../../core/error/app_exception.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductListViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductListViewModel(this._repository);

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isMoreLoading = false;
  bool get isMoreLoading => _isMoreLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentSkip = 0;
  final int _limit = 20;
  bool _hasMore = true;
  bool get hasMore => _hasMore; // To prevent infinite scroll if end reached

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentSkip = 0;
      _hasMore = true;
      _products = [];
      _errorMessage = null;
      _isLoading = true;
      notifyListeners();
    } else {
      if (!_hasMore || _isMoreLoading) return;
      _isMoreLoading = true;
      _errorMessage = null; // Clear error on retry/next page
      notifyListeners();
    }

    try {
      final newProducts = await _repository.getProducts(
        skip: _currentSkip,
        limit: _limit,
      );

      if (newProducts.isEmpty) {
        _hasMore = false;
      } else {
        _products.addAll(newProducts);
        _currentSkip += newProducts.length;
        // Optional: if (newProducts.length < _limit) _hasMore = false;
      }
    } on AppException catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
    } finally {
      _isLoading = false;
      _isMoreLoading = false;
      notifyListeners();
    }
  }
}
