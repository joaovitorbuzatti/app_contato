import 'package:flutter/material.dart';

import '../models/contato.dart';
import '../repositories/icontato_repository.dart';

class ContatoViewModel extends ChangeNotifier {
  final IContatoRepository _repository;
  bool isLoading = false;

  ContatoViewModel(this._repository);

  List<Contato> _contatos = [];

  List<Contato> get contatos => _contatos;

  void read() {
    isLoading = true;
    notifyListeners();
    _repository.read().then((items) => _contatos = items).whenComplete(() {
      isLoading = false;
      notifyListeners();
    });
  }

  void create(Contato contato) {
    _repository.create(contato).whenComplete(() => read());
    // TODO: Outra alternativa é remover o contato da lista localmente
    // _contatos.add(contato);
    // e em seguida invocar notifyListeners();
    // dessa forma a lista é atualizada imediatamente e não precisa
    // trazer toda a lista novamente do servidor.
    // Porém, é preciso verificar o status do HTTP para validar, pois,
    // se houver algum problema na adição do contato no servidor, a lista
    // ficará inconsistente, então a abordagem atual é mais segura.
    // O mesmo é válido para delete e update.
  }

  void delete(String id) {
    _repository.delete(id).whenComplete(() => read());
    // TODO: Outra alternativa é remover o contato da lista localmente
    // _contatos.removeWhere((contato) => contato.id == id);
    // e em seguida invocar notifyListeners();
  }

  void update(Contato contato) {
    _repository.update(contato).whenComplete(() => read());
  }
}
