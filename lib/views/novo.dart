import 'package:contato_app/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../viewmodels/contato_viewmodel.dart';

class NovoPage extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  NovoPage({super.key});

  void salvar(BuildContext context) {
    Contato contato = Contato(
      id: Uuid().v4(),
      nome: _nomeController.text,
      email: _emailController.text,
    );
    // Provider.of<ContatoViewModel>(context, listen: false).create(contato);
    context.read<ContatoViewModel>().create(contato);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Contato")),
      body: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: _nomeController,
              // minLines: 1,
              // maxLines: 2,
              // autocorrect: false,
              // enabled: false,
              // maxLength: 20,
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
              onPressed: () => salvar(context),
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
