import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCarousel extends StatefulWidget {
  final List<String> images;
  final List<String>? labels;
  final double height;
  final Function(int)? onClick;
  const AppCarousel(
      {Key? key,
      required this.images,
      this.labels,
      this.height = 200,
      this.onClick})
      : super(key: key);

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  final imageIndex = ValueNotifier(0);
  final pageController = PageController();

  @override
  initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        if (imageIndex.value < widget.images.length - 1) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else {
          // timer.cancel();
          pageController.animateTo(0,
              duration: const Duration(milliseconds: 2000),
              curve: Curves.linear);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    imageIndex.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!(imageIndex.value);
        }
      },
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            PageView(
              children: _images,
              controller: pageController,
              onPageChanged: (index) => imageIndex.value = index,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ValueListenableBuilder(
                valueListenable: imageIndex,
                builder: (_, index, __) => _imageIndication,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ValueListenableBuilder(
                valueListenable: imageIndex,
                builder: (_, int index, __) => Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.labels?[index] ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black54, blurRadius: 10)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _imageIndication {
    final indication = <Widget>[];
    for (int index = 0; index < widget.images.length; index++) {
      indication.add(
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: index == imageIndex.value ? Colors.white : null,
            border: Border.all(color: Colors.white),
          ),
        ),
      );
    }
    return Wrap(
      alignment: WrapAlignment.center,
      children: indication,
    );
  }

  List<Widget> get _images {
    final list = <Widget>[];
    for (var element in widget.images) {
      list.add(CachedNetworkImage(
        imageUrl: element,
        width: double.maxFinite,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, child, loading) {
          return SizedBox(
            height: 30,
            width: 30,
            child: Center(
                child: CircularProgressIndicator(value: loading.progress)),
          );
        },
      ));
    }

    return list;
  }
}
