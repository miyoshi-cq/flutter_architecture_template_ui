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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.strategy.title),
      ),
      body: FutureBuilder(
        future: widget.strategy.fetch ?? Future(() => null),
        builder: (context, snapshot) {
          final submitButton = Padding(
            padding: const EdgeInsets.all(0),
            child: TextButton(
              style: widget.strategy.submitButtonStyle,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                if (formKey.currentState!.validate()) {
                  await widget.strategy.submit();
                  widget.strategy.didComplete(context);
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Text(widget.strategy.submitButtonTitle),
            ),
          );

          final edits = widget.strategy
              .views(snapshot.data)
              .map((element) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: element,
                  ))
              .toList();

          final visibleIndicator =
              snapshot.connectionState == ConnectionState.waiting || isLoading;

          return Stack(
            children: [
              Container(
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
              Visibility(
                visible: visibleIndicator,
                child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
