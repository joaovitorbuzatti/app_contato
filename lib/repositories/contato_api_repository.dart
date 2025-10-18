import 'icontato_repository.dart';
import '../models/contato.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContatoApiRepository extends IContatoRepository {
  Uri? get uri =>
      Uri.parse('https://67d352228bca322cc269d115.mockapi.io/contatos');

  @override
  Future<void> create(Contato model) async {
    await http.post(
      uri!,
      body: json.encode(model.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  @override
  Future<void> delete(String id) async {
    await http.delete(uri!.replace(path: '${uri!.path}/$id'));
  }

  @override
  Future<List<Contato>> read() async {
    var response = await http.get(uri!);
    var jsonData = json.decode(response.body) as List<dynamic>;
    return jsonData.map((jsonItem) => Contato.fromJson(jsonItem)).toList();
  }

  @override
  Future<void> update(Contato model) async {
    await http.put(
      uri!.replace(path: '${uri!.path}/${model.id}'),
      body: json.encode(model.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
