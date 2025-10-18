import '../models/contato.dart';

abstract class IContatoRepository {
  Future<void> create(Contato model);

  Future<List<Contato>> read();

  Future<void> update(Contato model);

  Future<void> delete(String id);
}
