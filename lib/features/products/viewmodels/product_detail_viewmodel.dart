import 'package:flutter/foundation.dart';
import '../../../../core/error/app_exception.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductDetailViewModel(this._repository);

  ProductModel? _product;
  ProductModel? get product => _product;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProduct(int id) async {
    _isLoading = true;
    _errorMessage = null;
    _product = null; // Clear previous product or keep it? Clearing for now.
    notifyListeners();

    try {
      _product = await _repository.getProduct(id);
    } on AppException catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
