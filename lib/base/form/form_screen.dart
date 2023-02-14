import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/form/form_strategy.dart';

class FormScreen extends StatefulWidget {
  final FormStrategy strategy;

  const FormScreen(this.strategy);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final edits = widget.strategy.views
        .map((element) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: element,
            ))
        .toList();

    final submitButton = Padding(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        style: widget.strategy.submitButtonStyle,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            widget.strategy.submit();
          }
        },
        child: Text(widget.strategy.submitButtonTitle),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strategy.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: edits..add(submitButton),
            ),
          ),
        ),
      ),
    );
  }
}
