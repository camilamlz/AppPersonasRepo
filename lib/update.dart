import 'package:app_personas/list.dart';
import 'package:flutter/material.dart';
import 'package:app_personas/textbox.dart';

class ModifyContact extends StatefulWidget {
  final Client _client;
  ModifyContact(this._client);
  @override
  State<StatefulWidget> createState() => _ModifyContact();
}

class _ModifyContact extends State<ModifyContact> {
  late TextEditingController  controllerName;
  late TextEditingController  controllerSurname;
  late TextEditingController  controllerPhone;
  late TextEditingController controllerAge;


  @override
  void initState() {
    Client c = widget._client;
    controllerName =  new TextEditingController(text: c.name);
    controllerSurname =  new TextEditingController(text: c.surname);
    controllerPhone =  new TextEditingController(text: c.phone);
    controllerAge =  new TextEditingController(text: c.age);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Usuario"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Nombre"),
          TextBox(controllerSurname, "Apellido"),
          TextBox(controllerPhone, "Telefono"),
          TextBox(controllerAge, "Edad"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String surname = controllerSurname.text;
                String phone = controllerPhone.text;
                String age = controllerAge.text;

                if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
                  Navigator.pop(context,
                      new Client(name: name, surname: surname, phone: phone, age: age));
                }
              },
              child: Text("Guardar")),
        ],
      ),
    );
  }
}