import 'dart:convert';

import 'package:flutterando_api/data/http/http_client.dart';
import 'package:flutterando_api/data/models/produto_model.dart';

import '../data/http/exceptions.dart';

abstract class IProdutoRepository{
  Future<List<ProdutoModel>>getProdutos();
}

class ProdutoRepository implements IProdutoRepository{
  final IHttpClient client;

  ProdutoRepository({required this.client});
  @override
  Future<List<ProdutoModel>> getProdutos() async {
    final response = await client.get(url: 'https://dummyjson.com/products',
    );
    if(response.status ==200){
      final List<ProdutoModel> produtos =[];

      final body = jsonDecode(response.body);

      body['products'].map((item){
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);

      }).toList();

      return produtos;
    }
    else if (response.status == 404){
      throw NotFoundException('erro');
    }else {
      throw Exception();
    }
  }
  
}