import '../extensions/context_extensions.dart';

import '../models/sample_model.dart';
import 'package:flutter/material.dart';

class DealsOfTheDayWidget extends StatelessWidget {
  const DealsOfTheDayWidget({super.key, required this.data});

  final List<Data> data;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.getResponsiveValue([2, 3, 4]);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            "Deals of the Day",
            style: TextStyle(
              fontSize: context.responiveSize(xs: 18, lg: 20),
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: context.responiveSize(xs: 20, lg: 16),
              mainAxisSpacing: context.responiveSize(xs: 20, lg: 16),
              childAspectRatio: context.responiveSize(xs: 0.7, lg: 0.75),
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
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
                      padding: EdgeInsets.all(
                        context.responiveSize(xs: 8.0, lg: 16.0),
                      ),
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? "Unknown",
                            style: TextStyle(
                              fontSize: context.responiveSize(xs: 14, lg: 16),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(
                              fontSize: context.responiveSize(xs: 12, lg: 14),
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          if (product.discount != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              product.discount!,
                              style: TextStyle(
                                fontSize: context.responiveSize(xs: 10, lg: 12),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
