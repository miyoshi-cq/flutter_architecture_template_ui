import 'package:flutter/material.dart';

class FormStrategy {
  final String title;
  final List<Widget> views;
  final TextButton submitButton;

  FormStrategy(
    this.title,
    this.views,
    this.submitButton,
  );
}
