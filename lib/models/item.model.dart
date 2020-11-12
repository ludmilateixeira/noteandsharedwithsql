import 'package:floor/floor.dart';

@entity
class Produto {
  @PrimaryKey(autoGenerate: true)
  int id;
  String nomeproduto;
  String pessoa;
  double preco;

  Produto({this.id, this.nomeproduto, this.pessoa, this.preco});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomeproduto = json['nomeproduto'];
    pessoa = json['pessoa'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomeproduto'] = this.nomeproduto;
    data['pessoa'] = this.pessoa;
    data['preco'] = this.preco;
    return data;
  }
}