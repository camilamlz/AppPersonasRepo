import 'dart:ffi';

import 'package:app_personas/messages.dart';
import 'package:app_personas/update.dart';
import 'package:app_personas/create.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List<Client> clients = [
    Client(name: 'John', surname: 'Doe', phone: '1 888 222 333 444', age: '18')
  ];
/*
  void main(){
    List ratings = clients.map((e) => e.age!).toList();
    List<int> intList = ratings.map((s) => int.parse(s)).toList();
    double sum = ratings.fold(0, (p, c) => p + c);
    if (sum > 0) {
      double average = sum / ratings.length;
      print(average);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    List ratings = clients.map((e) => e.age!).toList();
    List<int> intList = ratings.map((s) => int.parse(s)).toList();
    double average = intList.reduce((value, element) => value + element) / intList.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 100.0,
                  child: Text(
                      "Contador: ${clients.length}",
                    style: TextStyle(fontSize: 18),
                  )),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 100.0,
                  child: Text(
                    "Avg edad: ${average}",
                    style: TextStyle(fontSize: 18),
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
                    subtitle: Text(clients[index].age),
                    leading: CircleAvatar(
                      child: Text(clients[index].name.substring(0, 1)),
                    ),
                    trailing: Icon(
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
        child: Icon(Icons.add),

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

  Client({this.name, this.surname, this.phone, this.age});
}