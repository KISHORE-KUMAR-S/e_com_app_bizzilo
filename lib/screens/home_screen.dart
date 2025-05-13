import '../extensions/context_extensions.dart';

import '../widgets/banner.dart';
import '../widgets/categories.dart';
import '../widgets/deals_of_the_day.dart';
import '../widgets/product_grid.dart';
import '../widgets/video_banner.dart';

import '../models/sample_model.dart';
import '../services/sample_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SampleService sampleService = SampleService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Sample E-Commerce Application")),
        body: FutureBuilder<List<Sections>>(
          future: sampleService.loadSampleData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final sections = snapshot.data!;

            return ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];

                return _buildSectionWidget(context, section.type, section.data);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionWidget(
    BuildContext context,
    String? type,
    List<Data>? data,
  ) {
    final safeData = data ?? [];

    return switch (type) {
      'banner' => Column(
        children: [
          BannerWidget(data: safeData),
          SizedBox(height: context.responiveSize(xs: 10, lg: 20)),
        ],
      ),
      'video_banner' => Column(
        children: [
          VideoBannerWidget(data: safeData),
          SizedBox(height: context.responiveSize(xs: 10, lg: 20)),
        ],
      ),

      'categories' => Column(
        children: [
          CategoriesWidget(data: safeData),
          SizedBox(height: context.responiveSize(xs: 10, lg: 20)),
        ],
      ),

      'deals_of_the_day' => Column(
        children: [
          DealsOfTheDayWidget(data: safeData),
          SizedBox(height: context.responiveSize(xs: 10, lg: 20)),
        ],
      ),

      'product_grid' => Column(
        children: [
          ProductGridWidget(data: safeData, title: 'Trending Now'),
          SizedBox(height: context.responiveSize(xs: 10, lg: 20)),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
