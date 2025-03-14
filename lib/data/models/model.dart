class Produto{
  final int idProduto;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemURL;
  final int estoque;



  Produto({
    required this.idProduto,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemURL,
    required this.estoque,
  });

  factory Produto.fromJson(Map<String,dynamic> json){
    return Produto(
      idProduto: json['idProduto'] ?? 0,// Valor padrão para id 
      nome: json['nome']?? '', //Valor padrão para nome 
      descricao: json ['descricao'] ?? '', // Valor padrão para descrição
      preco: double.tryParse(json['preco'].toString()) ?? 0.0, // Conversão segura para double
      imagemURL: json['imagemURL']?? '', //Valor padrão para ImagemUrl
      estoque: json['estoque'] ?? 0, //Valor padrão para estoque      
    );
  }
  @override
  String toString(){
    return 'Produto(idProduto: $idProduto, nome: $nome, descricao: $descricao, preco: $preco, imagemURL: $imagemURL, estoque: $estoque)';
  }
}
