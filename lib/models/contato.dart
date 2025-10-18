class Contato {
  String id;
  String nome;
  String email;
  String? avatar;

  Contato({
    required this.id,
    required this.nome,
    required this.email,
    this.avatar,
  });

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'email': email};
  }
}
