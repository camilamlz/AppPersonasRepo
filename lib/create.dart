import 'package:app_personas/list.dart';
import 'package:app_personas/textbox.dart';
import 'package:app_personas/hobbies_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

class RegisterContact extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegisterContact();

}

class _RegisterContact extends State<RegisterContact> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;
  late TextEditingController controllerAge;
  late TextEditingController controllerHobbies;


  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerSurname = new TextEditingController();
    controllerPhone = new TextEditingController();
    controllerAge = new TextEditingController();
    super.initState();
  }


  void _handleSaveSelectedOptions(List<String> selectedOptions) {
    // Gestionar las opciones seleccionadas aquí, como guardarlas
    controllerHobbies = new TextEditingController();
    controllerHobbies.text = selectedOptions.join('|');
    print(controllerHobbies);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Ingresa tus datos "),
        ),
        body: Column(
            children: <Widget>[
        Expanded(
        child: ListView(
          padding: const EdgeInsets.all(18.0),
          children: [
            TextField(controller: controllerName,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ingresa tu nombre",
                  icon: Icon(Icons.person)
              ),
            ),
            TextField(controller: controllerSurname,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ingresa tu apellido",
                  icon: Icon(Icons.person)
              ),
            ),
            TextField(controller: controllerPhone,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ingresa tu teléfono",
                  icon: Icon(Icons.phone_android)
              ),
              keyboardType: TextInputType.phone,
            ),
            TextField(controller: controllerAge,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingresa tu edad",
              icon: Icon(Icons.cake)
            ),
            keyboardType: TextInputType.number,
             ),
            ]
          )
        ),
        Expanded( //Creación de botón de hobbies
          child: Container(
            width: 200.0, // Set the width
            height: 200.0, // Set the height
            child: FittedBox(
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => HobbiesCheckboxList(onSaveSelectedOptions: _handleSaveSelectedOptions,) //Llamar a la clase HobbiesCheckboxList
                )
                );
              },
                backgroundColor: Colors.pink,
                label: const Text("Hobbies"),
                icon: const Icon(Icons.sunny),


              ),
            )
          )
        ),

            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String surname = controllerSurname.text;
                  String phone = controllerPhone.text;
                  String age = controllerAge.text;
                  String hobbies = controllerHobbies.text; //Mandar valores de hobbies a controlador en un texto entero.


                  if (name.isNotEmpty &&
                      surname.isNotEmpty &&
                      phone.isNotEmpty &&
                      age.isNotEmpty) {
                    Navigator.pop(context,
                        Client(name: name, surname: surname, phone: phone, age: age, hobbies: hobbies)); //Enviando todos los parámetros del cliente
                  }
                },

                child: const Text("Guardar")),




  ]));
  }
}


