import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/contato_viewmodel.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var viewModel = Provider.of<ContatoViewModel>(context, listen: true);
    var viewModel = context.watch<ContatoViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Contatos")),
      body:
          viewModel.isLoading
              ? Center(child: Text("Loading..."))
              : ListView(
                children:
                    viewModel.contatos
                        .map(
                          (contato) => Dismissible(
                            key: Key(contato.id),
                            onDismissed:
                                (_) => context.read<ContatoViewModel>().delete(
                                  contato.id,
                                ),
                            background: Container(color: Colors.red),
                            child: ListTile(
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    '/edita',
                                    arguments: contato,
                                  ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(contato.avatar!),
                              ),
                              title: Text(contato.nome),
                              subtitle: Text(contato.email),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        )
                        .toList(),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/novo'),
        label: Text("Novo"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
