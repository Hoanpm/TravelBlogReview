import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;

  CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  setSelectedValue() {
    setState(() {
      selectedValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(
        height: 0,
      ),
      dropdownColor: Colors.black,
      value: selectedValue,
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
          widget.onChanged(newValue);
        });
      },
      hint: Text(
        widget.hintText,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
