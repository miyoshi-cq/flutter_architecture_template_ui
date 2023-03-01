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
}
