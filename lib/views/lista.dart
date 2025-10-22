import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../viewmodels/contato_viewmodel.dart';

class ListaPage extends StatelessWidget {
  const ListaPage({super.key});

  String _nomeUsuarioAtual() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return 'Usuário';
    final meta = user.userMetadata ?? {};
    final nome = (meta['full_name'] ?? meta['nome'] ?? '').toString().trim();
    if (nome.isNotEmpty) return nome;
    // fallback: parte antes do @ do email
    final email = user.email ?? 'Usuário';
    return email.contains('@') ? email.split('@').first : email;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ContatoViewModel>();
    final nome = _nomeUsuarioAtual();

    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos • $nome'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              }
            },
          )
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.contatos.length,
              itemBuilder: (context, index) {
                final contato = viewModel.contatos[index];

                Widget leading;
                if ((contato.avatar ?? '').isNotEmpty) {
                  leading = CircleAvatar(backgroundImage: NetworkImage(contato.avatar!));
                } else {
                  // se não tiver avatar, mostra iniciais
                  final iniciais = _iniciais(contato.nome);
                  leading = CircleAvatar(child: Text(iniciais));
                }

                return Dismissible(
                  key: Key(contato.id),
                  background: Container(color: Colors.red),
                  onDismissed: (_) =>
                      context.read<ContatoViewModel>().delete(contato.id),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/edita',
                      arguments: contato,
                    ),
                    leading: leading,
                    title: Text(contato.nome),
                    subtitle: Text(contato.email),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/novo'),
        label: const Text('Novo'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  String _iniciais(String nome) {
    final partes = nome.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes.first[0].toUpperCase();
    return (partes.first[0] + partes.last[0]).toUpperCase();
  }
}
