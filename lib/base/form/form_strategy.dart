import 'package:flutter/material.dart';

class FormStrategy {
  final String title;
  final List<TextFormField> Function(dynamic) views;
  final Future<dynamic>? fetch;
  final Future Function() submit;
  final String submitButtonTitle;
  final ButtonStyle submitButtonStyle;

  FormStrategy(
    this.title,
    this.views,
    this.fetch,
    this.submit,
    this.submitButtonTitle,
    this.submitButtonStyle,
  );
}
