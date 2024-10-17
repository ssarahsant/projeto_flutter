import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart'; // classes que compoem os componentes da tela

main() {
  runApp(Projeto01App());
}

class Projeto01App extends StatefulWidget {
  const Projeto01App({super.key});
  @override
  Projeto01AppState createState() => Projeto01AppState();
}

class Projeto01AppState extends State<Projeto01App> {
  // extendes pq e a classe pai

  //constrtuor da claase , sempre vai estanciar aqui ou seja , sempre vai execuatr esse metodo primeiro
  //seta como esses parametros em que se comportar e mapear os vaores

//criando outro metodo , para construir a home
//para criar a classe e carregar os componentes cria o widget
// inicialização das variaveis
  String texto = "Cnstruindo App da Turma";
  String localSensor = ''; // Armazena o texto do sensor
  String tipoSensor = ''; 
  String macAdress = ''; 
  double? latitude; // ? indica que pode assumir um valor nulo
  double? longitude; // ? indica que pode assumir um valor nulo
  String responsavel = ''; 
  bool statusOperacional = true; 
  String observacao = ''; 

// controler dos input
  final TextEditingController _localcontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _tipocontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _macadresscontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _latitudecontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _longitudecontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _responsavelcontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps
  final TextEditingController _observacaocontroller =
      TextEditingController(); // privado //final: e uma contsante que vai defibir dps

  @override
  void dispose() {
    _localcontroller.dispose();
    _tipocontroller.dispose();
    _macadresscontroller.dispose();
    _latitudecontroller.dispose();
    _longitudecontroller.dispose();
    _responsavelcontroller.dispose();
    _observacaocontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Desativa a tarja de DEBUG
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "App da Turma A",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
        ),
        
        // No Main 08 usava center no body
        // O SINGLE, serve para permitir a rolagem da tela quando acabar o espaço
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),

            // Campo Local do sensor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller: _localcontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText: 'Local do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  localSensor = value; //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo tipo de sensor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller: _tipocontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText: 'Tipo do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  tipoSensor = value; //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo mac adress 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller: _macadresscontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText: 'Mac Adress', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 14, //Limite de caracteres para digitação
                onChanged: (value) {
                  macAdress = value; //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo Latitude
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller: _localcontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText: 'Latitude do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  latitude = double.tryParse(value); // Converte o valor inserido para double porque é lido em string
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo Logitude
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller: _localcontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText:
                      'Longitude do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  longitude = double.tryParse(value); //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo Resonsavel Sensor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller:
                    _responsavelcontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText:
                      'Responsavel do Sensor', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  responsavel = value; //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),

            // Campo status operacional
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text("Status Operacional"),
                  Switch(
                    value: statusOperacional,
                    onChanged: (value) {
                      setState(() {
                        statusOperacional = value;
                      });
                    }
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            // Campo Observação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //Espaço
              child: TextField(
                controller:
                    _observacaocontroller, // controlador captura o texto
                decoration: InputDecoration(
                  labelText: 'Observacao', // Nome do campo de digitação
                  border: OutlineInputBorder(),
                ),
                maxLength: 20, //Limite de caracteres para digitação
                onChanged: (value) {
                  observacao = value; //Atualiza variavel ao digitar
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  texto = localSensor.isNotEmpty
                      ? 'Local do Sensor : $localSensor\n' //Atuliza o texto ap clicar no botao
                          'Tipo: $tipoSensor\n'
                          'Mac Adress: $macAdress\n'
                          'Latitude: $latitude\n'
                          'Longitude: $longitude\n'
                          'Responsavel: $responsavel\n'
                          'Observacao: $observacao'
                      : 'Por favor, Insira um local do sensor'; //mensagem se o cmpo estiver vazio
                  // ? == if e os : == else;
                });
                // Limpar os controller dos demais inputs
                _localcontroller.clear();
                _tipocontroller.clear();
                _macadresscontroller.clear();
                _latitudecontroller.clear();
                _longitudecontroller.clear();
                _responsavelcontroller.clear();
                _observacaocontroller.clear();
              }, //Adicionaremos uma funcao de botao aqui
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
              child: Text('Clique aqui'),
            ),
            SizedBox(height: 30),
          ],
        )
        ),
        // Adicionando o rodapé
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 179, 144, 211), // Cor de fundo
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
