import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class Register extends StatefulWidget {
  final String email;

  Register({required this.email});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _senha = '';
  String _nome = '';
  AuthService authService = AuthService();

  void _registrar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authService.registrar(widget.email, _senha);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Cadastro realizado!"),
      ));
      Navigator.pop(context); // Volta para login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               TextFormField(
                decoration: InputDecoration(labelText: "Nome completo"),
                validator: (value) => value!.length >= 15 ? null : "Nome completo",
                onSaved: (value) => _nome = value!,
              ),
              Text("Email: ${widget.email}"),
              TextFormField(
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
                validator: (value) => value!.length >= 6 ? null : "Senha curta",
                onSaved: (value) => _senha = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrar,
                child: Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
