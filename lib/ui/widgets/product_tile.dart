import 'package:flutter/material.dart';
import 'package:pagination_task/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey,
              child: Image.network(
                product.thumbnail,
                height: 250,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'SAR ${product.price}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(color: Color(0xff006875), fontSize: 15),
                  ),
                  const Icon(
                    Icons.star,
                    color: Color(0xff006875),
                  ),
                ],
              ),
            ],
          ),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700
            ),
          ),
          Text(
            product.description,
            style: const TextStyle(
                fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
