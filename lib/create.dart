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
          title: Text("Ingresa tus datos "),
        ),
        body: ListView(
          children: [
            TextBox(controllerName, "Nombre"),
            TextBox(controllerSurname, "Apellido"),
            TextBox(controllerPhone, "Teléfono"),
            TextBox(controllerAge, "Edad"),

       /*   body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Bienvenido"),
                Text("Ingresa tus datos",style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.w800),),
                SizedBox(height: 40.0,),
                TextBox(controllerName, "Nombre"),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(2, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 10.0,),
                TextBox(controllerPhone, "Edad"),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(2, 2),
                            blurRadius: 6.0,
                            spreadRadius: 3.0
                        ),
                      ]
                  ),
                )
              ],
            ),
          ),*/
            ElevatedButton(
                onPressed: () {
                  String name = controllerName.text;
                  String surname = controllerSurname.text;
                  String phone = controllerPhone.text;
                  String age = controllerAge.text;


                  if (name.isNotEmpty &&
                      //surname.isNotEmpty &&
                      phone.isNotEmpty) {
                    Navigator.pop(context,
                        new Client(name: name, surname: surname, phone: phone, age: age));
                  }
                },
                child: Text("Guardar")),
      ]
        ));
  }
}