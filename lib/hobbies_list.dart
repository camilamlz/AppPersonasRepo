import 'package:flutter/material.dart';

class HobbiesCheckboxList extends StatefulWidget {
  final Function(List<String>) onSaveSelectedOptions; // Define the callback function

  HobbiesCheckboxList({required this.onSaveSelectedOptions});

  @override
  _HobbiesCheckboxListState createState() => _HobbiesCheckboxListState();
}

class _HobbiesCheckboxListState extends State<HobbiesCheckboxList> {
  List<String> hobbies = [
    'Leer',
    'Escribir',
    'Pintar',
    'Tocar música',
    'Cocinar',
  ];
  List<bool> _checked = [false, false, false, false, false];

  void _saveSelectedOptions() {
    List<String> selectedOptions = [];
    for (int i = 0; i < _checked.length; i++) {
      if (_checked[i]) {
        selectedOptions.add(hobbies[i]);
      }
    }
    // Call the callback function and pass the selected options
    widget.onSaveSelectedOptions(selectedOptions);

    // Close the screen by popping the current route from the navigation stack
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
        body: Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: hobbies.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              title: Text(hobbies[index]),
              value: _checked[index],
              onChanged: (bool? value) {
                setState(() {
                  _checked[index] = value ?? false;
                });
              },
            );
          },
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: _saveSelectedOptions,
        ),
      ],
    ));
  }
}
