import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pagination_task/models/products_provider_model.dart';
import 'package:pagination_task/repositories/products_repo.dart';

final productsProvider = StateNotifierProvider<ProductsService, ProductsProviderModel>(
  (ref) => ProductsService(const ProductsProviderModel(isLoading: true)),
);

class ProductsService extends StateNotifier<ProductsProviderModel> {
  ProductsService(super.state) {
    getProducts();
  }

  Future<void> getProducts([bool reset = false]) async {
    if (reset) state = const ProductsProviderModel(isLoading: true);

    try {
      var products = state.products;
      state = ProductsProviderModel(isLoading: true, products: products);

      products = products + await ProductsRepo.getProducts(products.length);
      products = products.toSet().toList();

      state = ProductsProviderModel(isLoading: false, products: products);
    } catch (e) {
      state = ProductsProviderModel(isLoading: false, error: e.toString());
    }
  }
}
