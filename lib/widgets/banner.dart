import 'package:carousel_slider/carousel_slider.dart'
    show CarouselOptions, CarouselSlider;
import '../extensions/context_extensions.dart';
import '../models/sample_model.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key, required this.data});

  final List<Data> data;

  @override
  Widget build(BuildContext context) {
    List<Widget> items =
        data
            .where((item) => item.imageUrl != null && item.imageUrl!.isNotEmpty)
            .map(
              (item) => Image.network(
                item.imageUrl!,
                fit: context.isDesktop ? BoxFit.cover : BoxFit.none,
                height: context.responiveSize(xs: 10, sm: 10, md: 150, lg: 200),
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      height: context.responiveSize(
                        xs: 120,
                        sm: 150,
                        md: 180,
                        lg: 200,
                      ),
                      width: context.responiveSize(
                        xs: 300,
                        sm: 400,
                        md: 600,
                        lg: 800,
                      ),
                      child: const Icon(Icons.error),
                    ),
              ),
            )
            .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
          items: items,
          options: CarouselOptions(
            height: context.screenHeight,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
          ),
        ),
      ],
    );
  }
}
