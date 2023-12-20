import 'package:pagination_task/models/product.dart';

class ProductsProviderModel {
  final List<Product> products;
  final bool isLoading;
  final String? error;

  const ProductsProviderModel({
    required this.isLoading,
    this.products = const [],
    this.error,
  });
}
