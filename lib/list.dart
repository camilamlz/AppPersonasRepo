import 'dart:ffi';

import 'package:app_personas/messages.dart';
import 'package:app_personas/update.dart';
import 'package:app_personas/create.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<Client> clients = [
    Client(name: 'John', surname: 'Doe', phone: '1 888 222 333 444', age: '18', hobbies: 'Saltar')
  ];

  @override
  Widget build(BuildContext context) {
    List ages = clients.map((e) => e.age!).toList();
    List<int> intList = ages.map((s) => int.parse(s)).toList();
    double average = intList.isEmpty ? 0.0 :intList.reduce((value, element) => value + element) / intList.length;
    List hobbies = clients.map((e) => e.hobbies!).toList();
    int startIndex = 0;
    //String sublistHobbies = <String>.from(hobbies.sublist(startIndex));
    print(hobbies);
    //print(sublistHobbies);
    //List<String> hobbiesList = sublistHobbies.split(',').map((value) => value.trim()).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40),
                  color: Colors.black,
                  child: Text(
                      "Usuarios: ${clients.length}",
                    style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                      color: Colors.lightGreenAccent,
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  color: Colors.black,
                  child: Text(
                    "Avg edad: ${average}",
                    style: const TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreenAccent,
                    ),
                  )),
              ],
            ),
          ),
          Expanded(
              child:  ListView.builder(
                itemCount: clients.length, //contador de lista de clientes
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ModifyContact(clients[index])))
                          .then((newContact) {
                        if (newContact != null) {
                          setState(() {
                            clients.removeAt(index);

                            clients.insert(index, newContact);

                            messageResponse(
                                context, newContact.name + " ha sido actualizado ${clients.length}.");
                          });
                        }
                      });
                    },
                    onLongPress: () {
                      removeClient(context, clients[index]);
                    },
                    title: Text(clients[index].name + " " + clients[index].surname),
                    subtitle: Text(clients[index].hobbies),
                    leading: CircleAvatar(
                      child: Text(clients[index].name.substring(0, 1)),
                    ),
                    trailing: const Icon(
                      Icons.update,
                      color: Colors.red,
                    ),
                  );
                },
              ),
          )
        ],
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => RegisterContact()))
              .then((newContact) {
            if (newContact != null) {
              setState(() {
                clients.add(newContact);
                messageResponse(
                    context, newContact.name + " ha sido guardado." + " con sus hobbies " + newContact.hobbies);
              });
            }
          });
        },
        tooltip: "Agregar",
        child: const Icon(Icons.add),

      ),

    );
  }

  removeClient(BuildContext context, Client client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Eliminar usuario"),
          content: Text("¿Está seguro de eliminar a " + client.name + "?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  this.clients.remove(client);
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ));
  }

  }

class Client {
  var name;
  var surname;
  var phone;
  var age;
  var hobbies;

  Client({this.name, this.surname, this.phone, this.age, this.hobbies});
}