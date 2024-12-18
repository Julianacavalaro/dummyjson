import 'dart:convert';

import 'package:flutterando_api/listagem/external/http/http_client.dart';
import 'package:flutterando_api/listagem/domain/models/produto_model.dart';

import '../../external/http/exceptions.dart';

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
    if(response.statusCode == 200){
      final List<ProdutoModel> produtos =[];

      final body = jsonDecode(response.body);

      body['products'].map((item){
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);

      }).toList();

      return produtos;
    }
    else if (response.statusCode == 404){
      throw NotFoundException('A url informada n');
    }else {
      throw Exception('Não foi possível carregar o produto');
    }
  }
  
}