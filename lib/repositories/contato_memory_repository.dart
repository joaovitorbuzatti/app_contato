import 'icontato_repository.dart';
import '../models/contato.dart';

class ContatoMemoryRepository extends IContatoRepository {
  final List<Contato> _contatos = [];

  @override
  Future<void> create(Contato model) async {
    _contatos.add(model);
  }

  @override
  Future<void> delete(String id) async {
    _contatos.removeWhere((contato) => contato.id == id);
  }

  @override
  Future<List<Contato>> read() async {
    await Future.delayed(Duration(seconds: 1));
    return List.unmodifiable(_contatos);
  }

  @override
  Future<void> update(Contato model) async {
    var contato = _contatos.singleWhere((e) => e.id == model.id);
    contato.nome = model.nome;
    contato.email = model.email;
  }
}
