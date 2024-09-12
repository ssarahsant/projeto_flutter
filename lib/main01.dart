import 'package:flutter/material.dart';

main() {
  // Chamando a classe que cria a home
  runApp(new Projeto01App());
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
  Projeto01App({super.key});
  // nesse exemplo o construtor serve para inicializar o atributo key
  // que pertence a super classe

  // o parametro key serve para identificar os elementos que irão compor a tela
  // e servirá mais tarde para organizar como eles irão se comportar

  // Metodo para construir o 1° Widget (home do app)
  Widget build(BuildContext context) {
    return const MaterialApp(
      // ele irá retornar um widget da como com um texto
      home: Text("Meu primeiro App em Flutter"),
    );
  }
}
