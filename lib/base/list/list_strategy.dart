import 'package:flutter/material.dart';

class ListStrategy<W extends Widget, T> {
  final String title;

  final W Function(T) itemWidgetBuilder;

  final void Function(BuildContext context, int index, T item) onTap;

  final Future<List<T>> fetch;

  ListStrategy(
    this.title,
    this.itemWidgetBuilder,
    this.onTap,
    this.fetch,
  );
}
