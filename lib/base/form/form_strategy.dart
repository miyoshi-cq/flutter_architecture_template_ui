import 'package:flutter/material.dart';

class FormStrategy {
  final String title;
  final List<TextFormField> views;
  final Future Function() submit;
  final String submitButtonTitle;
  final ButtonStyle submitButtonStyle;

  FormStrategy(
    this.title,
    this.views,
    this.submit,
    this.submitButtonTitle,
    this.submitButtonStyle,
  );
}
