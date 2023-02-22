import 'package:flutter/material.dart';

enum CollectionType { list, grid }

class ListStrategy<W extends Widget, T> {
  final CollectionType type;
  final String title;
  final W Function(T) itemWidgetBuilder;
  final void Function(BuildContext context, int index, T item) onTap;
  final Future<List<T>> Function(bool isAdditional) fetch;

  ListStrategy(
    this.type,
    this.title,
    this.itemWidgetBuilder,
    this.onTap,
    this.fetch,
  );
}
