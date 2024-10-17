import 'package:flutter/material.dart';

void main() {
  // Chamando a classe que cria a home
  runApp(const Projeto01App());
}

// Gerencia o comportamento de todos os widgets que estão na tela
class Projeto01App extends StatefulWidget {
  const Projeto01App({super.key});
  @override
  // Função que cria para gerenciar os estados
  // chamando o método da classe stateful
  Projeto01AppState createState() => Projeto01AppState();
}

// Criação de Classe que irá herdar classe criada acima
// A classe State armazena o estado que será gerenciado para aplicar ações
class Projeto01AppState extends State<Projeto01App> {
  // Método Construtor
  // Um método que tem o mesmo nome da classe, consiste em um
  // método construtor que é executado no momento de instância da classe
  // nesse exemplo o construtor serve para inicializar o atributo key
  // que pertence a super classe

  // o parâmetro key serve para identificar os elementos que irão compor a tela
  // e servirá mais tarde para organizar como eles irão se comportar

  // Método para construir o 1° Widget (home do app)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removendo a tarja debug
      debugShowCheckedModeBanner: false,
      /* A classe Scaffold é a base para construir uma aplicação básica, composta por um header, body e footer.  
      É uma classe que permite construir os componentes que constroem uma tela. 
      Para construir a tela serão usados os componentes da classe Scaffold. */
      home: Scaffold(
        // Aqui serão criados os componentes da tela home
        // APPBAR é um atributo que constrói o header, nele pode usar uma nova classe
        appBar: AppBar(
          // Da classe AppBar está sendo utilizado os atributos de título, estilo e background
          title: const Text(
            "App da Turma A",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
        ),
        // Criação do body (um atributo do Scaffold) usando a Classe
        // Column para fazer um alinhamento vertical dos widgets que serão construídos no body
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Criação dos widgets filhos para fazer os componentes internos do body
            // Será uma lista de componentes que serão alinhados no body
            children: [
              // A medida é considerada em pixel, porém é ajustada conforme o dispositivo com base na referência inserida nesse momento
              const Text(
                "Construindo App da Turma A",
                style: TextStyle(fontSize: 24),
              ),
              // SizedBox cria um espaço entre os componentes
              const SizedBox(height: 20),
              // Criação de um botão
              ElevatedButton(
                // Função (Ação que o sistema tem quando clica no botão)
                onPressed: () {},
                // Configura o tamanho do botão
                style: ElevatedButton.styleFrom(
                  // Controla o tamanho do botão
                  minimumSize: const Size(200, 50),
                ),
                // Título do botão
                child: const Text("Clique aqui"),
              ),
            ],
          ),
        ),
        // Adicionando rodapé
        // Propriedade da home: classe para construir o
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            // child é uma espécie de div
            child: Text('Aqui é o rodapé', textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
