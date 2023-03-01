import 'package:flutter/material.dart';

class DropdownFormField extends FormField<String> {
  DropdownFormField({
    required List<String> items,
    required String initialValue,
    required TextEditingController controller,
  })  : _controller = controller,
        super(
          initialValue: initialValue,
          builder: (field) => InputDecorator(
            decoration: InputDecoration(
              labelText: "リスト",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              contentPadding: EdgeInsets.all(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: items
                    .map((value) => DropdownMenuItem(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(value)],
                        )))
                    .toList(),
                onChanged: field.didChange,
                value: controller.text,
              ),
            ),
          ),
        );

  final TextEditingController _controller;

  String get text => _controller.text;

  set text(String s) {
    _controller.text = s;
  }

  @override
  FormFieldState<String> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends FormFieldState<String> {
  DropdownFormField get _dropdownFormField => super.widget as DropdownFormField;

  @override
  void initState() {
    super.initState();
    _dropdownFormField._controller.text = _dropdownFormField.initialValue ?? "";
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    _dropdownFormField._controller.text = value ?? "";
  }
}
