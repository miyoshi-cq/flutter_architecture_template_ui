import 'package:flutter/material.dart';

class FormStrategy {
  final String title;
  final List<Widget> views;
  final Future Function() submit;
  final String submitButtonTitle;

  FormStrategy(
    this.title,
    this.views,
    this.submit,
    this.submitButtonTitle,
  );
}
