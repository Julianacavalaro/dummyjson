import 'package:flutter/material.dart';
import 'package:flutterando_api/data/http/http_client.dart';
import 'package:flutterando_api/pages/home/stores/produto_store.dart';
import 'package:flutterando_api/repositories/produto_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ProdutoStore produtoStore = ProdutoStore(repository: ProdutoRepository(client: HttpClient()));

  @override
    void initState(){
      super.initState();
      produtoStore.getProdutos();
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.deepPurple,
        title: const Text('Consumo de API',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          produtoStore.isLoading,
          produtoStore.erro,
          produtoStore.state,
        ]),
        builder: (context, child){
          if(produtoStore.isLoading ==true){
            return const CircularProgressIndicator();
          }
          if(produtoStore.erro.value.isNotEmpty == true ){
            return Center(
              child: Text(
                textAlign: TextAlign.center,
                produtoStore.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),

              )
            );
          }
          if(produtoStore.state.value.isEmpty){
            return const Center(
              child: Text(
                'Nenhum item na lista',
              ),
            );

          }
          else {
            return ListView.separated(itemBuilder: (_,index){
              final item = produtoStore.state.value[index];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(item.images.first,
                    fit: BoxFit.cover,),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.title,
                      
                    ),
                  ),
                ],
              );
            }, separatorBuilder: (context, index) => const SizedBox(
              height: 32,
            ),
             itemCount: produtoStore.state.value.length);
          }
        },
      ),
    );
  }
}
