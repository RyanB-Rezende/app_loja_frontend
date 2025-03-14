import 'package:projeto_flutter/data/models/model.dart';
import 'package:projeto_flutter/services/api_services.dart';

class ProdutoRepository {
  final ApiServices apiServices;

  ProdutoRepository(this.apiServices);

  Future<Map<String, dynamic>> fetchProdutos({int page = 1}) async {
    try {
      return await apiServices.getProdutos(page: page);
    } catch (e) {
      throw Exception('Erro ao Buscar Produtos: $e');
    }
  }

  Future<void> addProduto(String token, Produto produto) async {
    try {
      await apiServices.cadastrarProduto(token, Produto);
    } catch (e) {
      throw Exception('Erro ao Cadastrar Produto: $e');
    }
  }
}
