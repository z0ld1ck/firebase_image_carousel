import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'carousel_item.dart';
import 'carousel_item_provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselItemsProvider _carouselItemsProvider = CarouselItemsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Carousel with Firebase Storage'),
      ),
      body: FutureBuilder<List<CarouselItem>>(
        future: _carouselItemsProvider.getCarouselItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return CarouselSlider(
                items: snapshot.data!
                    .map((item) => Image.network(item.imageUrl))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 5/4,
                  enableInfiniteScroll: true,
                ),
              );
            } else {
              return const Center(
                child: Text('No carousel items found.'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
