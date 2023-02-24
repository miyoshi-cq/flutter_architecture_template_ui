import 'package:flutter/material.dart';

class DropdownFormField extends StatefulWidget {
  final List<String> items;

  DropdownFormField(this.items);

  @override
  State<DropdownFormField> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState extends State<DropdownFormField> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
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
            items: widget.items
                .map((value) => DropdownMenuItem(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(value)],
                    )))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selected = value;
              });
            },
            value: _selected,
          ),
        ),
      ),
    );
  }
}
