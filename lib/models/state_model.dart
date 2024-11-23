class StateModel {
  final int id;
  final String sigla;
  final String nome;
  final String regiao;

  StateModel({required this.id, required this.sigla, required this.nome, required this.regiao});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      sigla: json['sigla'],
      nome: json['nome'],
      regiao: json['regiao']['nome'],
    );
  }
}