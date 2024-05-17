import 'package:flutter/material.dart';

class CustomDropDown2 extends StatefulWidget {
  const CustomDropDown2({super.key, required this.items, required this.hintText});
  final List<String> items;
  final String hintText;
  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  String? selectedValue;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      underline: Container(
        height: 0,
      ),
      icon: Icon(Icons.arrow_circle_down, size: 30,),
      dropdownColor: Colors.white,
      value: selectedValue,
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              color: Colors.black
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      hint: Text(widget.hintText,style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),),
    );
  }
}