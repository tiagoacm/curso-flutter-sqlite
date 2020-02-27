class Contato{
  final int id;
  final String nome;
  final int numeroConta;

  

  Contato(this.id, this.nome, this.numeroConta);

  @override
  String toString() {
    // TODO: implement toString
    return 'Contato{id: $id, nome : $nome, numeroConta : $numeroConta}';
  }

}