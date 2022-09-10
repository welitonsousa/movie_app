import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollVelocity {
  static ScrollController generate() {
    const velocity = 100;
    final controller = ScrollController();
    if (Platform.isWindows) {
      controller.addListener(() {
        ScrollDirection scrollDirection =
            controller.position.userScrollDirection;
        if (scrollDirection != ScrollDirection.idle) {
          double scrollEnd = controller.offset +
              (scrollDirection == ScrollDirection.reverse
                  ? velocity
                  : -velocity);
          scrollEnd = min(controller.position.maxScrollExtent,
              max(controller.position.minScrollExtent, scrollEnd));
          controller.jumpTo(scrollEnd);
        }
      });
    }
    return controller;
  }
}
