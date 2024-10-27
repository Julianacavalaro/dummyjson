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
  final ProdutoStore produtoStore =
      ProdutoStore(repository: ProdutoRepository(client: HttpClient()));

  @override
  void initState() {
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
      body:
       Container(
        color: const Color.fromARGB(255, 233, 232, 248),
         child: AnimatedBuilder(
          
          animation: Listenable.merge([
            produtoStore.isLoading,
            
            produtoStore.erro,
            produtoStore.state,
          ]),
          builder: (context, child) {
            if (produtoStore.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (produtoStore.erro.value.isNotEmpty == true) {
              return Center(
                  child: Text(
                textAlign: TextAlign.center,
                produtoStore.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ));
            }
            if (produtoStore.state.value.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum item na lista',
                ),
              );
            } else {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
              
                  itemBuilder: (_, index) {
                    
                    final item = produtoStore.state.value[index];
                    return Column(
                    
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            item.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          subtitle:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'R\$ ${item.price}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(item.description,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines:  2,)
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 32,
                      ),
                  itemCount: produtoStore.state.value.length);
            }
          },
               ),
       ),
    );
  }
}
