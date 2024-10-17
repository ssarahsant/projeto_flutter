import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart'; // classes que compoem os componentes da tela

void main() {
  runApp(const Projeto01App());
}

class Projeto01App extends StatefulWidget {
  const Projeto01App({super.key});

  @override
  Projeto01AppState createState() => Projeto01AppState();
}

class Projeto01AppState extends State<Projeto01App> {
  // Declaração de Variáveis
  String texto = "Construindo App da Turma";
  String localSensor = ''; // Armazena o texto do sensor

  // Variável com uma classe que gerencia o comportamento do input
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desativa a tarja de DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "App da Turma A",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              // Caixa de Texto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Local do Sensor',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 20, // Limite de caracteres para digitação
                  onChanged: (value) {
                    localSensor = value; // Atualiza variável ao digitar
                  },
                ),
              ),
              // Botão
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    texto = localSensor.isNotEmpty
                        ? 'Local do Sensor: $localSensor'
                        : 'Por favor, insira um local do sensor';
                  });
                  // Limpa a caixa de texto após enviar o dado
                  _controller.clear();
                  localSensor = '';
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Clique aqui'),
              ),
            ],
          ),
        ),
        // Rodapé
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Aqui é o Rodapé',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
