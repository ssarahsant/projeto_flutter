import 'package:flutter/material.dart';

main() {
  runApp(Projeto01App());
}

// Material APP - consiste em fora de tudo  e irá suportar as duas telas
class Projeto01App extends StatelessWidget {
  const Projeto01App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo navegação duas telas",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Projeto01AppScreen(),
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
  String localSensor = ''; //Armazena o texto do sensor

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Desativa a tarja DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App da Turma A',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 132, 132, 136),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              //Aqui vamos inserir a caixa de texto de input Local do Sensor
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), //Espaço lateral
                child: TextField(
                  //controller: _controller, //Controlador para capturar o texto
                  decoration: InputDecoration(
                    labelText: 'Local do Sensor', //Nome do campo de digitação
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 20, //Limite de caracteres para digitação
                  onChanged: (value) {
                    localSensor = value; //Atualiza a varivavel ao digitar
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    texto = localSensor.isNotEmpty
                        ? 'Local so Sensor: $localSensor' //Atualiza o texto com o local do sensor
                        : 'Por favor, insira um local do sensor'; //Mensagem se o campo estiver vazio
                    //Atualiza o texto ao clicar no botão
                  });
                  _controller.clear();
                  localSensor = '';
                }, //Adicionaremos uma função do botão aqui
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                ),
                child: Text('Clique Aqui'),
              )
            ],
          ),
        ),
        //Acrescentando o rodapé
        bottomNavigationBar: BottomAppBar(
          color:
              const Color.fromARGB(255, 53, 52, 52), // Cor de fundo cinza claro
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Aqui é o rodapé', textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
