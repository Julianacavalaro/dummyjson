import 'package:flutter/material.dart';
import 'package:flutterando_api/data/http/exceptions.dart';
import 'package:flutterando_api/data/models/produto_model.dart';
import 'package:flutterando_api/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;
  //variãvel reativa para o loading
final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

//variãvel reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =ValueNotifier<List<ProdutoModel>>([]);

  //variãvel reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

 Future getProdutos() async{
    isLoading.value = true;

    try{
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch(e) {
        erro.value = e.message;
    } catch(e){
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}