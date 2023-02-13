import 'package:flutter/material.dart';
import 'package:flutter_architecture_template_ui/base/form/form_strategy.dart';

class FormScreen extends StatelessWidget {
  final FormStrategy strategy;

  const FormScreen(this.strategy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strategy.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: strategy.views +
                [
                  TextButton(
                    onPressed: strategy.submit,
                    child: Text(strategy.submitButtonTitle),
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
