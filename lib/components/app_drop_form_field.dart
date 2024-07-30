import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    required List<DropdownMenuItem<T>> items,
    required T value,
    required FormFieldSetter<T> onSaved,
    required FormFieldValidator<T> validator,
    required ValueChanged<T?> onChanged,
    required Function(String?) FunctioOnchanged,
    required List<DropdownMenuItem<String>> ListItem,
    required String ListValue,
    required TextEditingController controller,
  }) : super(
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<T> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged,
              dropdownColor: Colors.black, // Change the dropdown background color to black
            ),
          ),
          state.hasError
              ? Text(
            state.errorText!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
          )
              : Container(),
        ],
      );
    },
  );
}
