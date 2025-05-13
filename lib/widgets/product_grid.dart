import '../extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../models/sample_model.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key, required this.title, required this.data});

  final String title;
  final List<Data> data;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.getResponsiveValue([2, 3, 4]);

    return Container(
      padding: EdgeInsets.all(context.responiveSize(xs: 8.0, lg: 16.0)),
      child: Column(
        spacing: context.responiveSize(xs: 8, lg: 16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.responiveSize(xs: 18, lg: 20),
              fontWeight: FontWeight.bold,
            ),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: context.responiveSize(xs: 8, lg: 16),
              mainAxisSpacing: context.responiveSize(xs: 8, lg: 16),
              childAspectRatio: context.responiveSize(xs: 0.7, lg: 0.75),
            ),
            itemCount: data.length,
            itemBuilder:
                (context, index) =>
                    _buildProductItem(context, index, crossAxisCount),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    int index,
    int crossAxisCount,
  ) {
    final product = data[index];
    final itemWidth =
        (context.screenWidth - context.responiveSize(xs: 16, lg: 32)) /
        crossAxisCount;

    return Container(
      width: itemWidth,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
            child: Image.network(
              product.image ?? 'https://via.placeholder.com/200',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.responiveSize(xs: 6, lg: 8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? 'Unknown',
                  style: TextStyle(
                    fontSize: context.responiveSize(xs: 14, lg: 16),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.responiveSize(xs: 4, lg: 4)),
                Text(
                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: TextStyle(
                    fontSize: context.responiveSize(xs: 12, lg: 14),
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
