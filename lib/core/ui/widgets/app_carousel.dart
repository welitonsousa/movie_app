import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatelessWidget {
  final List<String> images;
  final List<String>? labels;
  final Function(int)? onClick;
  const AppCarousel(
      {super.key, required this.images, this.labels, this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: SizedBox(
        height: 220,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          autoplayDelay: 10000,
          itemCount: images.length,
          loop: true,
          onTap: onClick,
          allowImplicitScrolling: true,
          control: const SwiperControl(),
          // itemHeight: 220,
          itemWidth: double.infinity,
          itemBuilder: (BuildContext context, int i) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: images[i],
                    height: 220,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Center(
                          child: Text("Não foi possível exibir esta imagem"));
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(labels?[i] ?? ""),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
