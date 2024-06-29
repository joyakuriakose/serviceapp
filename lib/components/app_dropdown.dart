import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget dropDownBox({
  required Function(String?) FunctioOnchanged,
  required List<DropdownMenuItem<String>> ListItem,
  required String ListValue,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 5),
    child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        color: Colors.black,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: ListValue.isEmpty ? null : ListValue, // Set to null if empty to show hint
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.white, // Change the icon color to match your design
            ),
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select', // Placeholder text
                style: TextStyle(color: Colors.white), // Set the hint text color
              ),
            ),
            elevation: 10,
            dropdownColor: Colors.black, // Change the dropdown background color to black
            onChanged: FunctioOnchanged,
            items: ListItem,
            style: TextStyle(
              color: Colors.white, // Set the text color of the dropdown items
            ),
          ),
        ),
      ),
    ),
  );
}

