import 'package:flutter/material.dart';

class CustomDropDown2 extends StatefulWidget {
  CustomDropDown2({super.key, required this.items, required this.hintText, required this.onChanged});
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;

  @override
  CustomDropDown2State createState() => CustomDropDown2State();
}

class CustomDropDown2State extends State<CustomDropDown2> {
  String? selectedValue;

  setSelectedValue() {
    setState(() {
      selectedValue = null;
    });
  }
  
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
          widget.onChanged(newValue);
        });
      },
      hint: Text(widget.hintText,style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),),
    );
  }
}