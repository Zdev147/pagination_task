import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pagination_task/models/products_provider_model.dart';
import 'package:pagination_task/providers/products_provider.dart';
import 'package:pagination_task/ui/widgets/products_list.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(productsProvider);

    Widget body;
    if (response.isLoading && response.products.isEmpty)
      body = const Center(
        child: CupertinoActivityIndicator(radius: 20),
      );
    else if (response.error != null)
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 50),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  response.error!,
                  style: const TextStyle(fontSize: 15),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(productsProvider.notifier).getProducts(true);
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      );
    else
      body = ProductsList(response.products);


    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(productsProvider.notifier).getProducts(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
