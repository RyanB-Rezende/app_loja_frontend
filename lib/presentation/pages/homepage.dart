import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/viewmodel/viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarProdutos();
    });
  }

  Future<void> _carregarProdutos() async {
    final viewModel = Provider.of<ProdutoViewModel>(context, listen: false);
    try {
      await viewModel.carregarProdutos();
    } catch (error) {
      print(error);
    }
  }
}
