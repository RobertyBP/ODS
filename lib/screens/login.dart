import 'package:flutter/material.dart';
import 'package:ods/screens/register.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';
  AuthService authService = AuthService();

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool isUserRegistered = authService.verificarCadastro(_email);

      if (isUserRegistered) {
        bool isAuthenticated = authService.login(_email, _senha);
        if (isAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login bem-sucedido!"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Senha incorreta."),
          ));
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register(email: _email)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.contains("@") ? null : "Email inválido",
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                validator: (value) => value!.length >= 6 ? null : "Senha curta",
                onSaved: (value) => _senha = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}