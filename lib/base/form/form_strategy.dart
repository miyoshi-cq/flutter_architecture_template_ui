import 'package:flutter/material.dart';

class FormStrategy<T> {
  final String title;
  final List<TextFormField> Function(T) views;
  final Future<T>? fetch;
  final Future Function() submit;
  final void Function(BuildContext) didComplete;
  final String submitButtonTitle;
  final ButtonStyle submitButtonStyle;

  FormStrategy(
    this.title,
    this.views,
    this.fetch,
    this.submit,
    this.didComplete,
    this.submitButtonTitle,
    this.submitButtonStyle,
  );
}
