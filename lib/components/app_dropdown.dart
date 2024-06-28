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
    padding: EdgeInsets.only( right: 5),
    child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: ListValue,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white, // Change the icon color to match your design
          ),
          hint: Text(
            '',
            style: TextStyle(color: Colors.white), // Set the hint text color
          ),
          elevation: 10,
          dropdownColor: Colors.transparent, // Make the dropdown background transparent
          onChanged: FunctioOnchanged,
          items: ListItem,
          style: TextStyle(
            color: Colors.white, // Set the text color of the dropdown items
          ),
        ),
      ),
    ),
  );
}


