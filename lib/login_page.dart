import 'package:flutter/material.dart';
import 'package:app_personas/list.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.red,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(child: _page()),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon(),
          const SizedBox(height: 50),
          _inputField("Username", usernameController),
          const SizedBox(height: 20),
          _inputField("Password", passwordController, isPassword: true),
          const SizedBox(height: 50),
          _loginBtn(),
          const SizedBox(height: 20),
          // _extraText(),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        // usernameController.text;
        // passwordController.text;
        if (usernameController.text == 'admin' &&
            passwordController.text == '123') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage("MyHomePage")));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Contraseña Incorrecta'),
                );
              });
        }
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Ingresar",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: Color.fromARGB(255, 228, 226, 226),
        onPrimary: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  // void _mostrarAlerta(BuildContext context){
  //   showDialog(
  //     context: context,
  //     child: AlertDialog(
  //       title: Text("Contraseña Incorrecta"),
  //       content: ("hhhh"),
  //     ),
  //   ),
  // }
}
