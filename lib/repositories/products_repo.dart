import 'package:pagination_task/models/product.dart';
import 'package:pagination_task/services/api_service.dart';

class ProductsRepo {
  static const _productsEndPoint = '/products';

  static Future<List<Product>> getProducts(int skip, [int limit = 30]) async {
    try {
      final response = await ApiService.instance.get(
        _productsEndPoint,
        {'skip': skip, 'limit': limit},
      );

      if (response['products'] == null || response['products'] is! List) throw 'Something went wrong';


      return List.from(response['products']).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
