import 'package:flutter/material.dart';
import 'package:estudos_app/start.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Estudos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 400.0,height: 200.0,),
              TextField(
                autofocus: true,
                style: new TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Digite seu Login",
                  labelText: "Login",
                ),
              ),
              Divider(),
              TextField(
                autofocus: true,
                obscureText: true,
                style: new TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Digite sua Senha",
                  labelText: "Senha",
                ),
              ),
              Divider(),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Start()));
                  },
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
