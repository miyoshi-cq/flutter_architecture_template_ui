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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(widget.strategy.title),
        ),
        body: FutureBuilder(
          future: widget.strategy.fetch ?? Future(() => null),
          builder: (context, snapshot) => Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.strategy
                          .views(snapshot.data)
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: element,
                            ),
                          )
                          .toList()
                        ..add(
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextButton(
                              style: widget.strategy.submitButtonStyle,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  await widget.strategy.submit();
                                  widget.strategy.didComplete(context);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(widget.strategy.submitButtonTitle),
                            ),
                          ),
                        ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: snapshot.connectionState == ConnectionState.waiting ||
                    isLoading,
                child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      );
}
