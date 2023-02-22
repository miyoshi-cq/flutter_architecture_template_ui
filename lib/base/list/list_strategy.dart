import 'package:flutter/material.dart';

class ListStrategy<W extends Widget, T> {
  final int rowCount;
  final String title;
  final W Function(T) itemWidgetBuilder;
  final void Function(BuildContext context, int index, T item) onTap;
  final Future<List<T>> Function(bool isAdditional) fetch;

  ListStrategy(
    this.rowCount,
    this.title,
    this.itemWidgetBuilder,
    this.onTap,
    this.fetch,
  );
}
