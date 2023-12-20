import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pagination_task/models/product.dart';
import 'package:pagination_task/providers/products_provider.dart';
import 'package:pagination_task/ui/widgets/product_tile.dart';

final scrollProvider = StateProvider<int>((ref) => 0);

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final scrollValue = ref.watch(scrollProvider);
      final response = ref.watch(productsProvider);

      return NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >= notification.metrics.maxScrollExtent / 1.5 && !response.isLoading)
            ref.read(productsProvider.notifier).getProducts();

          return false;
        },
        child: ListView(
          controller: ScrollController(
            initialScrollOffset: scrollValue.toDouble(),
          ),
          children: [
            ...products.map((e) {
              return Dismissible(
                key: Key('${e.id}'),
                direction: DismissDirection.horizontal,
                background: Container(
                  color: Colors.red.shade500,
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (direction) {
                  products.remove(e);
                },
                child: ProductTile(e),
              );
            }).toList(),
            response.isLoading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CupertinoActivityIndicator(radius: 20),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
