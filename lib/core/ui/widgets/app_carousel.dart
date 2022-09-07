import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatelessWidget {
  final List<String> images;
  final List<String>? labels;
  final Function(int)? onClick;
  const AppCarousel({Key? key, required this.images, this.labels, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = ValueNotifier(0);
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Swiper(
            autoplay: true,
            autoplayDelay: 10000,
            itemCount: images.length,
            loop: true,
            onTap: onClick,
            onIndexChanged: (i) => index.value = i,
            allowImplicitScrolling: true,
            control: const SwiperControl(),
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(imageUrl: images[index]);
            },
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black.withOpacity(.5),
            child: ValueListenableBuilder<int>(
              valueListenable: index,
              builder: (c, i, w) {
                return Text(labels?[i] ?? "");
              },
            ),
          ),
        ],
      ),
    );
  }
}
