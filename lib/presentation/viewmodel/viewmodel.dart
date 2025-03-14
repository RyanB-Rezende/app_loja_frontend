import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/models/model.dart';
import 'package:projeto_flutter/data/repository/repository.dart';

class ProdutoViewModel with ChangeNotifier {
  final ProdutoRepository _produtoRepository;
  List<Produto> _produtos = [];
  final List<Produto> _carrinho = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _token;
  String? _username;
  String? _errorMessage;

  int _paginaAtual = 1;
  bool _temMaisPaginas = false;
  int _totalPaginas = 1;

  ProdutoViewModel(this._produtoRepository);

  List<Produto> get produtos => _produtos;
  List<Produto> get carrinho => _carrinho;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get isLoggedIn => _token != null;
  String? get username => _username;
  String? get errorMessage => _errorMessage;
  bool get temMaisPaginas => _temMaisPaginas;
  int get paginaAtual => _paginaAtual;
  int get totalPaginas => _totalPaginas;

  Future<void> carregarProdutos() async {
    _isLoading = true;
    _paginaAtual = 1;
    _temMaisPaginas = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var resposta = await _produtoRepository.fetchProdutos(page: _paginaAtual);
      _produtos = resposta['produto'];

      _temMaisPaginas = resposta['nextPage'] != null;

      int count = resposta['count'];
      int produtosPorPagina = 10;
      _totalPaginas = (count / produtosPorPagina).ceil();
    } catch (e) {
      print(e);
      _errorMessage = 'Erro ao Carregar Produtos $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> carregarPagina(int pagina) async {
    _produtos = [];
    print('Carregando Pagina: $pagina');
    if (pagina <= 0 || pagina > _totalPaginas || _isLoadingMore) return;

    _paginaAtual = pagina;
    _isLoadingMore = true;
    notifyListeners();

    try {
      var resposta = await _produtoRepository.fetchProdutos(page: _paginaAtual);
      print('Produtos carregados: ${resposta['produtos']}');
      if (pagina == 1) {
        _produtos = resposta['produtos'];
      } else {
        _produtos.addAll(resposta['produtos']);
      }
      _temMaisPaginas = resposta['nextPage'] != null;
      print('Tem mais paginas: $_temMaisPaginas');
    } catch (e) {
      _errorMessage = 'Erro ao carregar Produtos: $e';
      print(_errorMessage);
    }

    _isLoadingMore = false;
    notifyListeners();
  }
}
