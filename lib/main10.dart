import 'package:flutter/material.dart';
// importação da tela criada para fazer a navegação
import 'segunda_tela01.dart';

main() {
  runApp(const Projeto01App());
}

// Material APP - consiste em fora de tudo e irá suportar as duas telas
class Projeto01App extends StatelessWidget {
  const Projeto01App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo navegação duas telas",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Projeto01AppScreen(),
    );
  }
}

class Projeto01AppScreen extends StatefulWidget {
  const Projeto01AppScreen({super.key});

  @override
  Projeto01AppState createState() => Projeto01AppState();
}

class Projeto01AppState extends State<Projeto01AppScreen> {
  String texto = 'Construindo App da Turma';
  String localSensor = ''; // Armazena o texto do sensor

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App da Turma A',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
      ),
      // CRIAÇÃO DO MENU HAMBURGUER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 179, 144, 211), // Cor de fundo
              ),
              child: const Text(
                "Menu",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Tela principal"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward),
              title: const Text("Segunda Tela"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Segunda_Tela_App(),
                  ),
                );
              },
            ),
          ],
        ),
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
            // Aqui vamos inserir a caixa de texto de input Local do Sensor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Espaço lateral
              child: TextField(
                controller: _controller, // Controlador para capturar o texto
                decoration: const InputDecoration(
                  labelText: 'Local do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, // Limite de caracteres para digitação
                onChanged: (value) {
                  localSensor = value; // Atualiza a variável ao digitar
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  texto = localSensor.isNotEmpty
                      ? 'Local do Sensor: $localSensor' // Atualiza o texto com o local do sensor
                      : 'Por favor, insira um local do sensor'; // Mensagem se o campo estiver vazio
                });
                _controller.clear();
                localSensor = '';
              }, // Adicionaremos uma função do botão aqui
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Clique Aqui'),
            ),
          ],
        ),
      ),
      // Acrescentando o rodapé
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Aqui é o rodapé', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
