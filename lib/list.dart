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
    //Client(name: 'John', surname: 'Doe', phone: '1 888 222 333 444', age: '18', hobbies: 'Saltar')
  ];

  @override
  Widget build(BuildContext context) {
    List ages = clients.map((e) => e.age!).toList(); //Enviar todas las edades a una lista
    List<int> intList = ages.map((s) => int.parse(s)).toList(); //Enviar todas las edades a una lista de enteros
    double average = intList.isEmpty ? 0.0 :intList.reduce((value, element) => value + element) / intList.length; //Calcular promedio edad
    var averageRounded = num.parse(average.toStringAsFixed(2));
    final List hobbiesList = clients.map((e) => e.hobbies!).toList(); //Tomar hobbies de lista clientes y enviarlos a una lista única.
    print(hobbiesList);
    print(intList);

    //Split de lista de hobbies en items en específico separados por ,
    List<String> words = [];
    for (dynamic sentence in hobbiesList) {
      if (sentence is String) {
        List<String> splitWords = sentence.split(',');
        words.addAll(splitWords);
      }
    }
    print("Palabras '$words'");

    //Contar cuántas veces se repite cada hobbie
    Map<String, int> frequencyMap = {};

    for (String hobbies in words) {
      if (frequencyMap.containsKey(hobbies)) {
        frequencyMap[hobbies] = frequencyMap[hobbies]! + 1;
      } else {
        frequencyMap[hobbies] = 1;
      }
    }


    String result = ''; //String para guardar todos los valores después del split
    for (String hobbies in frequencyMap.keys) {
      int count = frequencyMap[hobbies]!;
      String wordCountText = "El hobbie $hobbies le gusta a $count persona(s)\n";
      result += wordCountText;
    }

    const double size01 = 20.0;
    const double size02 = 25.0;
    const double size03 = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
        body: Column(
            children: <Widget>[
      Expanded(
          child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    color: Colors.red,
                    child:  Center(
                        child: Text("Usuarios: ${clients.length}",
                            style: TextStyle(fontSize: size02))))),
            Expanded(
                child: Container(
                    color: Colors.yellow,
                    child:  Center(
                        child: Text("Avg edad: ${averageRounded}",
                            style: TextStyle(fontSize: size02))))),
          ])), //Row 1/2

      Expanded(
          child: Row(children: <Widget>[
          Expanded(
          child: Container(
              color: Colors.green,
              child:  Center(
                  child: Text(result,
                      style: TextStyle(fontSize: size03))))),
            ])),

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
                    subtitle: Text(clients[index].age + " años"),
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
                    context, newContact.name + " ha sido guardado.");
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

  Client({this.name, this.surname, this.phone, this.age, this.hobbies}); //Todos los campos del cliente
}