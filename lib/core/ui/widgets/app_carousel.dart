import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
        alignment: AlignmentDirectional.topStart,
        children: [
          SizedBox(
            height: 220,
            child: Swiper(
              autoplay: true,
              autoplayDelay: 10000,
              itemCount: images.length,
              loop: true,
              onTap: onClick,
              onIndexChanged: (i) => index.value = i,
              allowImplicitScrolling: true,
              control: const SwiperControl(),
              // itemHeight: 220,
              itemWidth: double.infinity,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: images[index],
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
                );
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
