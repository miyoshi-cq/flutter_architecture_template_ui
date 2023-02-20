import 'package:flutter/material.dart';

mixin ScrollToTop {
  final scrollController = ScrollController();

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
