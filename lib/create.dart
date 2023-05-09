import 'dart:ffi';

import 'package:app_personas/list.dart';
import 'package:app_personas/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterContact extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegisterContact();

}

class _RegisterContact extends State<RegisterContact> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;
  late TextEditingController controllerAge;

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerSurname = new TextEditingController();
    controllerPhone = new TextEditingController();
    controllerAge = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ingresa tus datos "),
        ),
        body: ListView(
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

            ElevatedButton(
                onPressed: () {

                  String name = controllerName.text;
                  String surname = controllerSurname.text;
                  String phone = controllerPhone.text;
                  String age = controllerAge.text;


                  if (name.isNotEmpty &&
                      surname.isNotEmpty &&
                      phone.isNotEmpty &&
                      age.isNotEmpty) {
                    Navigator.pop(context,
                        Client(name: name, surname: surname, phone: phone, age: age));
                  }
                },

                child: const Text("Guardar")),

      ]
        ));
  }
}
