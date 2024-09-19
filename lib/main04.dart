import 'package:flutter/material.dart';

main() {
  // Chamando a classe que cria a home
  runApp(Projeto01App());
}

// Criação de Classe que irá herdar classe do flutter
// A classe State armazena o estado
// Um widget que tem está tem movimento na tela preciza armazenr o estado atual
// Widget estaticos são componentes que não tem alteração na tela
// Essa super classe irá incorporar diferentes atributos para a subclasse
class Projeto01App extends StatelessWidget {
  // Metodo Construtor
  // Um metodo que tem o mesmo nome da classe, consiste em um
  // metodo construtor que é executado no momento de instancia da classe
  const Projeto01App({super.key});
  // nesse exemplo o construtor serve para inicializar o atributo key
  // que pertence a super classe

  // o parametro key serve para identificar os elementos que irão compor a tela
  // e servirá mais tarde para organizar como eles irão se comportar

  // Metodo para construir o 1° Widget (home do app)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removendo a tarja debug
      debugShowCheckedModeBanner: false,
      /* A classe Scaffold é a base para construir uma aplicação básica, composta por um header, body e footer.  
      É uma classe que permite construir os componentes que cosntrões um tela. 
      Para construir a tela serão usados os componentes da classe scaffold. */
      home: Scaffold(
        // Aqui serão criados os componentes da tela home
        // APPBAR é um atributo que constroe o header, nele pode usar uma nova classe
        appBar: AppBar(
          // Da classe AppBar está sendo utilizado os atributos de titulo, estilo e backgroud
          title: const Text("App da Turma A",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 110, 109, 109),
        ),
        // criação do body (um atributo do scaffold) usando a Classe
        //  Column para fazer uma alinhamento vettical dos widgets que serão construidos no body
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // criação dos widget filho para fazer os componentes interno do body
            // será uma lista de componentes que serão alinhadas no body
            children: [
              // a medida é considerada em pixel, porém é ajustada conforme o dispositivo com base na referencia inserida nesse momneto
              Text(
                "Construindo App da Turma A",
                style: TextStyle(fontSize: 24),
              ),
              // Sizedbox cria um espaço entre os componentes
              SizedBox(height: 20),
              // Criação de um botão
              ElevatedButton(
                // Função (Ação que o sistema tem quando clica no botão))
                onPressed: () {},
                // Configura o tamanho do botão
                style: ElevatedButton.styleFrom(
                  // Controla o tamanho do botão
                  minimumSize: Size(200, 50),
                ),
                // Titulo do botão
                child: Text("Clique aqui"),
              )
            ],
          ),
        ),

        // Adicionando rodapé
        // propriedade da home: classe para construir o 
        bottomNavigationBar: BottomAppBar (
          color: Color.fromARGB(255, 179, 144, 211), // cor de fundo
          child: Padding(
            padding: const EdgeInsets.all(16.0), 
            // child é uma especie de div
            child: Text (
              'Aqui é o rodapé',
              textAlign: TextAlign.center
            ),
          ),
        )
        ),
      );
  }
}
