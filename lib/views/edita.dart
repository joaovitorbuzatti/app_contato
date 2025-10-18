import 'package:contato_app/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/contato_viewmodel.dart';

class EditaPage extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  EditaPage({super.key});

  void salvar(BuildContext context, Contato contato) {
    contato.nome = _nomeController.text;
    contato.email = _emailController.text;

    Provider.of<ContatoViewModel>(context, listen: false).update(contato);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Contato contato =
        ModalRoute.of(context)!.settings.arguments as Contato;
    _nomeController.text = contato.nome;
    _emailController.text = contato.email;

    return Scaffold(
      appBar: AppBar(title: Text("Edita Contato")),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                filled: false,
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _emailController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () => salvar(context, contato),
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
