import '../extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../models/sample_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.data});

  final List<Data> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: context.responiveSize(xs: 18, lg: 20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final category = data[index];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responiveSize(xs: 8.0, lg: 16.0)),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        category.image ?? 'https://via.placeholder.com/150',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                      ),
                    ),
                    Text(
                      category.name ?? 'Unknown',
                      style: TextStyle(
                        fontSize: context.responiveSize(xs: 12, lg: 14),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
