import 'package:flutter/material.dart';

class DropdownFormField extends FormField<String> {
  DropdownFormField(
    List<String> items,
    String initialValue,
  ) : super(
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
                value: field.value,
              ),
            ),
          ),
        );

  final TextEditingController controller = TextEditingController();

  String? get text => controller.text;

  @override
  FormFieldState<String> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends FormFieldState<String> {
  DropdownFormField get _dropdownFormField => super.widget as DropdownFormField;

  @override
  void initState() {
    super.initState();
    _dropdownFormField.controller.text = _dropdownFormField.initialValue!;
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    _dropdownFormField.controller.text = value!;
  }
}
